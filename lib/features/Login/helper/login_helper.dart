import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:structure_app/Server/api_server.dart';
import 'package:structure_app/Server/app_url.dart';
import 'package:structure_app/Utils/common_widget/Utils.dart';
import 'package:structure_app/Utils/common_widget/app_string.dart';
import 'package:structure_app/features/Login/domain/model/login_model.dart';

class LoginHelper {
  static String p = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static Future<dynamic> textFieldValidation(
      {required String email,
        required password,
        required BuildContext context}) async {
    try {
      if (email.isEmpty) {
        Utils.failureMeg(AppString.emailLabel, context);
        return false;
      }
      /* else if(RegExp(p).hasMatch(email)){
        Utils.failureMeg(AppString.emailValid, context);
        return true;
      }*/
      else if (password.isEmpty) {
        Utils.failureMeg(AppString.passwordLabel, context);
        return false;
      }
      return true;
    } catch (e) {
      log(e.toString());
      Utils.failureMeg(e.toString(), context);
      return false;
    }
  }

  static Future<dynamic> loginData({
    required String emailId,
    required String password,
    required BuildContext context}) async {
    var param = {
      "email" : emailId,
      "password" : password,
    };
    try {
      var res = await ApiServer.postData(urlEndPoint: AppUrl. login, context: context, bodyReq: json.encode(param));
      if(res != null && res["status"] == 200 && res["messages"] == "User logged In successfully"){
        return LoginModel.fromJson(res);
      } if(res != null && res["status"] == 401){
        if(res["messages"] == "Unauthorised"){
          return Utils.failureMeg(res["messages"],context);
        } else {
          return Utils.failureMeg(res["messages"]["email"], context);
        }
      }else {
        return Utils.failureMeg(res, context);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      // return null;
    }

  }
}
