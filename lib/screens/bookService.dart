import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fua/services/authServise.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookService extends StatefulWidget {
  String? email;
   BookService({
    Key? key,
    required this.email,
  }) : super(key: key);
  @override
  State<BookService> createState() => _BookServiceState();
}

class _BookServiceState extends State<BookService> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  final _formKey = GlobalKey<FormState>();
  var descriptionController = TextEditingController();
  var locationController = TextEditingController();
  var count = 0;

  bool isLoading = false;

  void showDatePickerModel() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),
            lastDate: DateTime(2024))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDay = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Book Services",
          ),
        ),
        body: isLoading
            ? Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Color.fromARGB(91, 226, 222, 222),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Sending .."),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                height: double.maxFinite,
                width: double.maxFinite,
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text(
                        "Thank you For Choosing feliz Cleaners to serve you",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(),
                    Container(
                      child: const Text(
                        "Please fill out the form below",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(
                      color: Colors.blue,
                    ),
                    Container(
                      child: const Text(
                        "Enter your Location description",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              onChanged: (value) {
                                RegExp regExp = RegExp(" ");
                                count = regExp.allMatches(value).length + 1;
                              },
                              controller: locationController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                } else if (value.length < 10) {
                                  return "Please use a minimum of 20 characters";
                                }

                                return null;
                              },
                              minLines: 2,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText:
                                    'Please enter a description  your Location here ...',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                              ),
                            ),
                            const Divider(),
                            Container(
                              child: const Text("Enter your work description"),
                            ),
                            TextFormField(
                              onChanged: (value) {
                                RegExp regExp = RegExp(" ");
                                count = regExp.allMatches(value).length + 1;
                              },
                              controller: descriptionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                } else if (value.length < 10) {
                                  return "Please use a minimum of 20 characters";
                                }

                                return null;
                              },
                              minLines: 2,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText:
                                    'Please enter your work description here ...',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                              ),
                            ),
                            const Divider(),
                            Container(
                              child: const Text(
                                  "Select a date when the work should start"),
                            ),
                            Container(
                              height: 70,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(_selectedDay == null
                                          ? "No Date Chosen!!"
                                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDay!)}')),
                                  Platform.isIOS
                                      ? CupertinoButton(
                                          onPressed: () {
                                            showDatePickerModel();
                                          },
                                          child: Text("Choose Date"))
                                      : ElevatedButton(
                                          onPressed: () {
                                            showDatePickerModel();
                                          },
                                          child: Text("Choose Date"))
                                ],
                              ),
                            ),
                            const Divider(),
                            Container(
                              child: Center(
                                  child: ElevatedButton(
                                child: const Text(
                                  "Submit Request",
                                ),
                                onPressed: () async {
                                  if (_selectedDay == null) {
                                    showDatePickerModel();
                                  } else if (_formKey.currentState!
                                      .validate()) {
                                    //todo
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                child: Center(
                                                  child: const Text(
                                                    "Confirm the Details",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            Colors.deepOrange),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              const Divider(),
                                              Row(
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      "Description:",
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      descriptionController
                                                          .text,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(),
                                              Row(
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      "Date:",
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(formatter
                                                        .format(_selectedDay!)),
                                                  ),
                                                ],
                                              ),
                                              const Divider(),
                                              Row(
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      "Location:",
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        locationController
                                                            .text),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 100,
                                                child: Center(                                                                                                                                                     
                                                    child: ElevatedButton(
                                                  onPressed: () async {
                                                    var url = Uri.parse(
                                                        "${BaseUrl().baseUrl}workerRequest/");
                                                    var response = await http
                                                        .post(url, body: {
                                                      "work_description":      
                                                         descriptionController.text,
                                                         
                                                      "requested_by":
                                                          widget.email,
                                                      "job_date":
                                                          formatter.format(
                                                              _selectedDay!),
                                                      "location":
                                                          locationController
                                                              .text,
                                                      
                                                    });

                                                    print(response.body);
                                                    print(formatter
                                                        .format(_selectedDay!));

                                                    if (response.statusCode ==
                                                        200) {
                                                      locationController.text =
                                                          "";
                                                      descriptionController
                                                          .text = "";

                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "Request Sent Succesfully"),
                                                        ),
                                                      );
                                                    } else {
                                                      // Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "An error occurred"),
                                                        ),
                                                      );
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Text(
                                                    "Confirm",
                                                  ),
                                                )),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Correct the shown errors')),
                                    );
                                  }
                                },
                              )),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }
}
