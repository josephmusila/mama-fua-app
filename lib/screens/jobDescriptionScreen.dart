import 'package:flutter/material.dart';
import 'package:fua/screens/homeScreen.dart';

import 'package:fua/services/requestedJobs.dart';

class JobDescriptionScreen extends StatefulWidget {
  RequestedJobs requestedJobs;
  JobDescriptionScreen({
    required this.requestedJobs,
  });

  @override
  State<JobDescriptionScreen> createState() => _JobDescriptionScreenState();
}

class _JobDescriptionScreenState extends State<JobDescriptionScreen> {
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
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.deepOrange,
            ),
          ),
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Job Description",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.requestedJobs.workDescription,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}



