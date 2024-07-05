part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class UpdateLoginPasswordVisibilityState extends LoginState {
  bool isObsecure;
  String type;

  UpdateLoginPasswordVisibilityState(this.type,this.isObsecure);
}

class LoginStateLoaded extends LoginState {
  final LoginModel loginModel;

  LoginStateLoaded(this.loginModel);
}
class ForgotPasswordStateLoaded extends LoginState {
  final NormalModel normalModel;

  ForgotPasswordStateLoaded(this.normalModel);
}
