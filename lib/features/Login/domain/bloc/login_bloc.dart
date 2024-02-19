import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_app/Utils/common_widget/SharedPerfs/Prefs_Value.dart';
import 'package:structure_app/Utils/common_widget/SharedPerfs/preference_utils.dart';
import 'package:structure_app/Utils/common_widget/Utils.dart';
import 'package:structure_app/Utils/routes/routes_name.dart';
import 'package:structure_app/features/Login/domain/bloc/login_event.dart';
import 'package:structure_app/features/Login/domain/bloc/login_state.dart';
import 'package:structure_app/features/Login/domain/model/login_model.dart';
import 'package:structure_app/features/Login/helper/login_helper.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitState()) {
    on<LoginPageLoadingEvent>(_pageLoad);
    on<LoginSetEmailIdEvent>(_setEmailId);
    on<LoginSetPasswordEvent>(_setPassword);
    on<LoginHideShowPasswordEvent>(_setHideShowPassword);
    on<LoginSubmitDataEvent>(_setSubmitLoginData);
  }

  String emailId = "";
  String password = "";
  String deviceId = "";

  bool _isPageLoader = false;
  bool get isPageLoader => _isPageLoader;

  bool _isPassword = false;
  bool get isPassword => _isPassword;

  LoginModel _loginModel = LoginModel();
  LoginModel get loginModel => _loginModel;

  _pageLoad(LoginPageLoadingEvent event, emit) async {
    emailId = "";
    password = "";
    _isPassword = true;
    _isPageLoader = false;
    _eventCompleted(emit);
  }

  _setEmailId(LoginSetEmailIdEvent event, emit) {
    emailId = event.emailId.toString().replaceAll(" ", "");
  }

  _setPassword(LoginSetPasswordEvent event, emit) {
    password = event.password.toString().replaceAll(" ", "");
  }

  _setHideShowPassword(LoginHideShowPasswordEvent event, emit) {
    _isPassword = event.isHideShow;
    _eventCompleted(emit);
  }

  _setSubmitLoginData(LoginSubmitDataEvent event, emit) async {
    var validationCheck = await LoginHelper.textFieldValidation(
        email: emailId, password: password, context: event.context);
    if (validationCheck == true) {
      try {
        _isPageLoader = true;
        _eventCompleted(emit);
        var res = await LoginHelper.loginData(
            emailId: emailId, password: password, context: event.context);
        if (res != null) {
          _isPageLoader = false;
          _eventCompleted(emit);
          if (res.user != null) {
            _loginModel = res;
            Utils.successToast(res.messages!,event.context);
            await PreferenceUtil.setString(key: PrefsValue.emailVal, value: res.user!.email.toString());
            await PreferenceUtil.setString(key: PrefsValue.passwordVal, value:password.toString());
            await PreferenceUtil.setString(key:  PrefsValue.token, value: res.token.toString());
            await PreferenceUtil.setString(key:  PrefsValue.schema, value: res.user!.schema.toString());
            await PreferenceUtil.setString(key:  PrefsValue.userRole, value: res.user!.role.toString());
            await PreferenceUtil.setString(key:  PrefsValue.userName, value: res.user!.name.toString());
            await PreferenceUtil.setString(key:  PrefsValue.userId, value: res.user!.id.toString());
            await PreferenceUtil.setString(key:  PrefsValue.gaId, value: res.user!.gaId.toString());
            Navigator.pushReplacementNamed(event.context, RoutesName.homeView);
          } else if (res.status != 200) {
            return Utils.failureMeg(res.messages.toString(), event.context);
          }
        } else {
          _isPageLoader = false;
          _eventCompleted(emit);
        }
      } catch (e) {
        _isPageLoader = false;
        _eventCompleted(emit);
        log(e.toString());
      }
    }
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<LoginState> emit) {
    emit(LoginFetchDataState(
      isPageLoader: isPageLoader,
      isPassword: isPassword,
      loginModel: loginModel,
    ));
  }
}


