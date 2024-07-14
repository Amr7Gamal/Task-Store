import 'package:flutter/material.dart';

class MyTheme {
  //Colors
  static final Color primaryColor = Color(0xff1b4f88);
  static final Color subColor = Color(0xff003f83);
  static final Color textColor = Color(0xff403b61);
  static final Color textSubColor = Color(0xff4c8aba);
  static final Color whiteColor = Color(0xffffffff);
  static final Color blackColor = Colors.black;

  //Texts Colors
  static final Color titleColor = primaryColor;
  static final Color paragraphColor = textColor;

  static final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      appBarTheme:
          AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      primaryColor: primaryColor,
      backgroundColor: subColor,
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 36, color: titleColor, fontWeight: FontWeight.w900),
        headline2: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: titleColor),
        headline3: TextStyle(fontSize: 18, color: textSubColor),
        headline4: TextStyle(fontSize: 14, color: paragraphColor),
      ));
}
