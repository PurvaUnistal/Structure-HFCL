class DistrictsModel {
  bool? status;
  int? total;
  List<DistrictData>? data;

  DistrictsModel({this.status, this.total, this.data});

  DistrictsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    total = json['total'];
    if (json['data'] != null) {
      data = <DistrictData>[];
      json['data'].forEach((v) {
        data!.add(new DistrictData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistrictData {
  String? networkType;
  String? networkTypeId;

  DistrictData({this.networkType, this.networkTypeId});

  DistrictData.fromJson(Map<String, dynamic> json) {
    networkType = json['network_type'] ?? "";
    networkTypeId = json['network_type_id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['network_type'] = this.networkType;
    data['network_type_id'] = this.networkTypeId;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return networkType.toString();
  }
}
