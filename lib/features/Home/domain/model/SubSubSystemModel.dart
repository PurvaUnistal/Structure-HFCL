// To parse this JSON data, do
//
//     final subSubSystemModel = subSubSystemModelFromJson(jsonString);

import 'dart:convert';

SubSubSystemModel subSubSystemModelFromJson(String str) => SubSubSystemModel.fromJson(json.decode(str));

String subSubSystemModelToJson(SubSubSystemModel data) => json.encode(data.toJson());

class SubSubSystemModel {
  final bool? status;
  final int? total;
  final List<SubSubSystemData>? data;

  SubSubSystemModel({
     this.status,
     this.total,
     this.data,
  });

  factory SubSubSystemModel.fromJson(Map<String, dynamic> json) => SubSubSystemModel(
    status: json["status"],
    total: json["total"],
    data: List<SubSubSystemData>.from(json["data"].map((x) => SubSubSystemData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total": total,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SubSubSystemData {
  final String? id;
  final String? subSystem;
  final String? parentId;

  SubSubSystemData({
     this.id,
     this.subSystem,
     this.parentId,
  });

  factory SubSubSystemData.fromJson(Map<String, dynamic> json) => SubSubSystemData(
    id: json["id"],
    subSystem: json["sub_system"],
    parentId: json["parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_system": subSystem,
    "parent_id": parentId,
  };
}
