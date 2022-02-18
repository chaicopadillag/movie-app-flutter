import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Colors.purple;
  static const Color secundaryColor = Colors.indigo;
  static const Color dangerColor = Colors.pink;
  static final lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 0,
    ),
  );
}
