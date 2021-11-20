import 'dart:convert';
import 'dart:io';

import 'dart:ui';
import 'package:blogapp/Blog/addBlog.dart';
import 'package:blogapp/Pages/doctor_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'doclist .dart';
import 'imagelist.dart';

class gallery extends StatefulWidget {
  const gallery({Key key}) : super(key: key);

  @override
  _galleryState createState() => _galleryState();
}

class _galleryState extends State<gallery> {
  Future getdata() async {
    var uri = Uri.parse("http://192.168.232.2/Hi_Baby/gallery.php");
    var response = await http.get(uri);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            title: Text("gallery",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            centerTitle: true,
          ),
          body: FutureBuilder(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return imagelist(
                      Title: snapshot.data[i]['title'],
                      imagename: snapshot.data[i]['image'],
                    );
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddBlog();
              }));
            },
            child: Text(
              "+",
              style: TextStyle(fontSize: 40),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.blueGrey,
            shape: CircularNotchedRectangle(),
            notchMargin: 12,
            child: Container(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.home),
                      iconSize: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
