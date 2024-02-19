// To parse this JSON data, do
//
//     final quantityModel = quantityModelFromJson(jsonString);

import 'dart:convert';

QuantityModel quantityModelFromJson(String str) => QuantityModel.fromJson(json.decode(str));

String quantityModelToJson(QuantityModel data) => json.encode(data.toJson());

class QuantityModel {
  final bool status;
  final QuantityData data;

  QuantityModel({
    required this.status,
    required this.data,
  });

  factory QuantityModel.fromJson(Map<String, dynamic> json) => QuantityModel(
    status: json["status"],
    data: QuantityData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class QuantityData {
  final String? boqId;
  final String? quantity;
  final String? uomName;

  QuantityData({
     this.boqId,
     this.quantity,
     this.uomName,
  });

  factory QuantityData.fromJson(Map<String, dynamic> json) => QuantityData(
    boqId: json["boq_id"] ?? "",
    quantity: json["quantity"] ?? "",
    uomName: json["uom_name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "boq_id": boqId,
    "quantity": quantity,
    "uom_name": uomName,
  };
  @override
  String toString() {
    // TODO: implement toString
    return uomName.toString();
  }
}
