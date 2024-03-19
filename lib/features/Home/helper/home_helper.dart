import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:structure_app/Server/api_server.dart';
import 'package:structure_app/Server/app_url.dart';
import 'package:structure_app/Utils/common_widget/SharedPerfs/Prefs_Value.dart';
import 'package:structure_app/Utils/common_widget/SharedPerfs/preference_utils.dart';
import 'package:structure_app/Utils/common_widget/Utils.dart';
import 'package:structure_app/features/Home/domain/model/ActivityModel.dart';
import 'package:structure_app/features/Home/domain/model/ActivityStartDateModel.dart';
import 'package:structure_app/features/Home/domain/model/AllContractorModel.dart';
import 'package:structure_app/features/Home/domain/model/BlockModel.dart';
import 'package:structure_app/features/Home/domain/model/DistrictsModel.dart';
import 'package:structure_app/features/Home/domain/model/SchemeModel.dart';
import 'package:structure_app/features/Home/domain/model/SubSystemModel.dart';
import 'package:structure_app/features/Home/domain/model/SubmitModel.dart';

class HomeHelper {
  static Future<DistrictsModel?> districtsData({required BuildContext context}) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.districts}", context: context);
      if (res != null) {
        return districtsModelFromJson(res);
      } else {
        log("BlockModelRes-->${res}");
        return Utils.failureMeg(res, context);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
  }

  static Future<BlockModel?> blocksData({required BuildContext context, required String districtId}) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.blocks}$districtId", context: context);
      if (res != null) {
        return blockModelFromJson(res);
      } else {
        log("BlockModelRes-->${res}");
        return Utils.failureMeg(res, context);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
  }

  static Future<SchemeModel?> schemesData({required BuildContext context, required String districtId, required String blockId}) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.schemes}$districtId/$blockId", context: context);
      if (res != null) {
        return schemeModelFromJson(res);
      } else {
        return Utils.failureMeg(res, context);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
  }

  static Future<SubSystemModel?> subSystemsData({required BuildContext context}) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.subSystems}", context: context);
      if (res != null) {
        return subSystemModelFromJson(res);
      } else {
        return Utils.failureMeg(res, context);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
  }

  static Future<AllContractorModel?> allContractorData({
    required BuildContext context,
  }) async {
    String gaId = await PreferenceUtil.getString(key: PrefsValue.gaId);
    var param = {
      "assigned_ga": gaId,
    };
    String json = Uri(queryParameters: param).query;
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.allContractor + json}", context: context);
      if (res != null) {
        return allContractorModelFromJson(res);
      } else {
        return Utils.failureMeg(res, context);
      }
    } catch (e) {
      log("allContractorModelFromJson-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
  }

  static Future<ActivityModel?> activitiesData({
    required BuildContext context,
    required String districtId,
    required String blockId,
    required String schemeId,
    required String systemId,
  }) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.activities}$districtId/$blockId/$schemeId/$systemId", context: context);
      if (res != null) {
        return activityModelFromJson(res);
      } else {
        return Utils.failureMeg(res, context);
      }
    } catch (e) {
      log("catchActivityModelFromJson-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
  }

  static Future<ActivityStartDateModel?> activityStartDate({
    required BuildContext context,
    required String districtId,
    required String blockId,
    required String schemeId,
    required String systemId,
    required String activitiesId,
  }) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.activityStartDate}$districtId/$blockId/$schemeId/$systemId/$activitiesId", context: context);
      if (res != null) {
        print("${AppUrl.activityStartDate}$districtId/$blockId/$schemeId/$systemId/$activitiesId");
        return activityStartDateModelFromJson(res);
      } else {
        return Utils.failureMeg(res, context);
      }
    } catch (e) {
      log("catchActivityModelFromJson-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
  }

  static Future<File?> cameraCapture() async {
    await Permission.camera.request();
    final XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 900,
      maxWidth: 1000,
    );
    File files = File(file!.path);
    return files;
  }

  static Future<File?> galleryCapture() async {
    await Permission.storage.request();
    final XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 900,
      maxWidth: 1000,
    );
    File files = File(file!.path);
    return files;
  }

  static Future<dynamic> validationSubmit({
    required BuildContext context,
    required String networkDistrict,
    required String zoneBlock,
    required String dmaSystem,
    required String subSystemId,
    required String activityId,
    required String contractorId,
    required String startDate,
    required String remarks,
    required String attachFile,
  }) async {
    try {
      if (networkDistrict.isEmpty || networkDistrict == "null") {
        Utils.failureMeg("The Network District field is required.", context);
        return false;
      } else if (zoneBlock.isEmpty || zoneBlock == "null") {
        Utils.failureMeg("The Zone Block field is required.", context);
        return false;
      } else if (dmaSystem.isEmpty || dmaSystem == "null") {
        Utils.failureMeg("The DMA System field is required.", context);
        return false;
      } else if (subSystemId.isEmpty || subSystemId == "null") {
        Utils.failureMeg("The Sub System Id field is required.", context);
        return false;
      }
      else if (contractorId.isEmpty || contractorId == "null") {
        Utils.failureMeg("The Contractor field is required.", context);
        return false;
      }
      else if (activityId.isEmpty || activityId == "null") {
        Utils.failureMeg("The Activity field is required.", context);
        return false;
      } else if (startDate.isEmpty) {
        Utils.failureMeg("The Start Date field is required.", context);
        return false;
      }
      else if (remarks.isEmpty) {
        Utils.failureMeg("The Remarks is required.", context);
        return false;
      }
      else if (attachFile.isEmpty) {
        Utils.failureMeg("The attach File is required.", context);
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }

  static Future<SubmitModel?> progressData({
    required BuildContext context,
    required String networkDistrict,
    required String zoneBlock,
    required String dmaSystem,
    required String subSystemId,
    required String contractorId,
    required String activityId,
    required String startDate,
    required String endDate,
    required File attachFile,
    required String remarks,
  }) async {
    var body = {
      "networkDistrict": networkDistrict,
      "zoneBlock": zoneBlock,
      "dmaSystem": dmaSystem,
      "subSystemId": subSystemId,
      "activityId": activityId,
      "contractorId": contractorId,
      "startDate": startDate,
      "endDate": endDate,
      "remarks": remarks,
    };
    log("jsonBody-->${body}");
    try {
      var res = await ApiServer.postDataWithFile(
        endPoint: "${AppUrl.progress}",
        body: body,
        keyWord: "attachFile",
        filePath: attachFile.path.toString(),
        context: context,
      );
      if (res != null && res["status"] == true) {
        return SubmitModel.fromJson(res);
      } else if (res != null && res["status"] == 2) {
        return Utils.failureMeg(res["errors"], context);
      } else if (res != null && res["success"] == 2) {
        return Utils.failureMeg(res["errors"], context);
      }else if (res != null && res["status"] == false) {
        return Utils.failureMeg(res["errors"], context);
      } else {
        return Utils.failureMeg(res, context);
      }
    } catch (e) {
      log("catchSubmitModel-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
  }
}
