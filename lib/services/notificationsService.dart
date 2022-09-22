

import 'dart:convert';




import 'package:http/http.dart' as http;

import 'package:fua/services/authServise.dart';

class NotificationService {
  Future<List<MyNotifications>> getotifications(String id) async {
    var response = await http.get(Uri.parse("${BaseUrl().baseUrl}notifications/$id"));

    try {
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);
        return list.map((e) => MyNotifications.fromJson(e)).toList();
      } else {
        return <MyNotifications>[];
      }
    } on Exception catch (e) {
      print(e);
      return <MyNotifications>[];
    }

    // print(response);
  }
}

List<MyNotifications> myNotificationsFromJson(String str) => List<MyNotifications>.from(json.decode(str).map((x) => MyNotifications.fromJson(x)));

String myNotificationsToJson(List<MyNotifications> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyNotifications {
    MyNotifications({
       required this.notification,
       required this.user,
       required this.dateCreated,
    });

    String notification;
    String user;
    DateTime dateCreated;

    factory MyNotifications.fromJson(Map<String, dynamic> json) => MyNotifications(
        notification: json["notification"],
        user: json["user"],
        dateCreated: DateTime.parse(json["date_created"]),
    );

    Map<String, dynamic> toJson() => {
        "notification": notification,
        "user": user,
        "date_created": "${dateCreated.year.toString().padLeft(4, '0')}-${dateCreated.month.toString().padLeft(2, '0')}-${dateCreated.day.toString().padLeft(2, '0')}",
    };
}
