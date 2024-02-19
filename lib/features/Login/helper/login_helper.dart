import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:structure_app/Server/api_server.dart';
import 'package:structure_app/Server/app_url.dart';
import 'package:structure_app/Utils/common_widget/Utils.dart';
import 'package:structure_app/Utils/common_widget/app_string.dart';
import 'package:structure_app/features/Login/domain/model/login_model.dart';

class LoginHelper {
  static Future<dynamic> textFieldValidation(
      {required String email,
      required password,
      required BuildContext context}) async {
    try {
      if (email.isEmpty) {
        Utils.failureMeg(AppString.emailLabel, context);
        return false;
      } else if (password.isEmpty) {
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

  static Future<LoginModel?> loginData(
      {required String emailId,
      required String password,
      required BuildContext context}) async {
    var param = {
      "email" : emailId,
      "password" : password,
    };

   try {
      var res = await ApiServer.postData(urlEndPoint: AppUrl.login, context: context, bodyReq: json.encode(param));
      if(res != null){
        return loginModelFromJson(res);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      Utils.failureMeg(e.toString(), context);
      return null;
    }
    return null;
  }
}
