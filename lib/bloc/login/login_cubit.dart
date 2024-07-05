import 'dart:io';

import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../models/LoginModel.dart';
import '../../models/NormalModel.dart';
import '../../utils/AppCommonFeatures.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();



  loginFetchCubit(String email, String password) async {
    if (email.isEmpty) {
      AppCommonFeatures.instance.showToast(AppStrings.email_empty);
    } else if (!AppCommonFeatures.instance.emailregExp.hasMatch(email)) {
      AppCommonFeatures.instance.showToast(AppStrings.email_valid);
    } else if (password.isEmpty) {
      AppCommonFeatures.instance.showToast(AppStrings.password_empty);
    } else {

      String deviceToken = await AppCommonFeatures.instance.getDeviceToken();

      AppCommonFeatures.instance.showCircularProgressDialog();
      final Map<String, dynamic> map = {};
      map['email'] = email;
      map['password'] = password;
      map['deviceToken'] = deviceToken;
      await AppCommonFeatures.instance.apiRepository.fetchLoginData(map).then((value) async {
        if (value!.success!) {
          await AppCommonFeatures.instance.sharedPreferenceHelper.saveUserDetails(value.serialize(value.toJson()));
          AppCommonFeatures.instance.dismissCircularProgressDialog();
          emit(LoginStateLoaded(value));
        }
      });
    }
  }

  forgotPasswordFetchCubit(String email) async {
    if (email.isEmpty) {
      AppCommonFeatures.instance.showToast(AppStrings.email_empty);
    } else if(!AppCommonFeatures.instance.emailregExp.hasMatch(email)){
      AppCommonFeatures.instance.showToast(AppStrings.email_valid);
    } else {
      AppCommonFeatures.instance.showCircularProgressDialog();

      final Map<String, dynamic> map = {};
      map['email'] = email;
      map['deviceToken'] = AppCommonFeatures.instance.deviceToken;

      await AppCommonFeatures.instance.apiRepository
          .fetchForgotPasswordData(map)
          .then((value) async {
        if (value!.success!) {
          AppCommonFeatures.instance.dismissCircularProgressDialog();
          AppCommonFeatures.instance.showToast(value.message!);
          emit(ForgotPasswordStateLoaded(value));
        }
      });
    }
  }

  changePassword (String currentPassword, String newPassword, String confirmPassword) async{

    if (currentPassword.isEmpty) {
      AppCommonFeatures.instance.showToast(AppStrings.password_current_empty);
      return;
    }else if (newPassword.isEmpty) {
      AppCommonFeatures.instance.showToast(AppStrings.password_new_empty);
      return;
    }else if (!AppCommonFeatures.instance.passwordregex.hasMatch(newPassword)) {
      AppCommonFeatures.instance.showToast(AppStrings.password_8_digit);
      return;
    }else if (newPassword == currentPassword) {
      AppCommonFeatures.instance.showToast(AppStrings.password_current_new_diff);
      return;
    }else if (confirmPassword.isEmpty) {
      AppCommonFeatures.instance.showToast(AppStrings.password_confirm_empty);
      return;
    } else if (!AppCommonFeatures.instance.passwordregex.hasMatch(confirmPassword)) {
      AppCommonFeatures.instance.showToast(AppStrings.password_8_digit);
    }else if(newPassword != confirmPassword){
      AppCommonFeatures.instance.showToast(AppStrings.password_not_match);
    }else{
      AppCommonFeatures.instance.showCircularProgressDialog();

      final Map<String, dynamic> map = Map();
      map['currentPassword'] = currentPassword;
      map['newPassword'] = newPassword;

      await AppCommonFeatures.instance.apiRepository
          .fetchChangePasswordData(map)
          .then((value) async {
        if (value!.success!) {
          AppCommonFeatures.instance.dismissCircularProgressDialog();
          AppCommonFeatures.instance.showToast(value.message!);
          emit(LoginStateLoaded(value));

        }
      });
    }
  }

  SocialLoginApiRequest(String socialPlatform, String socialFullName,
      String socialEmail, String socialId) async {
    AppCommonFeatures.instance.showCircularProgressDialog();
    final Map<String, dynamic> map = Map();

    map['socialPlatform'] = socialPlatform;
    map['socialFullName'] = socialFullName;
    map['socialEmail'] = socialEmail;
    map['socialId'] = socialId;
    map['deviceToken'] = AppCommonFeatures.instance.deviceToken;

    await AppCommonFeatures.instance.apiRepository
        .fetchSocialLoginData(map)
        .then((value) async {
      if (value!.success!) {
        await AppCommonFeatures.instance.sharedPreferenceHelper
            .saveUserDetails(value.serialize(value.toJson()));
        AppCommonFeatures.instance.dismissCircularProgressDialog();
        emit(LoginStateLoaded(value));
      }
    });
  }

  Future<User?> signInWithGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      GoogleSignInAccount? googleSignInAccount = null;
      if (Platform.isIOS) {
        _googleSignIn = GoogleSignIn(
          scopes: [
            'email',
            'https://www.googleapis.com/auth/contacts.readonly',
          ],
        );
        await _googleSignIn.signOut();
        googleSignInAccount = await _googleSignIn.signIn();
      } else {
        await _googleSignIn.signOut();
        googleSignInAccount = await _googleSignIn.signIn();
      }

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;
        return user;
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      await FirebaseAuth.instance.signOut();
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AuthCredential credential =
            await FacebookAuthProvider.credential(result.accessToken!.token);
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;
        return user;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<User?> signInWithApple() async {
    try {
      await FirebaseAuth.instance.signOut();
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential != null) {
        final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: credential.identityToken,
        );
        final UserCredential authResult =
            await _auth.signInWithCredential(oauthCredential);
        final User? user = authResult.user;
        return user;
      }
    } catch (e) {}
  }
}
