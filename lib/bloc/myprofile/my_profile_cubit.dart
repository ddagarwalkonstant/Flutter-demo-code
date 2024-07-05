import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../../models/LoginModel.dart';
import '../../models/MyProfileModel.dart';
import '../../utils/AppCommonFeatures.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit() : super(MyProfileInitial());


  logoutFetchCubit() async {
    AppCommonFeatures.instance.showCircularProgressDialog();
    await AppCommonFeatures.instance.apiRepository.fetchLogoutData()
        .then((value) async {
      if (value!.success!) {
        AppCommonFeatures.instance.dismissCircularProgressDialog();
        await AppCommonFeatures.instance.logOutUserSession();
      }
    });
  }

  deleteFetchCubit() async {
    AppCommonFeatures.instance.showCircularProgressDialog();
    await AppCommonFeatures.instance.apiRepository.fetchDeleteData()
        .then((value) async {
      if (value?.success ?? false) {
        AppCommonFeatures.instance.showToast(value?.message ?? '');
        AppCommonFeatures.instance.dismissCircularProgressDialog();
        await AppCommonFeatures.instance.logOutUserSession();
      }
    });
  }

  allowNotificationCubit(bool isAllowed) async {
    final Map<String, dynamic> map = {};
    map['isAllowNotification'] = (isAllowed == true) ? false : true;
    AppCommonFeatures.instance.showCircularProgressDialog();
    await AppCommonFeatures.instance.apiRepository.fetchNotificationAllowData(map).then((value) async {
      if (value?.success ?? false) {
        AppCommonFeatures.instance.showToast(value?.message ?? '');
        AppCommonFeatures.instance.dismissCircularProgressDialog();
        LoginModel? loginModel= await AppCommonFeatures.instance.sharedPreferenceHelper.getLoginUserDetails();
        loginModel?.data?.user?.pushNotificationAllowed = value?.data?.user?.pushNotificationAllowed ?? false;
        await AppCommonFeatures.instance.sharedPreferenceHelper.saveUserDetails(loginModel!.serialize(loginModel.toJson()));
        emit(NotificationAllowState(value!));
      }else {
        AppCommonFeatures.instance.dismissCircularProgressDialog();
      }
    });
  }


  fetcMyProfile() async{
    AppCommonFeatures.instance.showCircularProgressDialog();
    await AppCommonFeatures.instance.apiRepository.fetchMyProfileData()
        .then((value) async {
      if (value!.success!) {
        AppCommonFeatures.instance.dismissCircularProgressDialog();
        emit(MyPrfoileDetailsState(value));
      }
    });
  }

  updateProfile(String fullName,String nickName, String phone, int? dob, String bio,String? imagePath) async{

    if(fullName.trim().isEmpty){
      AppCommonFeatures.instance.showToast(AppStrings.name_empty);
      return;
    }else if(AppCommonFeatures.instance.nameRegExp.hasMatch(fullName)){
      AppCommonFeatures.instance.showToast(AppStrings.name_valid);
      return;
    }
    // else if (nickName.isEmpty) {
    //   AppCommonFeatures.instance.showToast(AppStrings.nick_name_empty);
    // }else if(AppCommonFeatures.instance.nameRegExp.hasMatch(nickName)){
    //   AppCommonFeatures.instance.showToast(AppStrings.nickname_valid);
    //   return;
    // }
    // else if (dob == null) {
    //   AppCommonFeatures.instance.showToast(AppStrings.dob_empty);
    // }
    else{
      AppCommonFeatures.instance.showCircularProgressDialog();
      String token = await AppCommonFeatures.instance.sharedPreferenceHelper.getToken();
      FormData formData;
      if(imagePath != null){
        formData = FormData.fromMap({
          'fullName': fullName,
          'nickName': nickName,
          'phone': phone,
          'dob': dob,
          'bio': bio,
          'deviceToken': token,
          "avatar": await MultipartFile.fromFile(imagePath)
        });
      }else{
        formData = FormData.fromMap({
          'fullName': fullName,
          'nickName': nickName,
          'phone': phone,
          'dob': dob,
          'bio': bio,
          'deviceToken': token
        });
      }

      await AppCommonFeatures.instance.apiRepository.updateProfileData(formData)
          .then((value) async {
        if (value!.success!) {
         LoginModel? loginModel= await AppCommonFeatures.instance.sharedPreferenceHelper.getLoginUserDetails();
         loginModel?.data?.user?.isShowComplete=value.data?.isShowComplete;
         loginModel?.data?.user?.fullName=value.data?.fullName;
         loginModel?.data?.user?.email=value.data?.email;
         loginModel?.data?.user?.phone=value.data?.phone;
         loginModel?.data?.user?.avatar=value.data?.avatar;
         loginModel?.data?.user?.userName=value.data?.userName;
         loginModel?.data?.user?.pushNotificationAllowed=value.data?.pushNotificationAllowed;
         loginModel?.data?.user?.isEmailVerify=value.data?.isEmailVerify;
         loginModel?.data?.user?.isMobileVerify=value.data?.isMobileVerify;
         loginModel?.data?.user?.isSuspended=value.data?.isSuspended;
         loginModel?.data?.user?.isDeleted=value.data?.isDeleted;
         loginModel?.data?.user?.inviteEmailToken=value.data?.inviteEmailToken;
         loginModel?.data?.user?.created=value.data?.created;
         loginModel?.data?.user?.updated=value.data?.updated;

          await AppCommonFeatures.instance.sharedPreferenceHelper.saveUserDetails(loginModel!.serialize(loginModel.toJson()));
          AppCommonFeatures.instance.dismissCircularProgressDialog();
         AppCommonFeatures.instance.showToast(value.message ?? "", toastLength: Toast.LENGTH_SHORT);
          emit(MyPrfoileUpdateState(value));
        }
      });
    }
    }


}
