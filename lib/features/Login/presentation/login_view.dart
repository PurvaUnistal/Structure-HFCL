import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_app/Utils/common_widget/app_bar_widget.dart';
import 'package:structure_app/Utils/common_widget/app_color.dart';
import 'package:structure_app/Utils/common_widget/app_string.dart';
import 'package:structure_app/Utils/common_widget/button_widget.dart';
import 'package:structure_app/Utils/common_widget/dotted_loader_widget.dart';
import 'package:structure_app/Utils/common_widget/text_form_field_widget.dart';
import 'package:structure_app/features/InternetConnection/domain/bloc/network_bloc.dart';
import 'package:structure_app/features/InternetConnection/domain/bloc/network_event.dart';
import 'package:structure_app/features/Login/domain/bloc/login_bloc.dart';
import 'package:structure_app/features/Login/domain/bloc/login_event.dart';
import 'package:structure_app/features/Login/domain/bloc/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    BlocProvider.of<LoginBloc>(context).add(LoginPageLoadingEvent());
    BlocProvider.of<NetworkBloc>(context)
        .add(NetworkObserveEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppString.login,
      ),
      body: SafeArea(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginFetchDataState) {
              return Center(child: _buildLayout(dataState: state));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildLayout({required LoginFetchDataState dataState}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _logoWidget(),
            _sizedBox(),
            _emailWidget(dataState: dataState),
            _sizedBox(),
            _passwordWidget(dataState: dataState),
            _sizedBox(),
            _loginBtnWidget(dataState: dataState),
          ],
        ),
      ),
    );
  }

  Widget _logoWidget() {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(23.0),
      child: Image.asset(
        ImgAsset.appLogo,
        width: w * 0.4,
        height: h * 0.16,
      ),
    );
  }

  Widget _emailWidget({required LoginFetchDataState dataState}) {
    return TextFormFieldWidget(
      labelText: AppString.emailLabel,
      hintText: AppString.emailLabel,
      keyboardType: TextInputType.emailAddress,
      prefix: Icon(Icons.email, color: AppColor.appBlue),
    //  focusNode: emailFocusNode,
      autofillHints: const [AutofillHints.email],
      onChanged: (val) {
        BlocProvider.of<LoginBloc>(context).add(
            LoginSetEmailIdEvent(emailId: val.toString().replaceAll(" ", "")));
      },
    );
  }

  Widget _passwordWidget({required LoginFetchDataState dataState}) {
    return TextFormFieldWidget(
      labelText: AppString.passwordLabel,
      hintText: AppString.passwordLabel,
     keyboardType: TextInputType.visiblePassword,
      prefix: Icon(Icons.lock_outline, color: AppColor.appBlue),
     // focusNode: passwordFocusNode,
      autofillHints: const [AutofillHints.password],
      obscureText: dataState.isPassword,
      suffixIcon: IconButton(
        icon: Icon(
            dataState.isPassword ? Icons.visibility_off : Icons.visibility,
            color: AppColor.appBlue),
        onPressed: () {
          BlocProvider.of<LoginBloc>(context).add(LoginHideShowPasswordEvent(
              isHideShow: dataState.isPassword == true ? false : true));
        },
      ),
      onChanged: (val) {
        BlocProvider.of<LoginBloc>(context).add(LoginSetPasswordEvent(
            password: val.toString().replaceAll(" ", "")));
      },
    );
  }

  Widget _loginBtnWidget({required LoginFetchDataState dataState}) {
    return dataState.isPageLoader == false
        ? ButtonWidget(
            text: AppString.login,
            onPressed: () {
              FocusScope.of(context).unfocus();
              TextInput.finishAutofillContext();
              BlocProvider.of<LoginBloc>(context).add(
                  LoginSubmitDataEvent(context: context, isLoginLoading: true));
            })
        : const DottedLoaderWidget();
  }

  Widget _sizedBox() {
    var h = MediaQuery.of(context).size.height;
    return SizedBox(
      height: h * 0.01,
    );
  }
}
