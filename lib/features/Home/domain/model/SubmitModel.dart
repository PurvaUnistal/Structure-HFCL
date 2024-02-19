// To parse this JSON data, do
//
//     final submitModel = submitModelFromJson(jsonString);

import 'dart:convert';

SubmitModel submitModelFromJson(String str) => SubmitModel.fromJson(json.decode(str));

String submitModelToJson(SubmitModel data) => json.encode(data.toJson());

class SubmitModel {
  final bool? status;
  final String? message;
  final String? errors;

  SubmitModel({
     this.status,
     this.message,
     this.errors,
  });

  factory SubmitModel.fromJson(Map<String, dynamic> json) => SubmitModel(
    status: json["status"],
    message: json["message"] == null ? null :json["message"],
    errors: json["errors"] == null ? null :json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "errors": errors,
  };
}
