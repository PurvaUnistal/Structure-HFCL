// To parse this JSON data, do
//
//     final subSystemModel = subSystemModelFromJson(jsonString);

import 'dart:convert';

SubSystemModel subSystemModelFromJson(String str) => SubSystemModel.fromJson(json.decode(str));

String subSystemModelToJson(SubSystemModel data) => json.encode(data.toJson());

class SubSystemModel {
  final bool? status;
  final int? total;
  final List<SubSystemData>? data;

  SubSystemModel({
     this.status,
     this.total,
     this.data,
  });

  factory SubSystemModel.fromJson(Map<String, dynamic> json) => SubSystemModel(
    status: json["status"],
    total: json["total"],
    data: List<SubSystemData>.from(json["data"].map((x) => SubSystemData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total": total,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SubSystemData {
  final String? id;
  final String? name;

  SubSystemData({
     this.id,
     this.name,
  });

  factory SubSystemData.fromJson(Map<String, dynamic> json) => SubSystemData(
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
