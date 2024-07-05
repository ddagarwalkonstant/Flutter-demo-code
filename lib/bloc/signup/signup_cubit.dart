import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:bloc/bloc.dart';

import '../../constant/AppStrings.dart';
import '../../models/RegisterModel.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  signupFetchCubit(String name, String email, String password,
      String confirmPassword, String mobileNumber, bool isChecked) async {
    if (name.trim().isEmpty) {
      AppCommonFeatures.instance.showToast(AppStrings.name_empty);
    } else if(AppCommonFeatures.instance.nameRegExp.hasMatch(name)){
      AppCommonFeatures.instance.showToast(AppStrings.name_valid);
    } else if (email.isEmpty) {
      AppCommonFeatures.instance.showToast(AppStrings.email_empty);
    } else if (!AppCommonFeatures.instance.emailregExp.hasMatch(email)) {
      AppCommonFeatures.instance.showToast(AppStrings.email_valid);
    } else if (password.isEmpty) {
      AppCommonFeatures.instance.showToast(AppStrings.password_empty);
    } else if (confirmPassword.isEmpty) {
      AppCommonFeatures.instance.showToast(AppStrings.password_cnf_empty);
    } else if (password != confirmPassword) {
      AppCommonFeatures.instance.showToast(AppStrings.password_not_match);
    } else if (!AppCommonFeatures.instance.passwordregex.hasMatch(password)) {
      AppCommonFeatures.instance.showToast(AppStrings.password_8_digit);
    } else if (!isChecked) {
      AppCommonFeatures.instance.showToast(AppStrings.terms_policy_not_accept);
    } else {
      AppCommonFeatures.instance.showCircularProgressDialog();
      String deviceToken = await AppCommonFeatures.instance.getDeviceToken();

      final Map<String, dynamic> map = Map();
      map['fullName'] = name;
      map['email'] = email;
      map['password'] = password;
      //map['countryCode'] = "+91";
      map['phone'] = mobileNumber;
      map['signUpThrough'] = "EMAIL";
      map['deviceToken'] = deviceToken;
      await AppCommonFeatures.instance.apiRepository
          .fetchSignupData(map)
          .then((value) async {
        if (value!.success!) {
          AppCommonFeatures.instance.dismissCircularProgressDialog();
          AppCommonFeatures.instance.showToast(value.message!);
          emit(SignupStateLoaded(value));
        }
      });
    }
  }
}
