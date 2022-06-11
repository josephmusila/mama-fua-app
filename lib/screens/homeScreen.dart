// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fua/models/user.dart';
import 'package:fua/screens/loginPage.dart';
import 'package:fua/screens/mapScreen.dart';
import 'package:fua/screens/notificationScreen.dart';
import 'package:fua/screens/profileScreen.dart';
import 'package:fua/widgets/servicesWidget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var textController = TextEditingController();
  List<Worker> worker = allWorkers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return NotificationScreen();
            }));
          },
          child: Icon(
            Icons.notifications,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 252, 249, 249),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return WorkerLogin();
                }));
              },
              child: Icon(
                Icons.account_circle_outlined,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                      10,
                    )),
                    color: Colors.blue,
                  ),
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text("Welcome to Mama Fua"),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "img/fua.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ServiceWidget(
                         "img/wash1.jpeg",
                        Icons.chair,
                      text: "Sofa Cleaning",
                     
                      color: Colors.blue,
                    ),
                    ServiceWidget(
                         "img/wash2.jpeg",
                        Icons.chair,
                      text: "Carpet Cleaning",
                  
                      color: Color.fromARGB(255, 183, 3, 238),
                    ),
                    ServiceWidget(
                       "img/wash3.jpeg",
                        Icons.chair,
                       
                      text: "General Laundry",
                   
                      color: Color.fromARGB(255, 248, 143, 6),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                Container(
                  margin: const EdgeInsets.all(5),
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                      20,
                    )),
                  ),
                  width: double.maxFinite,
                  //replace row with map screen
                  child: Column(
                    children: [
                      Text("${worker.length.toString()} workers found"),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.maxFinite,
                              child: TextField(
                                controller: textController,
                                textCapitalization: TextCapitalization.words,
                                onChanged: searchWorker,
                                decoration: const InputDecoration(
                                  hintText: 'Your Current Location',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  // suffixIcon: Center(child: Icon(Icons.search)),
                                ),
                              ),
                            ),
                          ),
                          // IconButton(
                          //   iconSize: 30,
                          //   color: Color.fromARGB(255, 216, 232, 245),
                          //   onPressed: () {},
                          //   icon: const Icon(Icons.search),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 400,
                  child: worker.length == 0
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          // height: 30,
                          child: Center(
                            child: const Text(
                                "No worker in your selected area. Please select another location"),
                          ),
                        )
                      : ListView.builder(
                          itemCount: worker.length,
                          itemBuilder: (context, index) {
                            final user = worker[index];
                            return ListTile(
                              leading: Image.network(
                                user.avatar,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                              title: Text(
                                  "Name: ${user.firstName} ${user.lastName}"),
                              subtitle: Text("Location: ${user.location}"),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((context) {
                                      return ProfileScreen(worker: user);
                                    }),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void searchWorker(String query) {
    final suggestions = allWorkers.where((worker) {
      final location = worker.location.toLowerCase();
      final input = query.toLowerCase();
      return location.contains(input);
    }).toList();
    print(query);

    setState(() {
      worker = suggestions;
    });
  }
}
