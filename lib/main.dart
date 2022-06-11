import 'package:flutter/material.dart';
import 'package:fua/screens/homeScreen.dart';
import 'package:flutter/services.dart';

void main() {
  Color barColor = Colors.white;
  SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.amber, // navigation bar color
    statusBarColor: barColor, // status bar color
    // statusBarIconBrightness: Brightness.dark, // status bar icon color
    systemNavigationBarIconBrightness:
        Brightness.dark, // color of navigation controls
    systemNavigationBarColor: barColor,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Feliz Cleaners',
      home: HomePage(),
    );
  }
}
