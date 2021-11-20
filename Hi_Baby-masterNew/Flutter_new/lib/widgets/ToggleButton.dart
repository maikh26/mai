import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: unused_import
import 'package:toggle_switch/toggle_switch.dart';

class togglebutton extends StatefulWidget {
  const togglebutton({Key key}) : super(key: key);

  @override
  _togglebuttonState createState() => _togglebuttonState();
}

class _togglebuttonState extends State<togglebutton> {
  @override
  // ignore: override_on_non_overriding_member
  List<bool> isSelected = [true, false];
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text('Boy', style: TextStyle(fontSize: 20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text('Girl', style: TextStyle(fontSize: 20)),
          ),
        ],
        selectedColor: Colors.white,
        color: Colors.black,
        fillColor: Colors.blueGrey,
        // renderBorder: true,
        borderColor: Colors.black,
        borderRadius: BorderRadius.circular(15.0),
        // constraints: BoxConstraints(minHeight: 50.0),
        splashColor: Colors.purple,
        // highlightColor: Colors.orange,
        isSelected: isSelected,
        onPressed: (int newIndex) {
          setState(() {
            for (int index = 0; index < isSelected.length; index++) {
              if (index == newIndex) {
                isSelected[index] = true;
                // ignore: unused_label
                if (index == 0) {
                  // ignore: unused_label
                  fillColor:
                  Colors.blue;
                }
              } else {
                isSelected[index] = false;
                // ignore: unused_label
                fillColor:
                Colors.pink;
              }
            }
          });
        },
      ),
    );
  }
}
