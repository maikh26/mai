// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class docdetail extends StatefulWidget {
  final named;
  final work_placed;
  final working_hoursd;
  final locationd;
  final ratingd;
  final detaild;
  final phone_numd;
  docdetail({
    this.named,
    this.work_placed,
    this.working_hoursd,
    this.locationd,
    this.ratingd,
    this.detaild,
    this.phone_numd,
  });

  @override
  _docdetailState createState() => _docdetailState();
}

class _docdetailState extends State<docdetail> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    final num = widget.phone_numd;
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Details",
              ),
              centerTitle: true,
            ),
            body: ListView(children: <Widget>[
              Container(
                  height: 300,
                  child: GridTile(
                    child: Image.asset("assets/doctor1.jpg"),
                    footer: Container(
                      height: 50,
                      color: Colors.blueGrey.withOpacity(0.3),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                widget.named,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    widget.ratingd,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                )
                              ],
                            ),
                          ]),
                    ),
                  )),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Column(children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: "Details : ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: widget.detaild,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ]))),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              child: RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: "Working place : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: widget.work_placed,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]))),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                              color: Colors.blueGrey.withOpacity(0.3),
                              child: RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: "Working Hours : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: widget.working_hoursd,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]))),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(10),
                                    color: Colors.blueGrey.withOpacity(0.3),
                                    child: RichText(
                                        text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                        text: "Location :  ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: widget.locationd,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]))),
                              ],
                            ),
                          ),
                          RaisedButton.icon(
                              onPressed: () {
                                customLaunch('tel: $num');
                              },
                              icon: Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                              label: Text(
                                widget.phone_numd,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.blue),
                          /*  RaisedButton.icon(
                              onPressed: () {
                                customLaunch(
                                    'mailto:your@email.com?subject=test%20subject&body=test%20body');
                              },
                              icon: Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                              label: Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.blue)*/
                        ],
                      ),
                    ),
                  ]))
            ])));
  }
}
