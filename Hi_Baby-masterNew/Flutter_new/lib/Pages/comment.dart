import 'dart:convert';

import 'package:blogapp/group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class comment extends StatefulWidget {
  final postid;
  comment({this.postid});
  @override
  _commentState createState() => _commentState();
}

class _commentState extends State<comment> {
  var id = "";
  TextEditingController _addcomment = new TextEditingController();
  getcomments() async {
    var uri = Uri.parse("http://172.20.10.4/Hi_Baby/comments.php");
    var data = {"postid": widget.postid ?? ""};
    var response = await http.post(uri, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
    });
  }

  Future addcomment() async {
    var uri = Uri.parse("http://172.20.10.4/Hi_Baby/addcomment.php");
    var data = {
      "comment": _addcomment.text,
      "comuser": id,
      "compost": widget.postid
    };

    var response = await http.post(uri, body: data);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return comment();
    }));
  }

  @override
  void initState() {
    getpref();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            body: Stack(children: <Widget>[
      Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
      Positioned(
        bottom: 0,
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              // decoration: BoxDecoration(
              //  border: Border(top: BorderSide(color: Colors.grey))),
              // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              //  width: MediaQuery.of(context).size.width,
              Container(
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey))),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.camera_alt),
                      color: Colors.blueGrey,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      width: MediaQuery.of(context).size.width - 70,
                      child: TextFormField(
                        controller: _addcomment,
                        decoration: InputDecoration(
                          hintText: "Add comment",
                          filled: true,
                          fillColor: Colors.grey[300],
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              addcomment();
                            },
                            color: Colors.blueGrey,
                          ),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60),
                              borderSide: BorderSide(style: BorderStyle.none)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60),
                              borderSide: BorderSide(style: BorderStyle.none)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
          top: 40,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 70,
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: getcomments(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (int i = 0; i < snapshot.data.length; i++)
                          commentslist(
                            comment: snapshot.data[i]['comment'],
                            username: snapshot.data[i]['username'],
                          ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          )),
    ])));
  }
}

class commentslist extends StatelessWidget {
  final username;
  final comment;

  commentslist({this.comment, this.username});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Container(
          margin: EdgeInsets.only(top: 15),
          child: Text(
            username,
            style: TextStyle(fontSize: 20),
          )),
      subtitle: Container(
          margin: EdgeInsets.all(10),
          color: Colors.blueGrey[90],
          child: Text(
            comment,
            style: TextStyle(fontSize: 20),
          )),
    );
  }
}
