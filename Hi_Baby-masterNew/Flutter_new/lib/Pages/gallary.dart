import 'dart:convert';
import 'dart:io';

import 'dart:ui';
import 'package:blogapp/Blog/addBlog.dart';
import 'package:blogapp/Pages/doctor_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'doclist .dart';
import 'gallerydetail.dart';

class gallery extends StatefulWidget {
  final String username_gallary;
  gallery({this.username_gallary});

  @override
  _galleryState createState() => _galleryState();
}

class _galleryState extends State<gallery> {
  var id = "";
  var username = "none";
  var email;

  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      username = preferences.getString("username");
      email = preferences.getString("email");
    });
  }

  Future getdata() async {
    var uri = Uri.parse("http://172.20.10.4/Hi_Baby/gallery.php");
    final String usernamegallary = widget.username_gallary;
    print(usernamegallary);
    var data = {
      "username": usernamegallary,
    };
    var response = await http.post(uri, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final String usernameg = widget.username_gallary;
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Text("gallery",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            centerTitle: true,
          ),
          body: FutureBuilder(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  // , Axis scrollDirection = Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 3),

                  itemCount: snapshot.data.length,

                  itemBuilder: (context, i) {
                    return InkWell(
                      child: GridTile(
                        footer:
                            Container(margin: EdgeInsets.all(10), height: 50),
                        child: Container(
                          child: Image.network(
                              "http://172.20.10.4/Hi_Baby/gallery/${snapshot.data[i]['image']}"),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return imgdetail(
                            Image: Image.network(
                                "http://172.20.10.4/Hi_Baby/gallery/${snapshot.data[i]['image']}"),
                            Title: snapshot.data[i]['title'],
                          );
                        }));
                      },
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
                return AddBlog(usernameg: usernameg);
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
                  children: <Widget>[],
                ),
              ),
            ),
          ),
        ));
  }
}
