// To parse this JSON data, do
//
//     final districtsModel = districtsModelFromJson(jsonString);

import 'dart:convert';

DistrictsModel districtsModelFromJson(String str) => DistrictsModel.fromJson(json.decode(str));

String districtsModelToJson(DistrictsModel data) => json.encode(data.toJson());

class DistrictsModel {
  final bool status;
  final int total;
  final List<DistrictsData> data;

  DistrictsModel({
    required this.status,
    required this.total,
    required this.data,
  });

  factory DistrictsModel.fromJson(Map<String, dynamic> json) => DistrictsModel(
    status: json["status"],
    total: json["total"],
    data: List<DistrictsData>.from(json["data"].map((x) => DistrictsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DistrictsData {
  final String networkType;

  DistrictsData({
    required this.networkType,
  });

  factory DistrictsData.fromJson(Map<String, dynamic> json) => DistrictsData(
    networkType: json["network_type"],
  );

  Map<String, dynamic> toJson() => {
    "network_type": networkType,
  };
  @override
  String toString() {
    // TODO: implement toString
    return networkType.toString();
  }
}
