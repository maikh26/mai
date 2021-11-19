import 'dart:convert';
import 'dart:io';

import 'dart:ui';
import 'package:blogapp/Blog/addBlog.dart';
import 'package:blogapp/Pages/doctor_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:photo_view/photo_view_gallery.dart';
import 'dart:convert';

import '../Pages/doclist .dart';
import '../Pages/gallerydetail.dart';

class gallery extends StatefulWidget {
  const gallery({Key key}) : super(key: key);

  @override
  _galleryState createState() => _galleryState();
}

class _galleryState extends State<gallery> {
  Future getdata() async {
    var uri = Uri.parse("http://172.20.10.4/Hi_Baby/gallery.php");
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
                          height: 200,
                          width: 200,
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
                  children: <Widget>[],
                ),
              ),
            ),
          ),
        ));
  }
}
