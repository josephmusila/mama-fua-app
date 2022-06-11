import 'package:flutter/material.dart';
import 'package:fua/widgets/customWidget.dart';

class RegisterScreen extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        backgroundColor: Color.fromRGBO(30, 142, 233, 1),
      ),
      body: Container(
        child: ListView(
          children: [
            CustomWidgets().fieldRow("First Name", email, false),
            CustomWidgets().box(5),
            CustomWidgets().fieldRow("Last Name", password, false),
            CustomWidgets().box(5),
            CustomWidgets().fieldRow("Email", password, false),
            CustomWidgets().box(5),
            CustomWidgets().fieldRow("Phone Number", password, false),
            CustomWidgets().box(5),
            CustomWidgets().fieldRow("Password", password, true),
            CustomWidgets().box(5),
            CustomWidgets().fieldRow("Confirm Password", password, true),
            CustomWidgets().box(5),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: const Text(
                    "Upload Passport",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.upload,
                    ),
                    onPressed: () {},
                    label: const Text("Open Gallery"),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 50, right: 50),
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: () {},
                child: Text("Register"),
                textColor: Colors.white,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
