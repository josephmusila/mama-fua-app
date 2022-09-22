import 'dart:convert';
import 'package:fua/services/authServise.dart';
import "package:http/http.dart" as http;

class RequestedJobService {
  Future<List<RequestedJobs>> getRequestedJobs(String? email) async {
    var response =
        await http.get(Uri.parse("${BaseUrl().baseUrl}request_status/$email"));

    try {
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);
        List<RequestedJobs> mylist =
            list.map((e) => RequestedJobs.fromJson(e)).toList();
            print(mylist);
        return mylist;
      } else {
        return <RequestedJobs>[];
      }
    } on Exception catch (e) {
      print(e);
      return <RequestedJobs>[];
    }
  }
}

List<RequestedJobs> requestedJobsFromJson(String str) =>
    List<RequestedJobs>.from(
        json.decode(str).map((x) => RequestedJobs.fromJson(x)));

String requestedJobsToJson(List<RequestedJobs> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequestedJobs {
  RequestedJobs(
      {required this.requestedBy,
      required this.location,
      required this.workDescription,
      required this.jobDate,
      required this.dateRequested,
      required this.assignedOn,
      required this.verification,
      required this.assignedTo,
      required this.id,
      required this.fee});

  String requestedBy;
  String location;
  String workDescription;
  DateTime jobDate;
  DateTime dateRequested;
  DateTime? assignedOn;
  String verification;
  AssignedTo? assignedTo;
  String? fee;
  int id;

  factory RequestedJobs.fromJson(Map<String, dynamic> json) => RequestedJobs(
        requestedBy: json["requested_by"],
        location: json["location"],
        id:json["id"],
        fee: json["fee"] == null? null:json["fee"],
        workDescription: json["work_description"],
        jobDate: DateTime.parse(json["job_date"]),
        dateRequested: DateTime.parse(json["date_requested"]),
        assignedOn: json["assigned_on"] == null
            ? null
            : DateTime.parse(json["assigned_on"]),
        verification: json["verification"],
        assignedTo: json["assigned_to"] == null
            ? null
            : AssignedTo.fromJson(json["assigned_to"]),
      );

  Map<String, dynamic> toJson() => {
        "requested_by": requestedBy,
        "location": location,
        "work_description": workDescription,
        "job_date":
            "${jobDate.year.toString().padLeft(4, '0')}-${jobDate.month.toString().padLeft(2, '0')}-${jobDate.day.toString().padLeft(2, '0')}",
        "date_requested": dateRequested.toIso8601String(),
        "assigned_on":
            assignedOn == null ? null : assignedOn!.toIso8601String(),
        "verification": verification,
        "assigned_to": assignedTo == null ? null : assignedTo!.toJson(),
      };
}

class AssignedTo {
  AssignedTo({
    required this.id,
    required this.lastLogin,
    required this.isSuperuser,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.avatar,
    required this.location,
    required this.accountType,
    required this.groups,
    required this.userPermissions,
  });

  int id;
  DateTime? lastLogin;
  bool isSuperuser;
  bool isStaff;
  bool isActive;
  DateTime dateJoined;
  String firstName;
  String lastName;
  String email;
  String password;
  String phone;
  String? avatar;
  String location;
  String accountType;
  List<dynamic> groups;
  List<dynamic> userPermissions;

  factory AssignedTo.fromJson(Map<String, dynamic> json) => AssignedTo(
        id: json["id"],
        lastLogin: json["last_login"] == null
            ? null
            : DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        location: json["location"],
        accountType: json["account_type"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        userPermissions:
            List<dynamic>.from(json["user_permissions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_login": lastLogin == null ? null : lastLogin!.toIso8601String(),
        "is_superuser": isSuperuser,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "phone": phone,
        "avatar": avatar == null ? null : avatar,
        "location": location,
        "account_type": accountType,
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
      };
}
