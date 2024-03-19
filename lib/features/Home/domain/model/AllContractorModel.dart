import 'dart:convert';

AllContractorModel allContractorModelFromJson(String str) => AllContractorModel.fromJson(json.decode(str));

String allContractorModelToJson(AllContractorModel data) => json.encode(data.toJson());

class AllContractorModel {
  int? success;
  bool? error;
  List<AllContractorData>? data;

  AllContractorModel({this.success, this.error, this.data});

  AllContractorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['data'] != null) {
      data = <AllContractorData>[];
      json['data'].forEach((v) {
        data!.add(new AllContractorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllContractorData {
  String? id;
  String? companyName;
  String? vendorCode;
  String? address;
  String? town;
  String? district;
  Null? states;
  String? phoneNumber;
  String? officerName;
  String? companyEmail;
  String? intentId;
  String? assignedGa;
  String? woNumber;
  String? bankName;
  String? accountNo;
  String? ifscCode;
  String? bankAddress;
  String? gstNumber;
  String? woValidityDate;
  String? woOrderDate;
  String? contractorZone;
  String? state;
  String? interstate;
  String? subcontractorId;
  String? intentName;
  String? isDisplay;
  String? redirectUrl;
  String? label;
  String? showOnDashboard;
  dynamic sortOrder;
  String? name;

  AllContractorData(
      {this.id,
        this.companyName,
        this.vendorCode,
        this.address,
        this.town,
        this.district,
        this.states,
        this.phoneNumber,
        this.officerName,
        this.companyEmail,
        this.intentId,
        this.assignedGa,
        this.woNumber,
        this.bankName,
        this.accountNo,
        this.ifscCode,
        this.bankAddress,
        this.gstNumber,
        this.woValidityDate,
        this.woOrderDate,
        this.contractorZone,
        this.state,
        this.interstate,
        this.subcontractorId,
        this.intentName,
        this.isDisplay,
        this.redirectUrl,
        this.label,
        this.showOnDashboard,
        this.sortOrder,
        this.name});

  AllContractorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    vendorCode = json['vendor_code'];
    address = json['address'];
    town = json['town'];
    district = json['district'];
    states = json['states'];
    phoneNumber = json['phone_number'];
    officerName = json['officer_name'];
    companyEmail = json['company_email'];
    intentId = json['intent_id'];
    assignedGa = json['assigned_ga'];
    woNumber = json['wo_number'];
    bankName = json['bank_name'];
    accountNo = json['account_no'];
    ifscCode = json['ifsc_code'];
    bankAddress = json['bank_address'];
    gstNumber = json['gst_number'];
    woValidityDate = json['wo_validity_date'];
    woOrderDate = json['wo_order_date'];
    contractorZone = json['contractor_zone'];
    state = json['state'];
    interstate = json['interstate'];
    subcontractorId = json['subcontractor_id'];
    intentName = json['intent_name'];
    isDisplay = json['is_display'];
    redirectUrl = json['redirect_url'];
    label = json['label'];
    showOnDashboard = json['show_on_dashboard'];
    sortOrder = json['sort_order'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['vendor_code'] = this.vendorCode;
    data['address'] = this.address;
    data['town'] = this.town;
    data['district'] = this.district;
    data['states'] = this.states;
    data['phone_number'] = this.phoneNumber;
    data['officer_name'] = this.officerName;
    data['company_email'] = this.companyEmail;
    data['intent_id'] = this.intentId;
    data['assigned_ga'] = this.assignedGa;
    data['wo_number'] = this.woNumber;
    data['bank_name'] = this.bankName;
    data['account_no'] = this.accountNo;
    data['ifsc_code'] = this.ifscCode;
    data['bank_address'] = this.bankAddress;
    data['gst_number'] = this.gstNumber;
    data['wo_validity_date'] = this.woValidityDate;
    data['wo_order_date'] = this.woOrderDate;
    data['contractor_zone'] = this.contractorZone;
    data['state'] = this.state;
    data['interstate'] = this.interstate;
    data['subcontractor_id'] = this.subcontractorId;
    data['intent_name'] = this.intentName;
    data['is_display'] = this.isDisplay;
    data['redirect_url'] = this.redirectUrl;
    data['label'] = this.label;
    data['show_on_dashboard'] = this.showOnDashboard;
    data['sort_order'] = this.sortOrder;
    data['name'] = this.name;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return companyName.toString();
  }
}
