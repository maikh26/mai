// ignore_for_file: unused_import

import 'package:blogapp/Pages/Home.dart';
import 'package:blogapp/Pages/comment.dart';
import 'package:blogapp/Pages/login2.dart';
import 'package:blogapp/group.dart';
import 'package:blogapp/schduleNotification/homeSchdule.dart';
import 'package:blogapp/schduleNotification/services.dart';
import 'package:blogapp/schduleNotification/themes.dart';
import 'package:blogapp/vaccine/vaccine.dart';
//import 'package:blogapp/schduleNotification/theme.dart';

// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: unused_import

// ignore: unused_import
import 'Pages/dashboard.dart';
import 'Pages/homepageNew.dart';
import 'Profile/CreatProfile.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Screens/landing_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter LoginPage',
      debugShowCheckedModeBanner: false,
      theme: themes.light,
      darkTheme: themes.dark,
      themeMode: themeServices().theme,
      home: LandingScreen(),
    );
  }
}
