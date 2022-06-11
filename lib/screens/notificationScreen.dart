import 'package:flutter/material.dart';
import 'package:fua/screens/homeScreen.dart';

class NotificationScreen extends StatelessWidget {
  // const NotificationScreen({Key? key}) : super(key: key);
// var workers=[]
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return HomePage();
              }));
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.deepOrange,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 1,
          width: double.maxFinite,
          child: ListView(
            padding: const EdgeInsets.only(top: 0),
            children: [
              Container(
                color: Colors.blueAccent,
                height: MediaQuery.of(context).size.height * 0.1,
                child: const Center(
                  child: Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.blue,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        shadowColor: Colors.blue,
                        child: ListTile(
                          leading: Text((index + 1).toString()),
                          title: const Text(
                            "New notification",
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
