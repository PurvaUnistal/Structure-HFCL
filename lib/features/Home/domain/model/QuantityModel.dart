// To parse this JSON data, do
//
//     final quantityModel = quantityModelFromJson(jsonString);

import 'dart:convert';

QuantityModel quantityModelFromJson(String str) => QuantityModel.fromJson(json.decode(str));

String quantityModelToJson(QuantityModel data) => json.encode(data.toJson());

class QuantityModel {
  final bool? status;
  final String? activityId;
  final String? message;

  QuantityModel({
    this.status,
    this.activityId,
    this.message,
  });

  factory QuantityModel.fromJson(Map<String, dynamic> json) => QuantityModel(
        status: json["status"],
        activityId: json["activityId"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "activityId": activityId,
        "message": message,
      };
}
