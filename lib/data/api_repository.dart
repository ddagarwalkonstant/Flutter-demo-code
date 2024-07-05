import 'package:base_arch_proj/data/modified_network/common_response.dart';
import 'package:base_arch_proj/models/MedicineModel.dart';
import 'package:base_arch_proj/models/NotificationModel.dart';
import 'package:base_arch_proj/models/RegisterModel.dart';
import 'package:base_arch_proj/models/RequestAcceptModel.dart';
import 'package:base_arch_proj/models/memberListModel.dart';
import 'package:dio/dio.dart';

import '../models/LoginModel.dart';
import '../models/MyProfileModel.dart';
import '../models/NormalModel.dart';
import 'modified_network/api_base_helper.dart';

class ApiRepository {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  String create_Account = "/api/create-account";
  String login = "/api/login";
  String social_login = "/api/social-login";
  String forgot_password = "/api/forgot-password";
  String logout = "/api/log-out";
  String get_user_profile = "/api/get-user-profile";
  String update_user_profile = "/api/update-user-profile";
  String delete_profile = "/api/delete-profile";
  String allowNotification = "/api/allow-notification";
  String change_password = "/api/change-password";
  String add_member = "/api/add-member";
  String list_member = "/api/list-members";

  String assignedMember = "/api/assigned-member";
  String add_query = "/api/add-query";




  String getNotification = "/api/get-notification";





























  final String _markNotificationRead = "/api/mark-notification";

  /// Fetches signup data from the API.
  ///
  /// Takes [map] as input containing signup information.
  /// Returns [RegisterModel] if successful, else returns null.
  Future<RegisterModel?> fetchSignupData(Map<String, dynamic> map) async {
    final response = await _apiBaseHelper.post(create_Account, map);
    if (response!.data != null) {
      return RegisterModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  /// Fetches login data from the API.
  ///
  /// Takes [map] as input containing login credentials.
  /// Returns [LoginModel] if successful, else returns null.
  Future<LoginModel?> fetchLoginData(Map<String, dynamic> map) async {
    final response = await _apiBaseHelper.post(login, map);
    if (response!.data != null) {
      return LoginModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  /// Fetches member list from the API.
  ///
  /// Takes [map] as input for query parameters.
  /// Returns [MemberListModel] if successful, else returns null.
  Future<MemberListModel?> fetchMemberList(Map<String, dynamic> map) async {
    final response = await _apiBaseHelper.getApiCallWithQuery(list_member, map);
    if (response?.data != null) {
      return MemberListModel.fromJson(response?.data);
    } else {
      return null;
    }
  }


  /// Fetches notification list from the API.
  ///
  /// Takes [map] as input for query parameters.
  /// Returns [NotificationListModel] if successful, else returns null.
  Future<NotificationListModel?> fetchNotificationList(
      Map<String, dynamic> map) async {
    final response =
        await _apiBaseHelper.getApiCallWithQuery(getNotification, map);
    if (response?.data != null) {
      return NotificationListModel.fromJson(response?.data);
    } else {
      return null;
    }
  }

  /// Fetches assigned member list from the API.
  ///
  /// Takes [map] as input for query parameters.
  /// Returns [MemberListModel] if successful, else returns null.
  Future<MemberListModel?> fetchAssignedMemberList(
      Map<String, dynamic> map) async {
    final response =
        await _apiBaseHelper.getApiCallWithQuery(assignedMember, map);
    if (response?.data != null) {
      return MemberListModel.fromJson(response?.data);
    } else {
      return null;
    }
  }

  /// Marks a notification as read.
  ///
  /// Takes [map] as input containing notification details.
  /// Returns [BaseModel] if successful, else returns null.
  Future<BaseModel?> markNotificationReadFetch(Map<String, dynamic> map) async {
    final response = await _apiBaseHelper.patch(_markNotificationRead, map);
    if (response?.data != null) {
      return BaseModel.fromJson(response?.data);
    } else {
      return null;
    }
  }

  /// Fetches data for forgot password functionality.
  ///
  /// Takes [map] as input containing user details.
  /// Returns [NormalModel] if successful, else returns null.
  Future<NormalModel?> fetchForgotPasswordData(Map<String, dynamic> map) async {
    final response = await _apiBaseHelper.post(forgot_password, map);
    if (response!.data != null) {
      return NormalModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  /// Sends a contact query to the API.
  ///
  /// Takes [map] as input containing query details.
  /// Returns [NormalModel] if successful, else returns null.
  Future<NormalModel?> contactUsApiCall(Map<String, dynamic> map) async {
    final response = await _apiBaseHelper.post(add_query, map);
    if (response!.data != null) {
      return NormalModel.fromJson(response.data);
    } else {
      return null;
    }
  }



  /// Fetches data for social login.
  ///
  /// Takes [map] as input containing social login details.
  /// Returns [LoginModel] if successful, else returns null.
  Future<LoginModel?> fetchSocialLoginData(Map<String, dynamic> map) async {
    final response = await _apiBaseHelper.post(social_login, map);
    if (response!.data != null) {
      return LoginModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  /// Performs logout operation.
  ///
  /// Returns [NormalModel] if successful, else returns null.
  Future<NormalModel?> fetchLogoutData() async {
    final response = await _apiBaseHelper.get(logout);
    if (response!.data != null) {
      return NormalModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  /// Deletes user profile.
  ///
  /// Returns [NormalModel] if successful, else returns null.
  Future<NormalModel?> fetchDeleteData() async {
    final response = await _apiBaseHelper.delete(delete_profile);
    if (response!.data != null) {
      return NormalModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  /// Allows notifications for the user.
  ///
  /// Takes [map] as input containing notification settings.
  /// Returns [LoginModel] if successful, else returns null.
  Future<LoginModel?> fetchNotificationAllowData(
      Map<String, dynamic> map) async {
    final response = await _apiBaseHelper.put(allowNotification, map);
    if (response!.data != null) {
      return LoginModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  /// Changes user password.
  ///
  /// Takes [map] as input containing old and new password.
  /// Returns [LoginModel] if successful, else returns null.
  Future<LoginModel?> fetchChangePasswordData(Map<String, dynamic> map) async {
    final response = await _apiBaseHelper.post(change_password, map);
    if (response!.data != null) {
      return LoginModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  /// Fetches user's own profile details.
  ///
  /// Returns [MyProfileModel] if successful, else returns null.
  Future<MyProfileModel?> fetchMyProfileData() async {
    final response = await _apiBaseHelper.get(get_user_profile);
    if (response!.data != null) {
      return MyProfileModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  /// Updates user profile details.
  ///
  /// Takes [formData] as input containing updated profile data.
  /// Returns [MyProfileModel] if successful, else returns null.
  Future<MyProfileModel?> updateProfileData(FormData formData) async {
    final response =
        await _apiBaseHelper.putMultipart(update_user_profile, formData);
    if (response!.data != null) {
      return MyProfileModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
