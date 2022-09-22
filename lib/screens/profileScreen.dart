import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:fua/models/user.dart';
import 'package:flutter_sms/flutter_sms.dart';
import '../services/searchWorker.dart';
import '../widgets/profilecard.dart';

class ProfileScreen extends StatefulWidget {
  final Worker worker;

  ProfileScreen({required this.worker});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int rating = 5;

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    // isClicked
    //     ? showDialog(
    //         context: context,
    //         builder: (_) => AlertDialog(
    //               title: Text('Dialog Title'),
    //               content: Text('This is my content'),
    //             ))
    //     : Container();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.maxFinite,
              child: Image.network(
                widget.worker.avatar,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(66, 248, 205, 205),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.worker.firstName} ${widget.worker.lastName}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                            ),
                            Text(
                              widget.worker.location,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          height: 50,
                          child: Row(
                            children: [
                              ProfileCard(
                                label: "Age",
                                value: widget.worker.id.toString(),
                              ),
                              ProfileCard(
                                label: "Gender",
                                value: "",
                              ),
                              ProfileCard(
                                label: "Status",
                                value: "",
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            height: 50,
                            width: double.maxFinite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Average rating: ",
                                ),
                                Wrap(
                                  children: List.generate(
                                    5,
                                    (index) {
                                      return Icon(
                                        Icons.star,
                                        size: 16,
                                        color: index < rating
                                            ? Colors.yellow
                                            : Colors.grey,
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(235, 8, 126, 18),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  // setState(() {
                                  //   isClicked = true;
                                  // });
                                  sending_SMS('Hello, this the test message',
                                      [widget.worker.phone.toString()]);
                                  // const CircularProgressIndicator();
                                },
                                icon: const Icon(
                                  Icons.message,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                const url =
                                    "https://wa.me/?text=Hey buddy, try this super cool new app!";
                                if (await canLaunch(url)) {
                                  const CircularProgressIndicator();
                                  await launch(url);
                                  // const CircularProgressIndicator();
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: const Text(
                                "Whatsapp",
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(235, 126, 8, 53),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  launch(
                                      ('tel://${widget.worker.phone}'));
                                },
                                icon: const Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Container(
                            width: double.maxFinite,
                            height: 300,
                            child: const Text(
                              "Comments",
                              textAlign: TextAlign.center,
                            )),
                      ],
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

  void sending_SMS(String msg, List<String> list_receipents) async {
    String send_result =
        await sendSMS(message: msg, recipients: list_receipents)
            .catchError((err) {
      print(err);
    });
    print(send_result);
  }
}
