// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final int? status;
  final bool? error;
  final String? messages;
  final String? token;
  final User? user;
  final String? exptime;

  LoginModel({
     this.status,
     this.error,
     this.messages,
     this.token,
     this.user,
     this.exptime,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    error: json["error"],
    messages: json["messages"],
    token: json["token"],
    user: User.fromJson(json["user"]),
    exptime: json["exptime"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "messages": messages,
    "token": token,
    "user": user!.toJson(),
    "exptime": exptime,
  };
}

class User {
  final String id;
  final String gaId;
  final String email;
  final String name;
  final String level;
  final String modules;
  final String schema;
  final String role;

  User({
    required this.id,
    required this.gaId,
    required this.email,
    required this.name,
    required this.level,
    required this.modules,
    required this.schema,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    gaId: json["ga_id"],
    email: json["email"],
    name: json["name"],
    level: json["level"],
    modules: json["modules"],
    schema: json["schema"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ga_id": gaId,
    "email": email,
    "name": name,
    "level": level,
    "modules": modules,
    "schema": schema,
    "role": role,
  };
}
