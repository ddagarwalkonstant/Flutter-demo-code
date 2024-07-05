part of 'signup_cubit.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class UpdatePasswordVisibilityState extends SignupState {
  bool isObsecure;
  String type;
  UpdatePasswordVisibilityState(this.isObsecure,this.type);
}

class SignupStateLoaded extends SignupState {
  final RegisterModel signupModel;

  SignupStateLoaded(this.signupModel);
}


