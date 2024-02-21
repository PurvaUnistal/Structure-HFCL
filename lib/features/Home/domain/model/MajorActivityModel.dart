// To parse this JSON data, do
//
//     final majorActivityModel = majorActivityModelFromJson(jsonString);

import 'dart:convert';

MajorActivityModel majorActivityModelFromJson(String str) => MajorActivityModel.fromJson(json.decode(str));

String majorActivityModelToJson(MajorActivityModel data) => json.encode(data.toJson());

class MajorActivityModel {
  final bool status;
  final int total;
  final List<MajorActivityData> data;

  MajorActivityModel({
    required this.status,
    required this.total,
    required this.data,
  });

  factory MajorActivityModel.fromJson(Map<String, dynamic> json) => MajorActivityModel(
    status: json["status"] ?? "",
    total: json["total"] ?? "",
    data: json["data"] == null ? []:List<MajorActivityData>.from(json["data"].map((x) => MajorActivityData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MajorActivityData {
  final String? majorActivityId;
  final String? majorActivity;

  MajorActivityData({
     this.majorActivityId,
     this.majorActivity,
  });

  factory MajorActivityData.fromJson(Map<String, dynamic> json) => MajorActivityData(
    majorActivityId: json["major_activity_id"]  == null?  "" : json["major_activity_id"],
    majorActivity: json["major_activity"] == null ? "" : json["major_activity"],
  );

  Map<String, dynamic> toJson() => {
    "major_activity_id": majorActivityId,
    "major_activity": majorActivity,
  };
  @override
  String toString() {
    // TODO: implement toString
    return majorActivity.toString();
  }
}
