import 'package:blogapp/schduleNotification/add_task_bar.dart';
import 'package:blogapp/schduleNotification/button.dart';
import 'package:blogapp/schduleNotification/input_feild.dart';
import 'package:blogapp/schduleNotification/services.dart';
import 'package:blogapp/schduleNotification/themes.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'add_task_bar.dart';
import 'notification_services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'notification.dart';

class homeschdule extends StatefulWidget {
  //final NotificationManager manager;
  final NotificationManager manager;
  final String username;
  const homeschdule({this.manager, this.username});

  @override
  _homeschduleState createState() => _homeschduleState();
}

class _homeschduleState extends State<homeschdule> {
  static const _platform = const MethodChannel('schedule_notifications_app');
  DateTime _selecteddate = DateTime.now();
  //final _taskController = Get.put();
  var notifyHelper;
  var notificationmanager;
  @override
  void initState() {
    super.initState();

    notifyHelper = NotifyHelper();

    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
             print(widget.username);
    return Scaffold(
      appBar: _appbar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          _showData(),

        ],
      ),
    );
  }

  Future getData(String username) async {
    var url = Uri.parse("http://192.168.232.2/Hi_Baby/GetData.php");
    var map = new Map<String, dynamic>();
    map["username"] = username;
    var respons = await http.post(url, body: map);

    //var respons = await http.get(url);
    var list = json.decode(respons.body);
    print(list);
    return list;
  }

  Future<String> deleteTask(String id) async {
    try {
      var ROOT = Uri.parse("http://192.168.232.2/Hi_Baby/delete.php");
      var map = new Map<String, dynamic>();

      map["id"] = id;
      final response = await http.post(ROOT, body: map);
      print("deleteTask >> Response:: ${response.body}");
      _showData();
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> updateTask(String id) async {
    var ROOT = Uri.parse("http://192.168.232.2/Hi_Baby/update.php");

    try {
      var map = new Map<String, dynamic>();
      map["id"] = id;

      final response = await http.post(ROOT, body: map);
      print("updatTask >> Response:: ${response.body}");
      _showData();
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selecteddate = date;
          });
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingstyle,
                ),
                Text(
                  "Today",
                  style: Headingstyle,
                ),
              ],
            ),
          ),
          myButton(
              label: "+ Add Task",
              onTap: () async {
                await Get.to(() => addTaskpage());
              }),
        ],
      ),
      // myButton(label: "+ Add Task", onTap: () => null),
    );
  }

  _showData() {
    return Expanded(
        child: FutureBuilder(
            future: getData(widget.username),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      // ignore: missing_return
                      itemBuilder: (context, i) {

                        print(snapshot.data[i]['StartTime']);

                        if (snapshot.data[i]['repeatt'] == 'Daily') {
                          //final date = DateFormat.jm();
                          DateTime date = DateFormat.jm()
                              .parse(snapshot.data[i]['StartTime']);

                          var myTime = DateFormat("HH:mm").format(date);
                          //print(date);
                          print(myTime);
                          String myId = snapshot.data[i]['id'];
                          int id = int.parse(myId.toString());
                          notifyHelper.scheduledNotification(
                            int.parse(myTime.toString().split(":")[0]),
                            int.parse(myTime.toString().split(":")[1]),
                            id,
                            snapshot.data[i]['title'],
                            snapshot.data[i]['note'],
                          );

                          return AnimationConfiguration.staggeredList(
                              position: i,
                              child: SlideAnimation(
                                  child: FadeInAnimation(
                                      child: Row(children: [
                                GestureDetector(
                                    onTap: () {
                                      _showBottomSheet(
                                          context,
                                          snapshot.data[i]['isCompleted'],
                                          snapshot.data[i]['id']);
                                      print("tapped");
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(bottom: 12),
                                      child: Container(
                                        padding: EdgeInsets.all(16),
                                        //  width: SizeConfig.screenWidth * 0.78,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: _getBGClr(
                                              snapshot.data[i]['color'] ?? '0'),
                                        ),
                                        child: Row(children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data[i]['title'] ??
                                                      "",
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.access_time_rounded,
                                                      color: Colors.grey[200],
                                                      size: 18,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      "${snapshot.data[i]['StartTime']}",
                                                      style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors
                                                                .grey[100]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 12),
                                                Text(
                                                  snapshot.data[i]['note'] ??
                                                      "",
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            Colors.grey[100]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            height: 60,
                                            width: 0.5,
                                            color: Colors.grey[200]
                                                .withOpacity(0.7),
                                          ),
                                          RotatedBox(
                                            quarterTurns: 3,
                                            child: Text(
                                              snapshot.data[i]['isCompleted'] ==
                                                      '1'
                                                  ? "COMPLETED"
                                                  : "TODO",
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    )),
                              ]))));
                        }
                        /* if (snapshot.data[i]['datte'][0] <
                            DateFormat.yMd().format(_selecteddate).toString()[0]) {
                                   deleteTask(snapshot.data[i]['id']);
                            }*/
                        if (snapshot.data[i]['datte'] ==
                            DateFormat.yMd().format(_selecteddate)) {
                          DateTime date = DateFormat.jm()
                              .parse(snapshot.data[i]['StartTime']);

                          var myTime = DateFormat("HH:mm").format(date);

                          String myId = snapshot.data[i]['id'];
                          int id = int.parse(myId.toString());
                          notifyHelper.scheduledNotification(
                            int.parse(myTime.toString().split(":")[0]),
                            int.parse(myTime.toString().split(":")[1]),
                            id,
                            snapshot.data[i]['title'],
                            snapshot.data[i]['note'],
                          );
                          return AnimationConfiguration.staggeredList(
                              position: i,
                              child: SlideAnimation(
                                  child: FadeInAnimation(
                                      child: Row(children: [
                                GestureDetector(
                                    onTap: () {
                                      _showBottomSheet(
                                          context,
                                          snapshot.data[i]['isCompleted'],
                                          snapshot.data[i]['id']);
                                      print("tapped");
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(bottom: 12),
                                      child: Container(
                                        padding: EdgeInsets.all(16),
                                        //  width: SizeConfig.screenWidth * 0.78,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: _getBGClr(
                                              snapshot.data[i]['color'] ?? '0'),
                                        ),
                                        child: Row(children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data[i]['title'] ??
                                                      "",
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.access_time_rounded,
                                                      color: Colors.grey[200],
                                                      size: 18,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      "${snapshot.data[i]['StartTime']}",
                                                      style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors
                                                                .grey[100]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 12),
                                                Text(
                                                  snapshot.data[i]['note'] ??
                                                      "",
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            Colors.grey[100]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            height: 60,
                                            width: 0.5,
                                            color: Colors.grey[200]
                                                .withOpacity(0.7),
                                          ),
                                          RotatedBox(
                                            quarterTurns: 3,
                                            child: Text(
                                              snapshot.data[i]['isCompleted'] ==
                                                      '1'
                                                  ? "COMPLETED"
                                                  : "TODO",
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    )),
                              ]))));
                        } else {
                          return Container();
                        }
                      })
                  : Center(child: CircularProgressIndicator());
            }));
  }

  _showBottomSheet(BuildContext context, task, id) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(top: 4),
          height: task == '1'
              ? MediaQuery.of(context).size.height * 0.24
              : MediaQuery.of(context).size.height * 0.32,
          color: Get.isDarkMode ? darkgreyClr : Colors.white,
          child: Column(children: [
            Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                )),
            Spacer(),
            task == '1'
                ? Container()
                : _bottomSheetBotton(
                    label: "Task Completed",
                    onTap: () {
                      updateTask(id);
                      _showData();
                      Get.back();
                    },
                    clr: primaryClr,
                    context: context),
            _bottomSheetBotton(
                label: "Delete Task",
                onTap: () {
                  deleteTask(id);
                  _showData();
                  print("tapped");
                  Get.back();
                },
                clr: Colors.red[300],
                context: context),
            SizedBox(
              height: 20,
            ),
            _bottomSheetBotton(
                label: "Close",
                onTap: () {
                  Get.back();
                },
                clr: Colors.red[300],
                isClose: true,
                context: context),
            SizedBox(
              height: 10,
            ),
          ])),
    );
  }

  _bottomSheetBotton({
    @required String label,
    @required Function onTap,
    @required Color clr,
    bool isClose = false,
    @required BuildContext context,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            height: 55,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: isClose == true
                      ? Get.isDarkMode
                          ? Colors.grey[600]
                          : Colors.grey[300]
                      : clr),
              borderRadius: BorderRadius.circular(20),
              color: isClose == true ? Colors.transparent : clr,
            ),
            child: Center(
              child: Text(
                label,
                style: isClose
                    ? titlestyle
                    : titlestyle.copyWith(color: Colors.white),
              ),
            )));
    ;
  }

  _getBGClr(String no) {
    switch (no) {
      case '0':
        return bluishClr;
      case '1':
        return pinkClr;
      case '2':
        return yellowClr;
      default:
        return bluishClr;
    }
  }

  _appbar() {
    return AppBar(
      elevation: 0,
      //backgroundColor: context.themes.backgroundColor,
      // context.themes.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          themeServices().switchtheme();

          notifyHelper.displayNotification(
            //await LocalNotificationManeger.showNotification();
            title: "Theme Changed",
            body: Get.isDarkMode
                ? "Activated light Theme"
                : "Activated Dark Theme",
          );
          //notifyHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          color: Get.isDarkMode ? Colors.white : Colors.black,
          size: 20,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            _showData();
          },
          child: Icon(
            Icons.refresh,
            color: Get.isDarkMode ? Colors.white : Colors.black,
            size: 20,
          ),
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
}

TextStyle get subHeadingstyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.grey[400] : Colors.grey));
}

TextStyle get Headingstyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}
