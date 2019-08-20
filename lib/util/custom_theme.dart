import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme {
  static ThemeItem theme;

  static init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeKey = prefs.getString('theme');
    if (themeKey == null) {
      themeKey = '蓝蓝蓝';
    }
    theme = CustomTheme.themes[themeKey];
  }

  static List<String> themeKeys = ['蓝蓝蓝', '白白白', '灰灰灰', '黑黑黑', '红红红', '橙橙橙'];

  static Map<String, ThemeItem> themes = {
    '蓝蓝蓝': ThemeItem(Colors.blue, Colors.blue, Colors.white, Colors.white),
    '白白白': ThemeItem(Colors.white, Colors.black, Colors.white, Colors.black),
    '灰灰灰':
        ThemeItem(Colors.blueGrey, Colors.blueGrey, Colors.white, Colors.white),
    '黑黑黑': ThemeItem(Colors.black, Colors.black, Colors.white, Colors.white),
    '红红红': ThemeItem(Colors.red, Colors.red, Colors.white, Colors.white),
    '橙橙橙': ThemeItem(Colors.deepOrangeAccent, Colors.deepOrangeAccent,
        Colors.white, Colors.white),
  };
}

class ThemeItem {
  Color primaryColor;
  Color selectedNavItemColor;
  Color backgroundColor;
  Color iconColor;

  ThemeItem(this.primaryColor, this.selectedNavItemColor, this.backgroundColor,
      this.iconColor);
}
