// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
//import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

class imgdetail extends StatefulWidget {
  final Image;
  final Title;

  imgdetail({
    this.Image,
    this.Title,
  });

  @override
  _imgdetailState createState() => _imgdetailState();
}

class _imgdetailState extends State<imgdetail> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: ListView(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 20),
                height: 660,
                width: 600,
                child: GridTile(
                  child: widget.Image,
                )),
            Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Center(
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
                      text: widget.Title,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ])),
                )),
          ],
        ),
      ),

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
    );
  }
}
