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
  final String? success;

  SubmitModel({
    this.status,
    this.message,
    this.errors,
    this.success,
  });

  factory SubmitModel.fromJson(Map<String, dynamic> json) => SubmitModel(
        status: json["status"] == null ? null : json["status"],
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        errors: json["errors"] == null ? null : json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "errors": errors,
      };
}
