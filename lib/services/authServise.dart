import 'dart:convert';
import 'package:async/async.dart';
import 'dart:io';

import 'package:fua/services/successLogin.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class BaseUrl {
  // final baseUrl = "https://feliz.herokuapp.com/api/";
  final baseUrl = "http://10.42.0.1:8000/api/";

  String url() {
    return baseUrl;
  }
}

class AuthService {                                                                                                                                                                
  final registrationUrl = Uri.parse("${BaseUrl().baseUrl}register/");
  final loginUrl = Uri.parse("${BaseUrl().baseUrl}login/");
  final userUrl = Uri.parse("${BaseUrl().baseUrl}user/");
  final logoutUrl = Uri.parse("${BaseUrl().baseUrl}logout/");
  var token = "";                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 

  Future<dynamic?> logout() async {
    var response = await http.get(logoutUrl);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
    token = "";

    print(response.body);
  }

  Future<dynamic?> registration(
      {required String firstName,
      required String lastName,
      required String accountType,
      required String phone,
      required String password,
      required String location,
      required String file,
      required String email}) async {
    var request = http.MultipartRequest('POST', registrationUrl);
    request.fields['password'] = password;
    request.fields['phone'] = phone;
    request.fields['email'] = email;
    request.fields['location'] = location;
    request.fields['first_name'] = firstName;
    request.fields['last_name'] = lastName;
    request.fields['account_type'] = accountType;
    request.files.add(await http.MultipartFile.fromPath(
      'avatar',
      file,
    ));

    var res = await request.send();

    var response = await http.Response.fromStream(res);
    // print(jsonDecode(response.body));
    // token = jsonDecode(response.body["token"]);
    return response.body;
  }

  Future<dynamic?> login({
    required String email,
    required String password,
  }) async {
    var response = await http.post(loginUrl, body: {
      "email": email,
      "password": password,
    }).timeout(const Duration(seconds: 30));
    token = jsonDecode(response.body)["token"];
    print(token);
    // getUser(token);

    return response.body;
  }

  Future<dynamic?> getUser() async {
    // var response =
    //     await http.get(userUrl, headers: {"Authorization": "TOKEN $token "});

    // var response = http.get(userUrl, headers: {
    //   HttpHeaders.contentTypeHeader: "application/json",
    //   HttpHeaders.authorizationHeader: "Bearer $token"
    // });

    // print(response);

    final response = await http.get(userUrl, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer dcbe9f707b5c463b67b7971b4e31c212769bcaba',
    });
    print('Token : $token');
    print(response.body);
  }
}
