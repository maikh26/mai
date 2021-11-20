import 'package:blogapp/schduleNotification/homeSchdule.dart';
import 'package:blogapp/schduleNotification/services.dart';
import 'package:blogapp/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class vaccinedes extends StatefulWidget {
  final String id;
  const vaccinedes({Key key, this.id}) : super(key: key);

  @override
  _vaccinedesState createState() => _vaccinedesState();
}

class _vaccinedesState extends State<vaccinedes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.id;

    return Scaffold(
      appBar: _appbar(),
      backgroundColor: context.theme.backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.40,
            child: Container(
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "assets/vaccine.jpg",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                  Column(
                    children: <Widget>[
                      /*  CustomAppBar(
                        opacity: 1,
                      ),*/
                      Expanded(
                        child: Align(
                          alignment: Alignment(0, -0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.70,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                  color: Colors.grey),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Text(id,
                      //Strings.relatedToYou,
                      style:TextStyle(fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    fontFamily: 'Ubuntu',),
                    ),
                  ),
                  
                 
                 
                ],
              ),
            ),
          ),
        ],
      ),
      
      
      
      /* Column(
        children: [
          _addTaskBar(),
          _showData(id),
        ],
      ),*/
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),

      // myButton(label: "+ Add Task", onTap: () => null),
    );
  }

  _showData(String id) {
    return Expanded(
        child: Text(
      id,
      style: GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    ));
  }

  _appbar() {
    return AppBar(
      elevation: 0,
      //backgroundColor: context.themes.backgroundColor,
      // context.themes.backgroundColor,
      backgroundColor: Colors.grey,
      title: Text(
        "    Vaccine Details",
        style: Headingstyle,
      ),

      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color:  Colors.black,
          size: 20,
        ),
      ),
      actions: [
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
