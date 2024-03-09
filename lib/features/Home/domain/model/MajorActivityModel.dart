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
        status: json["status"],
        total: json["total"],
        data: List<MajorActivityData>.from(json["data"].map((x) => MajorActivityData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MajorActivityData {
  final String? id;
  final String? subSystem;
  final String? parentId;

  MajorActivityData({
    this.id,
    this.subSystem,
    this.parentId,
  });

  factory MajorActivityData.fromJson(Map<String, dynamic> json) => MajorActivityData(
        id: json["id"],
        subSystem: json["sub_system"],
        parentId: json["parent_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_system": subSystem,
        "parent_id": parentId,
      };
  @override
  String toString() {
    // TODO: implement toString
    return subSystem.toString();
  }
}
