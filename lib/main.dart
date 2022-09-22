import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fua/screens/welcomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fua/screens/homeScreen.dart';
import 'package:fua/screens/loginPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  Color barColor = Colors.white;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.amber, // navigation bar color
    statusBarColor: barColor, // status bar color
    // statusBarIconBrightness: Brightness.dark, // status bar icon color
    systemNavigationBarIconBrightness:
        Brightness.dark, // color of navigation controls
    systemNavigationBarColor: barColor,
  ));
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MaterialApp(
      home: email == null
          ? LoginPage()
          : MyApp(
              email: email,
            ),),);
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(milliseconds: 1));
}

class MyApp extends StatelessWidget {
  String email;
  MyApp({
    Key? key,
    required this.email,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Feliz Cleaners',
      home: HomePage(email),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Feliz Cleaners',
      home: WelcomePage(),
    );
  }
}
