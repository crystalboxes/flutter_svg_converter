import 'package:flutter/material.dart';

final customLightTheme = ThemeData(
  accentColor: Colors.grey,
  primaryColor: Colors.black,
  selectedRowColor: Colors.grey[500],
  secondaryHeaderColor: const Color(0xFF707070),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: Colors.black,
    ),
    headline4: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.black,
    ),
    headline5: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 10,
      height: 24 / 10,
      color: Color(0xFF787878),
      letterSpacing: 1.5,
    ),
    bodyText1: TextStyle(
      height: 1.5,
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: Colors.black,
    ),
  ),
);
