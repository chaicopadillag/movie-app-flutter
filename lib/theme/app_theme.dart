import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color.fromRGBO(13, 71, 161, 1);
  static const Color secundaryColor = Colors.blueAccent;
  static const Color dangerColor = Colors.pink;
  static final lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 0,
    ),
  );
}
