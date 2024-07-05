import 'dart:convert';

class LoginModel {
  bool? success;
  Data? data;
  String? message;

  LoginModel({this.success, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }

  String serialize(Map<String, dynamic> map) => jsonEncode(map);
  LoginModel deserialize(var jsonn) => LoginModel.fromJson(jsonDecode(jsonn));

}

class Data {
  String? token;
  LoginUser? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new LoginUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class LoginUser {
  String? sId;
  String? fullName;
  String? email;
  String? phone;
  String? avatar;
  String? deviceToken;
  String? userName;
  bool? pushNotificationAllowed;
  bool? isShowComplete;
  bool? isEmailVerify;
  bool? isMobileVerify;
  bool? isSuspended;
  bool? isDeleted;
  String? inviteEmailToken;
  String? created;
  String? updated;

  LoginUser(
      {this.sId,
        this.fullName,
        this.email,
        this.phone,
        this.avatar,
        this.deviceToken,
        this.userName,
        this.pushNotificationAllowed,
        this.isShowComplete,
        this.isEmailVerify,
        this.isMobileVerify,
        this.isSuspended,
        this.isDeleted,
        this.inviteEmailToken,
        this.created,
        this.updated});

  LoginUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    deviceToken = json['deviceToken'];
    userName = json['userName'];
    pushNotificationAllowed = json['pushNotificationAllowed'];
    isShowComplete = json['isShowComplete'];
    isEmailVerify = json['isEmailVerify'];
    isMobileVerify = json['isMobileVerify'];
    isSuspended = json['isSuspended'];
    isDeleted = json['isDeleted'];
    inviteEmailToken = json['inviteEmailToken'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['deviceToken'] = this.deviceToken;
    data['userName'] = this.userName;
    data['pushNotificationAllowed'] = this.pushNotificationAllowed;
    data['isShowComplete'] = this.isShowComplete;
    data['isEmailVerify'] = this.isEmailVerify;
    data['isMobileVerify'] = this.isMobileVerify;
    data['isSuspended'] = this.isSuspended;
    data['isDeleted'] = this.isDeleted;
    data['inviteEmailToken'] = this.inviteEmailToken;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}
