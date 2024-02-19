import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:structure_app/Server/api_server.dart';
import 'package:structure_app/Server/app_url.dart';
import 'package:structure_app/Utils/common_widget/SharedPerfs/Prefs_Value.dart';
import 'package:structure_app/Utils/common_widget/SharedPerfs/preference_utils.dart';
import 'package:structure_app/Utils/common_widget/Utils.dart';
import 'package:structure_app/Utils/routes/routes_name.dart';
import 'package:structure_app/features/Home/domain/model/ActivityModel.dart';
import 'package:structure_app/features/Home/domain/model/BlockModel.dart';
import 'package:structure_app/features/Home/domain/model/DistrictsModel.dart';
import 'package:structure_app/features/Home/domain/model/MajorActivityModel.dart';
import 'package:structure_app/features/Home/domain/model/QuantityModel.dart';
import 'package:structure_app/features/Home/domain/model/SchemeModel.dart';
import 'package:structure_app/features/Home/domain/model/SubmitModel.dart';

class HomeHelper{

  static Future<DistrictsModel?> districtData({required BuildContext context}) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: AppUrl.districts,context: context);
      if(res != null){
        return DistrictsModel.fromJson(jsonDecode(res));
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
    return null;
  }

  static Future<BlockModel?> blocksData({required BuildContext context,required int id}) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.blocks}$id",context: context);
      if(res != null){
        return blockModelFromJson(res);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
    return null;
  }

  static Future<dynamic> quantityData({required BuildContext context,required int schemeId, required int majeorId, activeId}) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.quantity}$schemeId/$majeorId/$activeId",context: context);
      if(res != null){
        //   return quantityModelFromJson(res).data.toJson().values.toList();
        return quantityModelFromJson(res);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
    return null;
  }

  static Future<SchemeModel?> schemesData({required BuildContext context,required int id}) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.schemes}$id",context: context);
      if(res != null){
        return schemeModelFromJson(res);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
    return null;
  }

  static Future<MajorActivityModel?> majorActivitiesData({required BuildContext context,required int id}) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.majorActivities}$id",context: context);
      if(res != null){
        return majorActivityModelFromJson(res);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
    return null;
  }

  static Future<ActivityModel?> activitiesData({required BuildContext context,required int schemeId, required int majeorId}) async {
    try {
      var res = await ApiServer.getData(urlEndPoint: "${AppUrl.activities}$schemeId/$majeorId",context: context);
      if(res != null){
        return activityModelFromJson(res);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
    return null;
  }


  static Future<dynamic> validationSubmit({
    required BuildContext context,
    required String distinct,
    required String block,
    required String scheme,
    required String majorActivityId,
    required String activityId,
    required String targetPerDay,
    required String remarks,
}) async{
    try{
    if(distinct.isEmpty){
      Utils.failureMeg("The Distinct field is required.", context);
      return false;
    } if(block.isEmpty){
      Utils.failureMeg("The Block field is required.", context);
      return false;
    } if(scheme.isEmpty){
      Utils.failureMeg("The Scheme field is required.", context);
      return false;
    } if(majorActivityId.isEmpty){
      Utils.failureMeg("The Major Activity field is required.", context);
      return false;
    } if(activityId.isEmpty){
      Utils.failureMeg("The Activity field is required.", context);
      return false;
    } if(targetPerDay.isEmpty){
      Utils.failureMeg("The Target Per Day is required.", context);
      return false;
    }if(remarks.isEmpty){
      Utils.failureMeg("The Remarks is required.", context);
      return false;
    }
    return true;
    }catch(e){
      return true;
    }
  }


  static Future<SubmitModel?>progressData({
    required BuildContext context,
    required String schemeId,
    required String majorActivityId,
    required String activityId,
    required String boqId,
    required String quantity,
    required String targetPerDay,
    required String remarks,
  }) async {
    await PreferenceUtil().init();
    String schema = await PreferenceUtil.getString(key: PrefsValue.schema);
    var body = {
      "schemeId":schemeId,
      "majorActivityId":majorActivityId,
      "activityId":activityId,
      "boqId":boqId,
      "quantity":quantity,
      "targetPerDay":targetPerDay,
      "remarks":remarks,
    };
    try {
      var res = await ApiServer.postData(urlEndPoint: "${AppUrl.progress}",context: context, bodyReq: body);
      if(res != null){
        return SubmitModel.fromJson(jsonDecode(res));
      } else{
        return Utils.failureMeg(res.errors.toString(), context);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
    return null;
  }



}