import 'dart:convert';

import 'package:blogapp/Profile/CreatProfile.dart';
import 'package:blogapp/Screens/dashboard_screen.dart';
import 'package:blogapp/background-image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';
import 'dart:io';

import 'homepageNew.dart';

class LOgin2 extends StatefulWidget {
  const LOgin2({Key key}) : super(key: key);

  @override
  _LOgin2State createState() => _LOgin2State();
}

showdialog(context) {
  return showDialog(
      context: context,
      builder: (context) {
        duration:
        Duration(milliseconds: 900);

        return AlertDialog(
          content: Row(
            children: <Widget>[
              Text("Loading......"),
              CircularProgressIndicator()
            ],
          ),
        );
      });
}

savepref(String username) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("username", username);
  print(preferences.getString("username"));
}

showloading(context, String mytitle, String mycontent) {
  return showDialog(
      context: context,
      builder: (context) {
        duration:
        Duration(milliseconds: 1000);

        return AlertDialog(
          title: Text(
            mytitle,
            style: TextStyle(fontSize: 19, color: Colors.blueGrey),
          ),
          content: Text(
            mycontent,
            style: TextStyle(fontSize: 19, color: Colors.blueGrey),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "done",
                  style: TextStyle(fontSize: 19, color: Colors.blueGrey),
                ))
          ],
        );
      });
}

class _LOgin2State extends State<LOgin2> {
  TapGestureRecognizer _changesign;
  bool showsignin = true;
  TextEditingController _username = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  TextEditingController _username2 = new TextEditingController();

  TextEditingController _pass2 = new TextEditingController();

  TextEditingController _email = new TextEditingController();
  TextEditingController _confirmpass = new TextEditingController();
  GlobalKey<FormState> formstate_signup = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate_signin = new GlobalKey<FormState>();

  savePref(String username, String email, String id, String birthdat,
      String baby_name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", id);
    preferences.setString("username", username);
    var perf = preferences.setString("username", username);

    preferences.setString("email", email);
    print(preferences.getString("username"));
    print(preferences.getString("email"));
    print(preferences.getString("id"));
    print(preferences.getString("birthdat"));
    print(preferences.getString("baby_name"));

    return perf;
  }

