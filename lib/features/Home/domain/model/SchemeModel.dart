// To parse this JSON data, do
//
//     final schemeModel = schemeModelFromJson(jsonString);

import 'dart:convert';

SchemeModel schemeModelFromJson(String str) => SchemeModel.fromJson(json.decode(str));

String schemeModelToJson(SchemeModel data) => json.encode(data.toJson());

class SchemeModel {
  final bool status;
  final int total;
  final List<SchemeData> data;

  SchemeModel({
    required this.status,
    required this.total,
    required this.data,
  });

  factory SchemeModel.fromJson(Map<String, dynamic> json) => SchemeModel(
    status: json["status"],
    total: json["total"],
    data: List<SchemeData>.from(json["data"].map((x) => SchemeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SchemeData {
  final String? scheme;
  final String? schemeId;

  SchemeData({
     this.scheme,
     this.schemeId,
  });

  factory SchemeData.fromJson(Map<String, dynamic> json) => SchemeData(
    scheme: json["scheme"] ?? "",
    schemeId: json["scheme_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "scheme": scheme,
    "scheme_id": schemeId,
  };
  @override
  String toString() {
    // TODO: implement toString
    return scheme.toString();
  }
}
