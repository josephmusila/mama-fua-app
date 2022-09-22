// To parse this JSON data, do
//
//     final currentUser = currentUserFromJson(jsonString);

import 'dart:convert';

import 'package:fua/services/authServise.dart';
import 'package:http/http.dart' as http;

class CurrentUserService {
  
  User getSingleUser(int id, String firstName, String lastName, String phone,
      String email, String avatar, String location) {
    return User(
        avatar: avatar,
        id: id,
        firstName: firstName,
        lastName: lastName,
        location: location,
        email: email,
        phone: phone);
  }

  Future<dynamic?> getUser(String? email) async {
    var response = await http.get(Uri.parse("${BaseUrl().baseUrl}user/$email"));
    var users = UserList.fromList(jsonDecode(response.body));
    var user = users.users[0];
    // print(user);
    getSingleUser(user.id, user.firstName, user.lastName, user.phone,
        user.email, user.avatar, user.location);
  }
}

class User {
  int id;
  String firstName;
  String lastName;
  String phone;
  String email;
  String avatar;
  String location;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.location,
  });

  factory User.fromJson(map) {
    return User(
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

class UserList {
  List<User> users;
  UserList({
    required this.users,
  });

  factory UserList.fromList(List list) {
    List<User> users = [];
    list.forEach((element) {
      users.add(User.fromJson(element));
    });

    return UserList(users: users);
  }
}
