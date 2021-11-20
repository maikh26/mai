import 'package:blogapp/Pages/comment.dart';
import 'package:blogapp/Pages/doctor.dart';
import 'package:blogapp/group.dart';
import 'package:blogapp/schduleNotification/homeSchdule.dart';
import 'package:blogapp/videos/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../age.dart';
import 'baby _sitter.dart';
import 'gallary.dart';
import 'shapedashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class home_page extends StatefulWidget {
  final String username;

  home_page({Key key, @required this.username}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  //DateTime bodd => bodd;

  @override
  Widget build(BuildContext context) {
    //DateTime bodd = widget.bodd;

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
        body: ListView(
          children: <Widget>[
            ClipPath(
              clipper: ShapeDashboard(),
              child: Container(
                height: 250,
                // color:Colors.amber,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: <Color>[Colors.purple[100], Colors.purple[100]],
                )),
              ),
            ),
            Container(
                height: 500,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                  children: <Widget>[
                    InkWell(
                        child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.deepPurpleAccent,
                              height: 30,
                              child: Text(
                                'Baby gallary',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundImage: AssetImage("assets/memory.jpg"),
                            )),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => gallery()),
                              (route) => false);
                        }),
                    InkWell(
                        child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.deepPurpleAccent,
                              height: 30,
                              child: Text(
                                'Baby Videos',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundImage: AssetImage("assets/ola.jpg"),
                            )),
                        onTap: () {
                           Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                              (route) => false);
                        }),
                    InkWell(
                        child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.deepPurpleAccent,
                              height: 30,
                              child: Text(
                                'Baby doctors',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundImage:
                                  AssetImage("assets/baby_doc.jpg"),
                            )),
                        onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => doctor()),
                              (route) => false);
                        }),
                    InkWell(
                      
                        child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.deepPurpleAccent,
                              height: 30,
                              child: Text(
                                'Baby Sitter',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundImage: AssetImage("assets/sound.jpg"),
                            )),
                        onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Baby_sitter()),
                              (route) => false);
                        }),
                    InkWell(
                        child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.deepPurpleAccent,
                              height: 30,
                              child: Text(
                                'Write Notes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundImage:
                                  AssetImage("assets/wite_note.jpg"),
                            )),
                        onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => homeschdule()),
                              (route) => false);
                        }),
                    InkWell(
                        child: GridTile(
                            footer: Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.deepPurpleAccent,
                              height: 30,
                              child: Text(
                                'mother groups',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundImage: AssetImage("assets/mother2.jpg"),
                            )),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => group()),
                              (route) => false);
                        }),
                  ],
                ))
          ],
        ));
  }

  Widget age() {
    // DateTime bodd = widget.bodd;
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
                          //  text: AgeCalculator.age(bodd, today: DateTime.now())
                          // .years
                          //  .toString(),
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
                    "",
                  )
                  //"${AgeCalculator.age(bodd, today: DateTime.now()).months.toString()} Months | ${AgeCalculator.age(bodd, today: DateTime.now()).days.toString()} Days"),
                ],
              ),
            ),
          ),
        ] //CustomDivider(),

            ));
  }

  getData(String username) async {
    var url = Uri.parse("http://192.168.232.2/Hi_Baby/getbaby.php");
    var map = new Map<String, dynamic>();
    map["username"] = username;
    var respons = await http.post(url, body: map);
    var list = json.decode(respons.body);
    // birth.add(list[0]['birthdat']);
    //print(birth[0]);
    return list;
  }
}
