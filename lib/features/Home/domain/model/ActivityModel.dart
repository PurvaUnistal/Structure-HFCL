// To parse this JSON data, do
//
//     final activityModel = activityModelFromJson(jsonString);

import 'dart:convert';

ActivityModel activityModelFromJson(String str) => ActivityModel.fromJson(json.decode(str));

String activityModelToJson(ActivityModel data) => json.encode(data.toJson());

class ActivityModel {
  final bool? status;
  final int? total;
  final List<ActivityData>? data;

  ActivityModel({
     this.status,
     this.total,
     this.data,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
    status: json["status"],
    total: json["total"],
    data: List<ActivityData>.from(json["data"].map((x) => ActivityData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total": total,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ActivityData {
  final String? id;
  final String? name;

  ActivityData({
     this.id,
     this.name,
  });

  factory ActivityData.fromJson(Map<String, dynamic> json) => ActivityData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
  @override
  String toString() {
    // TODO: implement toString
    return name.toString();
  }
}
