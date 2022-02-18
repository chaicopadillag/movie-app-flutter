import 'package:flutter/material.dart';
import 'package:movie_app/screens/screens.dart';
import 'package:movie_app/theme/app_theme.dart';

void main() => runApp(const MovieApp());

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        initialRoute: 'home',
        routes: {
          'home': (context) => const HomeScreen(),
          'detail': (context) => const DetailScreen(),
        },
        theme: AppTheme.lightTheme);
  }
}