  Future signin() async {
    var formdata = formstate_signin.currentState;
    if (formdata.validate()) {
      Map data = {"username": _username.text, "password": _pass.text};
      var url = "http://172.20.10.4/Hi_Baby/login.php";
      var response = await http.post(url, body: data);
      print("okk");
      Map responsebody = jsonDecode((response.body));

      if (responsebody['status'] == "success") {
        print("done");
        savePref(
          responsebody['username'],
          responsebody['email'],
          responsebody['id'],
          responsebody['birthdat'],
          responsebody['baby_name'],
        );
        showdialog(context);
        String birthdat = responsebody['birthdat'];
        String babyname = responsebody['baby_name'];
        String username = responsebody['username'];

        //String username = _username2.text;

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(
                  birthdat: birthdat, babyname: babyname, username: username),
            ));
      } else {
        print('login failed');
        showloading(context, "wrong", " Invaild username or password ");
      }
    } else {
      print("not vaild");
    }

    catchError((Object error) {
      //do something else
      return null;
    });
  }

  String validglobal(String val) {
    if (val.trim().isEmpty) {
      return (" field can be empty");
    }
  }

  Future signup() async {
    var formdata = formstate_signup.currentState;
    if (formdata.validate()) {
      formdata.save();
      var data = {
        "username": _username2.text,
        "email": _email.text,
        "password": _pass2.text,
      };
      final uri = Uri.parse("http://172.20.10.4/Hi_Baby/signup.php");
      var request = await http.post(uri, body: data);
      var message = jsonDecode(request.body);
      print(message);
      if (message['status'] == "faild") {
        showloading(context, "wrong", " Email already exists ");
        print('erorrr');
      } else {
        String username = _username2.text;
        String email = _email.text;
        String pass = _pass2.text;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreatProfile(username: username, email: email, pass: pass),
            ));
      }
    }
  }

  @override
  void initState() {
    _changesign = new TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showsignin = !showsignin;
          print(showsignin);
        });
      };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var wh = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
            body: Stack(children: <Widget>[
          Image.asset(
            "assets/baby_mum.jpg",
            height: height,
            fit: BoxFit.fitHeight,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          // poisition_top(wh),
          // positione_bottom(wh),
          //  BackgroundImage(),
          Container(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    showsignin ? "Login" : "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  ),
                  // margin: EdgeInsets.only(top: 20),
                )),
                build_top(),
                Padding(padding: EdgeInsets.only(top: 40)),
                showsignin ? build_form(wh) : build_form_signup(wh),
                Center(
                  child: Container(
                    // margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        showsignin
                            ? InkWell(
                                onTap: () {},
                                child: Text(
                                  "forget password ?",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.pink.withOpacity(0.8),
                                      fontStyle: FontStyle.italic),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 24,
                        ),
                        RaisedButton(
                          elevation: 8,
                          color: showsignin
                              ? Colors.blueGrey[300]
                              : Colors.pinkAccent.withOpacity(0.5),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          onPressed: () {
                            showsignin ? signin() : signup();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                showsignin ? 'Login' : "Continue",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 47),
                            child: RichText(
                                text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: showsignin
                                      ? "You Dont have account?"
                                      : " You have  an Account ?",
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 20)),
                              TextSpan(
                                  recognizer: _changesign,
                                  text: showsignin ? "Sign up" : "Login",
                                  style: TextStyle(
                                    color: Colors.pink.withOpacity(0.9),
                                    fontSize: 20,
                                    decoration: TextDecoration.underline,
                                  ))
                            ])))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ))
        ])));
  }

  AnimatedContainer build_top() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: 120,
      width: 120,

      /*  child: Carousel(
        borderRadius: true,
        images: [
          Image.asset('assets/baby_icon4.jpg', fit: BoxFit.cover),
          Image.asset('assets/newborn.jpg', fit: BoxFit.cover),
          Image.asset('assets/baby_icon5.jpg', fit: BoxFit.cover),
        ],
        showIndicator: false,
      ),*/
      // child: Icon(FontAwesomeIcons.baby,
      // size: 50, color: showsignin ? Colors.blueGrey : Colors.white),
    );
  }

  Center build_form(double wh) {
    return Center(
        child: AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: 250,
      width: wh / 1.2,
      /*  decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
                color: Colors.blueGrey,
                spreadRadius: 0.1,
                blurRadius: 1,
                offset: Offset(0, 1))
          ]),*/
      child: Form(
          key: formstate_signin,
          child: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(" username",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: _username,
                      validator: validglobal,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4),
                        prefixIcon: Icon(Icons.person),
                        hintText: "Enter username",
                        filled: true,
                        fillColor: Colors.grey[50],
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[50],
                                style: BorderStyle.solid,
                                width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[50],
                                style: BorderStyle.solid,
                                width: 1)),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(" Password",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: _pass,
                      obscureText: true,
                      validator: validglobal,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4),
                        hintText: "Enter password",
                        prefixIcon: Icon(Icons.lock),
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500],
                                style: BorderStyle.solid,
                                width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500],
                                style: BorderStyle.solid,
                                width: 1)),
                      ))
                ],
              ),
            ),
          )),
    ));
  }

  /*Positioned poisition_top(double wh) {
    return Positioned(
        child: Transform.scale(
      scale: 1.3,
      child: Transform.translate(
        offset: Offset(0, -wh / 1.8),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: wh,
          width: wh,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(wh),
            color: showsignin
                ? Colors.blueGrey[300]
                : Colors.pink[300].withOpacity(0.5),
          ),
        ),
      ),
    ));
  }*/

  Positioned positione_bottom(double wh) {
    return Positioned(
      top: 300,
      left: wh / 1.5,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        height: wh,
        width: wh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(wh),
          color: showsignin
              ? Colors.pink[300].withOpacity(0.5)
              : Colors.blueGrey[300],
        ),
      ),
    );
  }

  build_form_signup(double wh) {
    return Center(
        child: AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: 360,
      width: wh / 1.2,
      decoration: BoxDecoration(
          color: Colors.pinkAccent.withOpacity(0.5),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
                color: Colors.blueGrey,
                spreadRadius: 0.1,
                blurRadius: 1,
                offset: Offset(0, 1))
          ]),
      child: Form(
          key: formstate_signup,
          child: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(" username",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: _username2,
                      validator: validglobal,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4),
                        prefixIcon: Icon(Icons.person),
                        hintText: "Enter username",
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500],
                                style: BorderStyle.solid,
                                width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500],
                                style: BorderStyle.solid,
                                width: 1)),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(" Password",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: _pass2,
                      obscureText: true,
                      validator: validglobal,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4),
                        hintText: "Enter password",
                        prefixIcon: Icon(Icons.lock),
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500],
                                style: BorderStyle.solid,
                                width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500],
                                style: BorderStyle.solid,
                                width: 1)),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(" Email",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: _email,
                      validator: validglobal,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4),
                        hintText: "Enter your Email",
                        prefixIcon: Icon(Icons.email_outlined),
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500],
                                style: BorderStyle.solid,
                                width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[500],
                                style: BorderStyle.solid,
                                width: 1)),
                      ))
                ],
              ),
            ),
          )),
    ));
  }

  void catchError(Null Function(Object error) param0) {}
}
