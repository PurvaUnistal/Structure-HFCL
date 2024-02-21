import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:structure_app/Server/api_error.dart';
import 'package:structure_app/Utils/common_widget/SharedPerfs/Prefs_Value.dart';
import 'package:structure_app/Utils/common_widget/SharedPerfs/preference_utils.dart';
import 'package:structure_app/Utils/common_widget/Utils.dart';
import 'package:structure_app/Utils/routes/routes_name.dart';


class ApiServer {
// static final dio = Dio();

  static Future<dynamic> getData({var urlEndPoint, required BuildContext context}) async{
    await PreferenceUtil().init();
    String token =  await PreferenceUtil.getString(key: PrefsValue.token);
    var header = {
      "Authorization":token,
    };
    try {
      var response = await get(Uri.parse(urlEndPoint),headers: header).timeout(const Duration(minutes: 4));
      log("URL-->${urlEndPoint.toString()}");
      log(urlEndPoint + "==>" + response.body.toString());
      if (response. statusCode == 200) {
        return response.body.toString();
      } else if (response.statusCode == 401 && response.body == "Access denied") {
        await PreferenceUtil.clearAll();
        return Navigator.of(context).pushNamedAndRemoveUntil(RoutesName.splashView, (Route<dynamic> route) => false);
      } else {
        log("Api.error-->${Api.error}");
        return null;
      }
    } catch (e){
      log("ApiServer-->${e.toString()}");
      if (e is SocketException) {
        log("SocketException : ${e.toString()}");
        Utils.warningMeg(e.toString(), context);
      } else if (e is TimeoutException) {
        log("TimeoutException : ${e.toString()}");
        Utils.warningMeg(e.toString(), context);
      } else {
        log("Unhandled exception : ${e.toString()}");
        Utils.warningMeg(e.toString(), context);
      }
      return null;
    }
  }

  static Future<dynamic> postData({var urlEndPoint, required BuildContext context, var bodyReq,}) async {
    await PreferenceUtil().init();
    String token =  await PreferenceUtil.getString(key: PrefsValue.token);
    var header = {"Authorization":token};
    try {
      final response = await post(Uri.parse(urlEndPoint),
          headers: header, body: bodyReq).timeout(const Duration(minutes: 1));
      log("getResponse ===== ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body.toString());
      } else if (response.statusCode == 401 && response.body == "Access denied") {
        await PreferenceUtil.clearAll();
        return Navigator.of(context).pushNamedAndRemoveUntil(RoutesName.splashView, (Route<dynamic> route) => false);
      }else if(response.statusCode == 401){
        return jsonDecode(response.body.toString());
      }else {
        log("Api.error-->${Api.error}");
        return null;
      }
    } catch (e) {
      if (e is SocketException) {
        log("SocketException : ${e.toString()}");
      } else if (e is TimeoutException) {
        log("TimeoutException : ${e.toString()}");
      } else {
        log("Unhandled exception : ${e.toString()}");
      }
    }
    return null;
  }

  static Future<bool> isInternetConnected() async {
    bool isConnect = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect = true;
      }
    } on SocketException catch (_) {}

    return isConnect;
  }

}
