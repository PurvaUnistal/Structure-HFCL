// To parse this JSON data, do
//
//     final activityStartDateModel = activityStartDateModelFromJson(jsonString);

import 'dart:convert';

ActivityStartDateModel activityStartDateModelFromJson(String str) => ActivityStartDateModel.fromJson(json.decode(str));

String activityStartDateModelToJson(ActivityStartDateModel data) => json.encode(data.toJson());

class ActivityStartDateModel {
  final bool? status;
  final DateTime? data;

  ActivityStartDateModel({
    this.status,
    this.data,
  });

  factory ActivityStartDateModel.fromJson(Map<String, dynamic> json) => ActivityStartDateModel(
        status: json["status"],
        data: json["data"].toString().isNotEmpty ? DateTime.parse(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": "${data!.year.toString().padLeft(4, '0')}-${data!.month.toString().padLeft(2, '0')}-${data!.day.toString().padLeft(2, '0')}",
      };
  @override
  String toString() {
    // TODO: implement toString
    return data!.toIso8601String();
  }
}
