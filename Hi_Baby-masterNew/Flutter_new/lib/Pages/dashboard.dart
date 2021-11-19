import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/drawer.dart';

import 'package:get/get.dart';
import 'package:blogapp/videos/video_tips.dart';
import 'package:blogapp/videos/colors.dart' as color;
import 'package:blogapp/videos/video_game.dart';
import 'package:blogapp/videos/vedio_info.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key key}) : super(key: key);

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80, // Set this height

        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "",
          //"${AgeCalculator.age(bodd, today: DateTime.now()).years.toString()} years |${AgeCalculator.age(bodd, today: DateTime.now()).months.toString()} Months | ${AgeCalculator.age(bodd, today: DateTime.now()).days.toString()} Days",
          style: TextStyle(fontSize: 13),
        ),
      ),
      drawer: Drawer(),
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        // padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "",
                  style: TextStyle(
                      fontSize: 15,
                      color: color.AppColor.homePageSubtitle,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                Text(
                  "",
                  style: TextStyle(
                    fontSize: 15,
                    color: color.AppColor.homePageDetail,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            
            Container(
              height: 88,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/signupp.jpg",
                            ),
                            fit: BoxFit.fill),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 40,
                            offset: Offset(8, 10),
                            color:
                                color.AppColor.gradientSecond.withOpacity(0.3),
                          ),
                          BoxShadow(
                            blurRadius: 10,
                            offset: Offset(-1, -5),
                            color:
                                color.AppColor.gradientSecond.withOpacity(0.3),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Row(children: [
              Text(
                "categories",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: color.AppColor.homePageTitle,
                ),
              )
            ]),
            Container(
                height: 150,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 5),
                  children: <Widget>[
                    InkWell(
                        child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.all(5),
                              color:
                                  color.AppColor.gradientFirst.withOpacity(0.8),
                              height: 30,
                              child: Text(
                                'Baby Sleep',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundImage:
                                  AssetImage("assets/babysleep.jpg"),
                            )),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => videoInfo()),
                              (route) => false);
                        }),
                    InkWell(
                        child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.all(5),
                              color:
                                  color.AppColor.gradientFirst.withOpacity(0.8),
                              height: 30,
                              child: Text(
                                'Baby games',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundImage: AssetImage("assets/ola.jpg"),
                            )),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => videogame()),
                              (route) => false);
                        }),
                    InkWell(
                        child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.all(5),
                              color:
                                  color.AppColor.gradientFirst.withOpacity(0.8),
                              height: 30,
                              child: Text(
                                'Tips',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundImage: AssetImage("assets/mom.png"),
                            )),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => videotips()),
                              (route) => false);
                        }),
                         InkWell(
                        child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.all(5),
                              color:
                                  color.AppColor.gradientFirst.withOpacity(0.8),
                              height: 30,
                              child: Text(
                                'Baby Sleep',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundImage:
                                  AssetImage("assets/babysleep.jpg"),
                            )),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => videoInfo()),
                              (route) => false);
                        }),
                         InkWell(
                        child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.all(5),
                              color:
                                  color.AppColor.gradientFirst.withOpacity(0.8),
                              height: 30,
                              child: Text(
                                'Baby Sleep',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundImage:
                                  AssetImage("assets/babysleep.jpg"),
                            )),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => videoInfo()),
                              (route) => false);
                        }),
                         InkWell(
                        child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.all(5),
                              color:
                                  color.AppColor.gradientFirst.withOpacity(0.8),
                              height: 30,
                              child: Text(
                                'Baby Sleep',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundImage:
                                  AssetImage("assets/babysleep.jpg"),
                            )),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => videoInfo()),
                              (route) => false);
                        }),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
