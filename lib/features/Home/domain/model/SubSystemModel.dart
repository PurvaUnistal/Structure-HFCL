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
  final List<FinalSubSystemData>? finalData;

  SubSystemModel({
     this.status,
     this.total,
     this.data,
     this.finalData,
  });

  factory SubSystemModel.fromJson(Map<String, dynamic> json) => SubSystemModel(
    status: json["status"],
    total: json["total"],
    data: List<SubSystemData>.from(json["data"].map((x) => SubSystemData.fromJson(x))),
    finalData: List<FinalSubSystemData>.from(json["finalData"].map((x) => FinalSubSystemData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total": total,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "finalData": List<dynamic>.from(finalData!.map((x) => x.toJson())),
  };
}

class SubSystemData {
  final String id;
  final String subSystem;
  final String parentId;

  SubSystemData({
    required this.id,
    required this.subSystem,
    required this.parentId,
  });

  factory SubSystemData.fromJson(Map<String, dynamic> json) => SubSystemData(
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

class FinalSubSystemData {
  final List<String>? id;
  final String? subSystem;
  final String? parentId;

  FinalSubSystemData({
     this.id,
     this.subSystem,
     this.parentId,
  });

  factory FinalSubSystemData.fromJson(Map<String, dynamic> json) => FinalSubSystemData(
    id: List<String>.from(json["id"].map((x) => x)),
    subSystem: json["sub_system"],
    parentId: json["parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": List<dynamic>.from(id!.map((x) => x)),
    "sub_system": subSystem,
    "parent_id": parentId,
  };
}
