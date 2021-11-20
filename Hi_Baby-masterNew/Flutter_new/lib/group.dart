import 'dart:convert';
import 'dart:io';

import 'package:blogapp/Pages/comment.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blogapp/Pages/login2.dart';
// ignore: duplicate_import

import 'package:http/http.dart' as http;

import 'Pages/Home.dart';

class group extends StatefulWidget {
  const group({Key key}) : super(key: key);
  @override
  _groupState createState() => _groupState();
}

class _groupState extends State<group> {
  final _picker = ImagePicker();
  File imagename;
  var id = "";
  var username = "none";
  var email;
  int _counter = 0;

  TextEditingController _addpost = new TextEditingController();
  Future takeCoverPhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.camera);
    //final coverPhoto2 = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      imagename = File(coverPhoto.path);
      // _imageFile = File(coverPhoto2.path);

      // iconphoto = Icons.check_box;
    });
  }

  Future choosePhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.gallery);
    //final coverPhoto2 = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      imagename = File(coverPhoto.path);
      // _imageFile = File(coverPhoto2.path);

      // iconphoto = Icons.check_box;
    });
  }

  Future addpost() async {
    if (imagename != null) {
      String base64 = base64Encode(imagename.readAsBytesSync());
      String image_name = imagename.path.split("/").last;

      var uri = Uri.parse("http://192.168.232.2/Hi_Baby/addpost.php");
      var data = {
        "post": _addpost.text,
        "postuser": id,
        "imagename": image_name,
        "image64": base64,
      };

      var response = await http.post(uri, body: data);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => group()), (route) => false);
    } else if (imagename == null) {
      var uri = Uri.parse("http://192.168.232.2/Hi_Baby/addpost.php");
      var data = {
        "post": _addpost.text,
        "postuser": id,
      };

      var response = await http.post(uri, body: data);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => group()), (route) => false);
    }
  }

  getpost() async {
    var uri = Uri.parse("http://192.168.232.2/Hi_Baby/post.php");
    var response = await http.get(uri);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      username = preferences.getString("username");
      email = preferences.getString("email");
    });
  }

  int _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    getpref();
    getpost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getpref() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      print(username = preferences.getString("username"));
      // email = preferences.getString("email");
      if (username != null) {
        setState(() {
          username = preferences.getString(username);
          // email = preferences.getString("email");
        });
      }
      return username;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(
            "Hi Baby group",
          ),
          centerTitle: true,
        ),
        drawer: Drawer(),
        body: ListView(children: <Widget>[
          SizedBox(
            height: 240,
            width: double.infinity,
            child: Carousel(
              images: [
                Image.asset('assets/back.PNG', fit: BoxFit.cover),
                Image.asset('assets/mother3.jpg', fit: BoxFit.cover),
                Image.asset('assets/mother4.jpg', fit: BoxFit.cover),
              ],
              showIndicator: false,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                child: Card(
                  child: Column(children: <Widget>[
                    Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                              leading: CircleAvatar(
                                child: Icon(Icons.person),
                                foregroundColor: Colors.blueGrey,
                              ),
                              title: Container(
                                child: TextFormField(
                                  controller: _addpost,
                                  maxLength: 255,
                                  maxLines: 10,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 13),
                                      hintText: "Add new Post",
                                      hintStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blueGrey),
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                              ),
                              trailing: Container(
                                child: Icon(
                                  Icons.image,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              onTap: choosePhoto),
                          Text(
                            "|",
                            style: TextStyle(fontSize: 17),
                          ),
                          IconButton(
                            onPressed: () {
                              takeCoverPhoto();
                            },
                            icon: Icon(Icons.camera_alt),
                            color: Colors.blueGrey,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: InkWell(
                                onTap: addpost,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.blueGrey
                                                  .withOpacity(0.2)))),
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(right: 10)),
                                      Icon(
                                        Icons.add_box,
                                        color: Colors.blueGrey,
                                      ),
                                      Text(
                                        "Add Post",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: getpost(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: <Widget>[
                                for (int i = snapshot.data.length - 1;
                                    i >= 0;
                                    i--)
                                  postlist(
                                    name: snapshot.data[i]['username'],
                                    contentpost: snapshot.data[i]['post'],
                                    postid: snapshot.data[i]['post_id'],
                                    postimage: snapshot.data[i]['post_image'],
                                  ),
                              ],
                            );
                          }
                          return CircularProgressIndicator();
                        }),
                  ]),
                ),
              )),
        ]));
  }
}

class postlist extends StatelessWidget {
  final name;
  final contentpost;
  final postid;
  final postimage;

  postlist({this.name, this.contentpost, this.postid, this.postimage});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: Column(children: <Widget>[
      Card(
          child: Column(
        children: <Widget>[
          ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
                foregroundColor: Colors.blueGrey,
              ),
              title: Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  name ?? '',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                padding: EdgeInsets.all(7),
              ),
              trailing: Icon(Icons.filter_list),
              isThreeLine: true,
              subtitle: Column(
                children: <Widget>[
                  Text(
                    contentpost,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87),
                  ),
                  Image.network("http://192.168.232.2/Hi_Baby/uploads/$postimage")
                ],
              )),
          Divider(
            color: Colors.grey.withOpacity(0.5),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: InkWell(
                onTap: () {
                  Icon(
                    Icons.thumb_up,
                    color: Colors.purpleAccent,
                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border(left: BorderSide(color: Colors.blueGrey))),
                    child: Padding(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.thumb_up,
                              color: Colors.blueGrey,
                            ),
                            Text(
                              "Like",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ]),
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                    )),
              )),
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => comment(
                                postid: postid,
                              )),
                      (route) => false);
                },
                child: Padding(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.comment,
                          color: Colors.blueGrey,
                        ),
                        Text(
                          "Comment",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ]),
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                ),
              )),
            ],
          )
        ],
      ))
    ]));
  }
}
