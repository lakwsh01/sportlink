import 'package:flutter/material.dart';

enum StandardTheme { light, dark }

const fontFamilyChinese = "NotoSansTC";

extension StandardThemeMethod on StandardTheme {
  ThemeData get theme {
    switch (this) {
      case StandardTheme.dark:
        return ThemeData(
            scaffoldBackgroundColor: Colors.black,
            splashColor: Colors.blueAccent,
            primaryColor: Colors.white,
            brightness: Brightness.dark,
            fontFamily: fontFamilyChinese,
            textTheme: TextTheme(titleMedium: TextStyle(fontSize: 18)));

      default:
        return ThemeData(
          fontFamily: fontFamilyChinese,
        );
    }
  }
}
