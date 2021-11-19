// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class sitterdetail extends StatefulWidget {
  final named;
  final locationd;
  final detaild;
  final phone_numd;
  sitterdetail({
    this.named,
    this.locationd,
    this.detaild,
    this.phone_numd,
  });

  @override
  _sitterdetailState createState() => _sitterdetailState();
}

class _sitterdetailState extends State<sitterdetail> {
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
              backgroundColor: Colors.pink.withOpacity(0.3),
              title: Text(
                "Details",
              ),
              centerTitle: true,
            ),
            body: ListView(children: <Widget>[
              Container(
                  height: 300,
                  child: GridTile(
                    child: Image.asset("assets/babysitter.jpg"),
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
                              color: Colors.pink.withOpacity(0.3)),
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
