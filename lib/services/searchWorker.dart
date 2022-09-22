import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:fua/services/authServise.dart';

class SearchWorker {
  Future<WorkerList> getWorkerBySearch(String keyword) async {
    var response =
        await http.get(Uri.parse("${BaseUrl().baseUrl}search/$keyword"));
    // print(response.body);
    return WorkerList.fromList(jsonDecode(response.body));
  }
}

class Worker {
  int id;
  String firstName;
  String lastName;
  String phone;
  String email;
  String avatar;
  String location;
  Worker({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.location,
  });

  factory Worker.fromJson(map) {
    return Worker(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      phone: map['phone'],
      email: map['email'],
      avatar: map['avatar'],
      location: map['location'],
    );
  }
}

class WorkerList {
  List<Worker> workers;
  WorkerList({
    required this.workers,
  });

  factory WorkerList.fromList(List list) {
    List<Worker> workers = [];
    list.forEach((element) {
      workers.add(Worker.fromJson(element));
    });

    return WorkerList(workers: workers);
  }
}
