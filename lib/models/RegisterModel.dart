class RegisterModel {
  bool? success;
  Data? data;
  String? message;

  RegisterModel({this.success, this.data, this.message});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? token;
  User? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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

class User {
  String? fullName;
  String? email;
  String? countryCode;
  String? phone;
  Null? avatar;
  String? deviceToken;
  String? userName;
  bool? pushNotificationAllowed;
  bool? isShowComplete;
  bool? isEmailVerify;
  bool? isMobileVerify;
  bool? isSuspended;
  bool? isDeleted;
  String? sId;
  String? inviteEmailToken;
  String? created;
  String? updated;

  User(
      {this.fullName,
        this.email,
        this.countryCode,
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
        this.sId,
        this.inviteEmailToken,
        this.created,
        this.updated});

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    countryCode = json['countryCode'];
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
    sId = json['_id'];
    inviteEmailToken = json['inviteEmailToken'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['countryCode'] = this.countryCode;
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
    data['_id'] = this.sId;
    data['inviteEmailToken'] = this.inviteEmailToken;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}
