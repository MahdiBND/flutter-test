import 'package:flutter/material.dart';
import 'package:my_app/grid.dart';
import 'test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme(context),
      darkTheme: darkTheme,
      home: const NameGrid(),
    );
  }
}

ThemeData lightTheme(BuildContext context) {
  return ThemeData.light();
}

ThemeData darkTheme = ThemeData.dark();