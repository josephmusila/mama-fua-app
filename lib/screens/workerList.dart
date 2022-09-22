import 'package:flutter/material.dart';

import 'package:fua/screens/profileScreen.dart';
import 'package:fua/services/searchWorker.dart';

class WorkersListScreen extends StatefulWidget {
  List<Worker> workers;
  String title;
  WorkersListScreen({
    Key? key,
    required this.workers,
    required this.title,
  }) : super(key: key);

  @override
  State<WorkersListScreen> createState() => _WorkersListScreen();
}

class _WorkersListScreen extends State<WorkersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Selected Location: ${widget.title}",
          style: TextStyle(
            fontSize: 16,
            color: Colors.blue,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(53, 0, 0, 0),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    widget.workers.length == 1
                        ? "${widget.workers.length.toString()} worker found"
                        : "${widget.workers.length.toString()} workers found",
                  ),
                  Spacer(),
                  const Divider(
                    height: 3,
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: widget.workers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(
                        widget.workers[index].avatar,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(
                          "Name: ${widget.workers[index].firstName} ${widget.workers[index].lastName}"),
                      subtitle:
                          Text("Location: ${widget.workers[index].location}"),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) {
                              return ProfileScreen(
                                  worker: widget.workers[index]);
                            }),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
