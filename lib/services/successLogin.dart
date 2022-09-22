// To parse this JSON data, do
//
//     final successLoginResponse = successLoginResponseFromJson(jsonString);

import 'dart:convert';

SuccessLoginResponse successLoginResponseFromJson(String str) => SuccessLoginResponse.fromJson(json.decode(str));

String successLoginResponseToJson(SuccessLoginResponse data) => json.encode(data.toJson());

class SuccessLoginResponse {
    SuccessLoginResponse({
        required this.message,
    });

    String message;

    factory SuccessLoginResponse.fromJson(Map<String, dynamic> json) => SuccessLoginResponse(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
