import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF0277BD);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color primaryClr = bluishClr;
const Color darkgreyClr = Color(0xFF121212);
Color darkheaderClr = Color(0xFF424242);

class themes {
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: primaryClr,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  static final dark = ThemeData(
    backgroundColor: darkgreyClr,
    primaryColor: darkgreyClr,
    brightness: Brightness.dark,
  );
}
