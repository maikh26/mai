import 'package:blogapp/schduleNotification/button.dart';
import 'package:blogapp/schduleNotification/homeSchdule.dart';
import 'package:blogapp/schduleNotification/input_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:blogapp/schduleNotification/themes.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class addTaskpage extends StatefulWidget {
  const addTaskpage({Key key}) : super(key: key);

  @override
  State<addTaskpage> createState() => _addTaskpageState();
}

class _addTaskpageState extends State<addTaskpage> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _notecontroller = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9.30 pm";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 0;
  String _selectedRepeat = "None";

  List<int> remindList = [0, 5, 10, 15, 20];
  List<String> repeatList = ["None", "Daily"];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appbar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Add Task",
              style: Headingstyle,
            ),
            Myinputfeild(
              title: "Title",
              hint: "Enter your title",
              controller: _titlecontroller,
            ),
            Myinputfeild(
              title: "Note",
              hint: "Enter your note",
              controller: _notecontroller,
            ),
            Myinputfeild(
              title: "Date",
              hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  _getdatefromuser();
                },
              ),
            ),
            Myinputfeild(
                        title: "Time ",
                        hint: _startTime,
                        widget: IconButton(
                            onPressed: () {
                              _getTimefromUser(isStarttime: true);
                            },
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            ))),
               
            /*Row(
              children: [
                Expanded(
                    child: Myinputfeild(
                        title: "start Date",
                        hint: _startTime,
                        widget: IconButton(
                            onPressed: () {
                              _getTimefromUser(isStarttime: true);
                            },
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            )))),
                SizedBox(
                  width: 18,
                ),
               
              ],
            ),*/
            
            Myinputfeild(
              title: "Repeat",
              hint: "$_selectedRepeat ",
              widget: DropdownButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                style: subtitlestyle,
                underline: Container(
                  height: 0,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    _selectedRepeat = newValue;
                  });
                },
                items: repeatList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.grey)));
                }).toList(),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Color",
                      style: titlestyle,
                    ),
                    SizedBox(height: 8.0),
                    Wrap(
                      children: List<Widget>.generate(3, (int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: index == 0
                                  ? primaryClr
                                  : index == 1
                                      ? pinkClr
                                      : yellowClr,
                              child: _selectedColor == index
                                  ? Icon(Icons.done,
                                      color: Colors.white, size: 16)
                                  : Container(),
                            ),
                          ),
                        );
                      }),
                    )
                  ],
                ),
                myButton(
                    label: "Creat Task",
                    onTap: () {
                      _addTask();
                      // Get.back();
                    }),
              ],
            )
          ]),
        ),
      ),
    );
  }

  _appbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Get.isDarkMode ? Colors.white : Colors.black,
          size: 20,
        ),
      ),
      actions: [
        Icon(
          Icons.person,
          color: Get.isDarkMode ? Colors.white : Colors.black,
          size: 20,
        ),

        /* CircleAvatar(
          backgroundImage: AssetImage("assets/images/pr.jpg"),
        ),*/
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _getdatefromuser() async {
    DateTime _pickerdate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2022));

    if (_pickerdate != null) {
      setState(() {
        _selectedDate = _pickerdate;
      });
    } else {
      print("it's null or somthing is wrong");
    }
  }

  _getTimefromUser({bool isStarttime}) async {
    var _pickedTime = await _showTimepicker();
    String _formatedtime = _pickedTime.format(context);
    if (_pickedTime == null) {
      print("Time canceld");
    } else if (isStarttime == true) {
      setState(() {
        _startTime = _formatedtime;
      });
    } else if (isStarttime == false) {
      setState(() {
        _endTime = _formatedtime;
      });
    }
  }

  _showTimepicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split("")[0])));
  }

  _addTask() async {
    if (_titlecontroller.text.isEmpty || _notecontroller.text.isEmpty) {
      Get.snackbar("Required", "All fields are required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          icon: Icon(Icons.warning_amber_rounded));
    } else {
      var url = Uri.parse("http://192.168.232.2/tasks/tasks.php");

      var map = Map<String, String>();
      map['title'] = _titlecontroller.text;
      map['note'] = _notecontroller.text;
      map['isCompleted'] = "0";
      map['datte'] = DateFormat.yMd().format(_selectedDate).toString();
      map['startTime'] = _startTime;
      map['endTime'] = _endTime;
      map['color'] = _selectedColor.toString();
      map['remind'] = _selectedRemind.toString();
      map['repeatt'] = _selectedRepeat;
      var response = await http.post(url, body: map);

      print('addTask Response: ${response.body}');
      Get.back();
    }
  }
}
