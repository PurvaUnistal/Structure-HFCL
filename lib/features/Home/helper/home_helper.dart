import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:structure_app/Server/api_server.dart';
import 'package:structure_app/Server/app_url.dart';
import 'package:structure_app/Utils/common_widget/Utils.dart';
import 'package:structure_app/features/Home/domain/model/ActivityModel.dart';
import 'package:structure_app/features/Home/domain/model/BlockModel.dart';
import 'package:structure_app/features/Home/domain/model/SchemeModel.dart';
import 'package:structure_app/features/Home/domain/model/SubSubSystemModel.dart';
import 'package:structure_app/features/Home/domain/model/SubSystemModel.dart';
import 'package:structure_app/features/Home/domain/model/SubmitModel.dart';

class HomeHelper {

  static Future<BlockModel?> blocksData({required BuildContext context}) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.blocks}", context: context);
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

  static Future<SchemeModel?> schemesData({required BuildContext context, required String blockId}) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.schemes}$blockId", context: context);
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

  static Future<SubSystemModel?> subSystemsData({required BuildContext context, required String schemeId }) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.subSystems}$schemeId", context: context);
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

  static Future<SubSubSystemModel?> subSubSystemsData({required BuildContext context,
    required String schemeId, required String subSystemId
  }) async {
  try {
    var res = await ApiServer.getData(urlEndPoint: "${AppUrl.subSubSystems}${base64Url.encode(utf8.encode(subSystemId))}/$schemeId", context: context);
      log("subSubSystems-->${AppUrl.subSubSystems}$subSystemId$schemeId");
      if (res != null) {
        return subSubSystemModelFromJson(res);
      } else {
        return Utils.failureMeg(res, context);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
  }


  static Future<ActivityModel?> activitiesData({required BuildContext context, required String systemId, required String subSubSystemId}) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.activities}$systemId/$subSubSystemId", context: context);
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
    required String activityId,
    required String remarks,
    required String attachFile,
  }) async {
    try {
      if (activityId.isEmpty) {
        Utils.failureMeg("The Activity field is required.", context);
        return false;
      }
      if (remarks.isEmpty) {
        Utils.failureMeg("The Remarks is required.", context);
        return false;
      }
      if (attachFile.isEmpty) {
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
    required String activityId,
    required String startDate,
    required String endDate,
    required File attachFile,
    required String remarks,
  }) async {
    var body = {
      "activityId": activityId,
      "startDate": startDate,
      "endDate": endDate,
      "remarks": remarks,
    };
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
      } else if (res != null && res["status"] == false) {
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
