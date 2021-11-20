import 'dart:convert';

import 'package:blogapp/Pages/baby%20_sitter.dart';
import 'package:blogapp/Pages/doctor.dart';
import 'package:blogapp/Pages/gallary.dart';
import 'package:blogapp/common/custom_app_bar.dart';
import 'package:blogapp/group.dart';
import 'package:blogapp/schduleNotification/homeSchdule.dart';
import 'package:blogapp/utils/strings.dart';
import 'package:blogapp/utils/text_styles.dart';
import 'package:blogapp/vaccine/vaccine.dart';
import 'package:blogapp/videos/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../age.dart';

class DashboardScreen extends StatefulWidget {
  final String birthdat;
  final String babyname;
    final String username;

  const DashboardScreen({Key key, this.birthdat, this.babyname, this.username})
      : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String birthdat = widget.birthdat;
    String babyname = widget.babyname;
    String username = widget.username;

    var dt = DateFormat.yMd().parse(birthdat);
    String vaccin =
        "${AgeCalculator.age(dt, today: DateTime.now()).years.toString()}|${AgeCalculator.age(dt, today: DateTime.now()).months.toString()}";
    // DateTime dt = DateTime.parse(birthdat + " 00:00:00.000");
    // DateFormat.yMd().format(dt);
    print(dt);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70, // Set this height

        backgroundColor: Colors.grey,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "   Baby $babyname",
              style: TextStyle(fontSize: 20),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "   \n   ${AgeCalculator.age(dt, today: DateTime.now()).years.toString()} years |${AgeCalculator.age(dt, today: DateTime.now()).months.toString()} Months | ${AgeCalculator.age(dt, today: DateTime.now()).days.toString()} Days",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ]),
        ),
      ),
      drawer: Drawer(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.40,
            child: Container(
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "assets/babymo.jpg",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                  Column(
                    children: <Widget>[
                      /*  CustomAppBar(
                        opacity: 1,
                      ),*/
                      Expanded(
                        child: Align(
                          alignment: Alignment(0, -0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.70,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                  color: Colors.grey),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Text(
                      Strings.quickCategories,
                      style: TextStyles.titleTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.brown[100],
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => doctor(),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  "assets/doctor.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              Strings.bear,
                              style: TextStyles.body2TextStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.brown[100],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => homeschdule(username:username),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/todolist.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                )),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              Strings.lion,
                              style: TextStyles.body2TextStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.brown[100],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => group(),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/team.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                )),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              Strings.reptiles,
                              style: TextStyles.body2TextStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.brown[100],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Baby_sitter(),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/maternity.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                )),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              Strings.pets,
                              style: TextStyles.body2TextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.brown[100],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => vaccine(vaccin:vaccin),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/vaccines.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                )),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              Strings.Vaccines,
                              style: TextStyles.body2TextStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.brown[100],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/video.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                )),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              Strings.videos,
                              style: TextStyles.body2TextStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.brown[100],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => doctor(),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/baby.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                )),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              Strings.baby,
                              style: TextStyles.body2TextStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.brown[100],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => doctor(),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/online.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                )),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              Strings.article,
                              style: TextStyles.body2TextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
