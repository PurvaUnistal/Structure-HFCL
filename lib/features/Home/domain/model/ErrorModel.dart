// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  final bool? success;
  final String? errors;

  ErrorModel({
     this.success,
     this.errors,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    success: json["success"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "errors": errors,
  };
}
