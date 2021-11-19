// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class docdetail extends StatefulWidget {
  final named;
  final work_placed;
  final working_hoursd;
  final locationd;
  final ratingd;
  final detaild;
  final phone_numd;

  final priced;

  docdetail(
      {this.named,
      this.work_placed,
      this.working_hoursd,
      this.locationd,
      this.ratingd,
      this.detaild,
      this.phone_numd,
      this.priced});

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

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: widget.phone_numd,
      text: "Hey! I'm inquiring about the apartment listing",
    );
    // Convert the WhatsAppUnilink instance to a string.
    // Use either Dart's string interpolation or the toString() method.
    // The "launch" method is part of "url_launcher".
    await launch('$link');
  }

  openwhatsapp() async {
    var whatsapp = widget.phone_numd;
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
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
                      child: Column(children: <Widget>[
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
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(20),
                              child: RaisedButton.icon(
                                  onPressed: () {
                                    customLaunch('tel: $num');
                                  },
                                  icon: Container(
                                    height: 50,
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                    ),
                                  ),
                                  label: Text(
                                    widget.phone_numd,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  color: Colors.white),
                            ),
                            RaisedButton.icon(
                                onPressed: () {
                                  openwhatsapp();
                                },
                                icon: Container(
                                    height: 50,
                                    child: Image.asset("assets/whatsapp.jpg")),
                                label: Text(
                                  "Whatsapp",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                color: Colors.white)
                          ],
                        ),
                      ]),
                    )
                  ]))
            ])));
  }
}
