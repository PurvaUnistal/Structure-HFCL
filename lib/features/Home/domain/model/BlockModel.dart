// To parse this JSON data, do
//
//     final blockModel = blockModelFromJson(jsonString);

import 'dart:convert';

BlockModel blockModelFromJson(String str) => BlockModel.fromJson(json.decode(str));

String blockModelToJson(BlockModel data) => json.encode(data.toJson());

class BlockModel {
  final bool status;
  final int total;
  final List<BlockData> data;

  BlockModel({
    required this.status,
    required this.total,
    required this.data,
  });

  factory BlockModel.fromJson(Map<String, dynamic> json) => BlockModel(
    status: json["status"] ?? "",
    total: json["total"] ?? "",
    data: json["data"] == null ? [] :List<BlockData>.from(json["data"].map((x) => BlockData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BlockData {
  final String? block;
  final String? blockId;

  BlockData({
     this.block,
     this.blockId,
  });

  factory BlockData.fromJson(Map<String, dynamic> json) => BlockData(
    block: json["block"] ?? "",
    blockId: json["block_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "block": block,
    "block_id": blockId,
  };
  @override
  String toString() {
    // TODO: implement toString
    return block.toString();
  }
}
