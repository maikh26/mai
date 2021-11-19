import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blogapp/videos/video_tips.dart';
import 'colors.dart' as color;
import 'package:blogapp/videos/video_game.dart';
import 'package:blogapp/videos/vedio_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List info = [];
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/info.json")
        .then((value) {
      setState(() {
        info = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Activities",
                  style: TextStyle(
                      fontSize: 25,
                      color: color.AppColor.homePageTitle,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: color.AppColor.homePageIcons,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 20,
                  color: color.AppColor.homePageIcons,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: color.AppColor.homePageIcons,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  "your programe",
                  style: TextStyle(
                      fontSize: 15,
                      color: color.AppColor.homePageSubtitle,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 15,
                    color: color.AppColor.homePageDetail,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => videoInfo());
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: color.AppColor.homePageIcons,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.AppColor.gradientFirst.withOpacity(0.8),
                      color.AppColor.gradientSecond.withOpacity(0.9),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(88),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(5, 10),
                      blurRadius: 20,
                      color: color.AppColor.gradientSecond.withOpacity(0.2),
                    )
                  ]),
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Next Activity",
                      style: TextStyle(
                        fontSize: 10,
                        color: color.AppColor.homePageContainerTextSmall,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Baby Sleep",
                      style: TextStyle(
                        fontSize: 15,
                        color: color.AppColor.homePageContainerTextSmall,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "play with your Baby",
                      style: TextStyle(
                        fontSize: 17,
                        color: color.AppColor.homePageContainerTextSmall,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                      width: 10,
                    ),
                    Text(
                      "How do you deal with your Baby?",
                      style: TextStyle(
                        fontSize: 17,
                        color: color.AppColor.homePageContainerTextSmall,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                      width: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        Expanded(child: Container()),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              boxShadow: [
                                BoxShadow(
                                  color: color.AppColor.gradientFirst,
                                  blurRadius: 10,
                                  offset: Offset(4, 8),
                                )
                              ]),
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
                "Area of videos ",
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
                  ],
                ))
            /*Expanded(
                child: OverflowBox(
              maxWidth: MediaQuery.of(context).size.width,
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                  itemCount: info.length.toDouble() ~/ 2, //2
                  itemBuilder: (_, i) {
                    int a = 2 * i;
                    int b = 2 * i + 1;
                    return Row(children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 50) / 2,
                        height: 150,
                        margin: EdgeInsets.only(
                          left: 15,
                          bottom: 5,
                        ),
                        padding: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage(info[a]['img'])
                                ),
                                
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                offset: Offset(5, 5),
                                color: color.AppColor.gradientFirst
                                    .withOpacity(0.1),
                              ),
                              BoxShadow(
                                blurRadius: 3,
                                offset: Offset(-5, -5),
                                color: color.AppColor.gradientFirst
                                    .withOpacity(0.1),
                              )
                            ]),
                        child: Center(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              info[a]['title'],
                              style: TextStyle(
                                fontSize: 15,
                                color: color.AppColor.homePageIcons,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width - 50) / 2,
                        height: 150,
                        margin: EdgeInsets.only(
                          left: 15,
                          bottom: 5,
                        ),
                        padding: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage(info[b]['img'])),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                offset: Offset(5, 5),
                                color: color.AppColor.gradientFirst
                                    .withOpacity(0.1),
                              ),
                              BoxShadow(
                                blurRadius: 3,
                                offset: Offset(-5, -5),
                                color: color.AppColor.gradientFirst
                                    .withOpacity(0.1),
                              )
                            ]),
                        child: Center(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              info[b]['title'],
                              style: TextStyle(
                                fontSize: 15,
                                color: color.AppColor.homePageIcons,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]);
                  },
                ),
              ),
            ))*/
          ],
        ),
      ),
    );
  }
}
