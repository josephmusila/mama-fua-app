import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fua/main.dart';
import 'package:fua/screens/loginPage.dart';
import 'package:fua/screens/registerScreen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

   @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    // print('ready in 3...');
    // await Future.delayed(const Duration(seconds: 1));
    // print('ready in 2...');
    // await Future.delayed(const Duration(seconds: 1));
    // print('ready in 1...');
    // await Future.delayed(const Duration(seconds: 1));
    // print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.maxFinite,
        width: double.maxFinite,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                // ignore: prefer_const_constructors
                image: DecorationImage(
                  image: AssetImage(
                    "img/fua.png",
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                margin: const EdgeInsets.all(20),
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      elevation: 5,
                      color: Colors.blue,
                      padding: EdgeInsets.all(12.0),
                      minWidth: double.infinity,
                      onPressed: () {
                        Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return WorkerLogin();
                    }));
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      
                      elevation: 5,
                      color: Colors.white,
                      padding: EdgeInsets.all(12.0),
                      minWidth: double.infinity,
                      onPressed: () {
                         Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return RegisterScreen();
                            }));
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
