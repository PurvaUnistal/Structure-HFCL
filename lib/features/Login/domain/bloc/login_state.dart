import 'package:equatable/equatable.dart';
import 'package:structure_app/features/Login/domain/model/login_model.dart';

abstract class LoginState extends Equatable {}

class LoginInitState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginFetchDataState extends LoginInitState {
  final bool isPageLoader;
  final bool isPassword;
  final  LoginModel loginModel;

  LoginFetchDataState({
    required this.isPageLoader,
    required this.isPassword,
    required this.loginModel,
  });
  @override
  List<Object?> get props => [
        isPageLoader,
        isPassword,
    loginModel,
      ];
}
