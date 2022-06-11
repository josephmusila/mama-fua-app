import 'package:flutter/material.dart';
import 'package:fua/screens/registerScreen.dart';
import 'package:fua/widgets/customWidget.dart';

class WorkerLogin extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Worker Log In"),
        backgroundColor: Color.fromRGBO(30, 142, 233, 1),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              height: 200,
              // child: Image.asset("assets/profile2.jpg"),
            ),
            CustomWidgets().fieldRow("Email", email, false),
            CustomWidgets().box(20),
            CustomWidgets().fieldRow("Password", password, true),
            CustomWidgets().box(20),
            Container(
              margin: EdgeInsets.only(left: 50, right: 50),
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: () {},
                child: Text("Log In"),
                textColor: Colors.white,
                color: Colors.green,
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return RegisterScreen();
                }));
                  },
                  child: const Text(
                    "New Worker?  Register Here",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
