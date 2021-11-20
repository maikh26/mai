// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:blogapp/Pages/homepageNew.dart';
import 'package:blogapp/Screens/dashboard_screen.dart';
import 'package:blogapp/group.dart';
import 'package:intl/intl.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:blogapp/Pages/Home.dart';
import 'package:http/http.dart' as http;

// ignore: unused_import
import 'package:blogapp/widgets/ToggleButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

import '../age.dart';

// ignore: unused_import

class CreatProfile extends StatefulWidget {
  final String username;
  final String email;
  final String pass;
  CreatProfile({Key key, @required this.username, @required this.email, @required this.pass})
      : super(key: key);

  @override
  _CreatProfileState createState() => _CreatProfileState();
}

class _CreatProfileState extends State<CreatProfile> {
  //DateTime selectedBithDate = DateTime.now().subtract(Duration(days: 1));

  // DateTime selectedCurrentDate = DateTime.now();
  DateTime currentDate = DateTime.now();
  final networkHandler = NetworkHandler();

  bool circular = false;
  PickedFile _imageFile;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _type = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _about = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  //DateTime selectedBithDate1 = DateTime.now().subtract(Duration(days: 1));
  //DateTime selectedCurrentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String username = widget.username;
    String email = widget.email;
        String pass = widget.pass;


    return Scaffold(
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 55),
          children: <Widget>[
            imageProfile(),
            SizedBox(
              height: 20,
            ),
            nameTextField(),
            SizedBox(
              height: 20,
            ),
            togglebutton(),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            dob(),
            SizedBox(
              height: 20,
            ),
            age(),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  circular = true;
                });
                if (_globalkey.currentState.validate()) {
                  var imageResponse = await networkHandler.patchImage(
                      "/profile/add/image", _imageFile.path);
                  if (imageResponse.statusCode == 200) {
                    setState(() {
                      circular = false;
                    });
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => group()),
                        (route) => false);
                  }
                } else {
                  setState(() {
                    circular = false;
                  });
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => group()),
                      (route) => false);
                }
              },
              child: Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: () {
                      addbaby(username, email,pass,_name.text, _type.text, currentDate);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              // ignore: missing_required_param
                              builder: (context) => DashboardScreen(
                                  birthdat: DateFormat.yMd()
                                      .format(currentDate)
                                      .toString(),
                                  babyname: _name.text)));
                    },
                    child: circular
                        ? CircularProgressIndicator()
                        : Text(
                            "continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/profile_baby.jpg")
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 10.0,
          right: 10.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.blueGrey,
              size: 30.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget nameTextField() {
    return TextFormField(
      controller: _name,
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.black,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
        labelText: "Baby name",
        helperText: "Name can't be empty",
      ),
    );
  }

  Widget dob() {
    String _formatdate = new DateFormat.yMd().format(currentDate);
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Date Of Birth",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'roboto',
              // color: textColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              _selectDate(context);
            },

            //onTap: onTap,
            child: IgnorePointer(
              child: TextFormField(
                decoration: InputDecoration(

                    // hintText: hintText,
                    labelText: "$_formatdate",
                    helperText: "Provide DOB on mm/dd/yyyy",
                    // hintText: '$_formatdate',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Color(0xff345658),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // ignore: missing_return

  Widget age() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(15),
        height: 120,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Age"),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: AgeCalculator.age(currentDate,
                                  today: DateTime.now())
                              .years
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                        TextSpan(
                          text: ' Years',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Text(
                      "${AgeCalculator.age(currentDate, today: DateTime.now()).months.toString()} Months | ${AgeCalculator.age(currentDate, today: DateTime.now()).days.toString()} Days"),
                ],
              ),
            ),
          ),
        ] //CustomDivider(),

            ));
  }

  Widget titleTextField() {
    return TextFormField(
      controller: _title,
      validator: (value) {
        if (value.isEmpty) return "Title can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.black,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            )),
        suffixIcon: Icon(
          Icons.calendar_today_rounded,
          color: Colors.grey,
        ),
      ),
    );
  }

  Future<String> addbaby(String username,String email,String pass ,String babyname, String baby_gender,
      DateTime birthday) async {
    var ROOT = Uri.parse("http://192.168.232.2/Hi_Baby/babyinfo.php");

    try {
      var map = new Map<String, dynamic>();
      map["username"] = username;
      map["email"] = email;
      map["pass"] = pass;
      map["babyname"] = babyname;
      map["baby_gender"] = baby_gender;
      map["birthday"] = DateFormat.yMd().format(birthday).toString();
      final response = await http.post(ROOT, body: map);
      print("addBaby>> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    // return pickedDate;
  }

  /*void _sendDataToSecondScreen(BuildContext context) {
    DateTime bodd = currentDate;
    Navigator.push(
        context,
        MaterialPageRoute(
          // ignore: missing_required_param
          builder: (context) => MyDashboard(bodd: bodd),
        ));
  }*/
}
