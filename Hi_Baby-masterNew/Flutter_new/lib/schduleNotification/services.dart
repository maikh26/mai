import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class themeServices {
  final _box = GetStorage();
  final _key = 'isdarkmode';
  _savethemetobox(bool isdarkmode) => _box.write(_key, isdarkmode);
  bool _loadThemfrombox() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadThemfrombox() ? ThemeMode.dark : ThemeMode.light;
  void switchtheme() {
    Get.changeThemeMode(_loadThemfrombox() ? ThemeMode.light : ThemeMode.dark);
    _savethemetobox(!_loadThemfrombox());
  }
}
