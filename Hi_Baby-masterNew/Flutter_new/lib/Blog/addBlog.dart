import 'dart:io';
import 'dart:math';
import 'package:blogapp/Pages/login2.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:blogapp/CustumWidget/OverlayCard.dart';
import 'package:blogapp/Model/addBlogModels.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:blogapp/Pages/gallary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBlog extends StatefulWidget {
  String usernameg;
  AddBlog({this.usernameg});
  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  var id = "";
  var username;
  var email;

  final _picker = ImagePicker();
  File imagename;
  IconData iconphoto = Icons.image;
  //NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          // ignore: deprecated_member_use
        ],
      ),
      body: Form(
        child: ListView(
          children: <Widget>[
            titleTextField(),
            photoicon(),
            Container(
              height: 450,
              width: 550,
              child: imagename == null
                  ? Text('No image Selected')
                  : Image.file(imagename),
            ),
            SizedBox(
              height: 40,
            ),
            button(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: title,
        validator: (value) {
          if (value.isEmpty) {
            return "Title can't be empty";
          } else if (value.length > 100) {
            return "Title length should be <=100";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Add Image and Title",
        ),
        maxLength: 100,
        maxLines: null,
      ),
    );
  }

  Widget photoicon() {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: IconButton(
            icon: Icon(
              iconphoto,
              color: Colors.teal,
            ),
            onPressed: takeCoverPhoto));
  }

  Widget button() {
    var circular = false;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Center(
        child: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: FlatButton(
              onPressed: addButton,
              child: circular
                  ? CircularProgressIndicator()
                  : Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Future takeCoverPhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.camera);
    //final coverPhoto2 = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      imagename = File(coverPhoto.path);
      // _imageFile = File(coverPhoto2.path);

      // iconphoto = Icons.check_box;
    });
  }

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

  Future addButton() async {
    String base64 = base64Encode(imagename.readAsBytesSync());
    String image_name = imagename.path.split("/").last;
    String usernameg = widget.usernameg;

    print(image_name);
    final uri = Uri.parse("http://172.20.10.4/Hi_Baby/upload.php");
    // var request = (await http.MultipartRequest('POST', uri));
    // request.fields['title'] = title.text;
    // myrequest.fields['body'] = body.text;
    var data = {
      "title": title.text,
      "imagename": image_name,
      "image64": base64,
      "username": usernameg,
    };

    //  var pic = await http.MultipartFile.fromPath("image", imagename.path);
    // print(imagename.path);
    // request.files.add(pic);
    var response = await http.post(uri, body: data);
    if (response.statusCode == 200) {
      print('image uploded');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => gallery(
                    username_gallary: usernameg,
                  )));
    } else {
      print('image not uploded');
    }
  }
}
