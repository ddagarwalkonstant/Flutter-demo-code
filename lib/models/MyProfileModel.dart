class MyProfileModel {
  bool? success;
  Data? data;
  String? message;

  MyProfileModel({this.success, this.data, this.message});

  MyProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  dynamic dob;
  String? gender;
  String? nickName;
  String? bio;
  String? sId;
  String? fullName;
  String? email;
  String? password;
  String? phone;
  String? avatar;
  String? deviceToken;
  String? userName;
  bool? pushNotificationAllowed;
  int? failedLoginAttempts;
  int? preventLoginTill;
  bool? isShowComplete;
  bool? isEmailVerify;
  bool? isMobileVerify;
  bool? isSuspended;
  bool? isDeleted;
  int? authTokenIssuedAt;
  String? inviteEmailToken;
  String? created;
  String? updated;
  int? iV;
  String? resetToken;
  int? resetTokenIssuedAt;

  Data(
      {this.dob,
        this.gender,
        this.nickName,
        this.bio,
        this.sId,
        this.fullName,
        this.email,
        this.password,
        this.phone,
        this.avatar,
        this.deviceToken,
        this.userName,
        this.pushNotificationAllowed,
        this.failedLoginAttempts,
        this.preventLoginTill,
        this.isShowComplete,
        this.isEmailVerify,
        this.isMobileVerify,
        this.isSuspended,
        this.isDeleted,
        this.authTokenIssuedAt,
        this.inviteEmailToken,
        this.created,
        this.updated,
        this.iV,
        this.resetToken,
        this.resetTokenIssuedAt});

  Data.fromJson(Map<String, dynamic> json) {
    dob = json['dob'];
    gender = json['gender'];
    nickName = json['nickName'];
    bio = json['bio'];
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    avatar = json['avatar'];
    deviceToken = json['deviceToken'];
    userName = json['userName'];
    pushNotificationAllowed = json['pushNotificationAllowed'];
    failedLoginAttempts = json['failedLoginAttempts'];
    preventLoginTill = json['preventLoginTill'];
    isShowComplete = json['isShowComplete'];
    isEmailVerify = json['isEmailVerify'];
    isMobileVerify = json['isMobileVerify'];
    isSuspended = json['isSuspended'];
    isDeleted = json['isDeleted'];

    authTokenIssuedAt = json['authTokenIssuedAt'];
    inviteEmailToken = json['inviteEmailToken'];
    created = json['created'];
    updated = json['updated'];
    iV = json['__v'];
    resetToken = json['resetToken'];
    resetTokenIssuedAt = json['resetTokenIssuedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['nickName'] = this.nickName;
    data['bio'] = this.bio;
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['deviceToken'] = this.deviceToken;
    data['userName'] = this.userName;
    data['pushNotificationAllowed'] = this.pushNotificationAllowed;
    data['failedLoginAttempts'] = this.failedLoginAttempts;
    data['preventLoginTill'] = this.preventLoginTill;
    data['isShowComplete'] = this.isShowComplete;
    data['isEmailVerify'] = this.isEmailVerify;
    data['isMobileVerify'] = this.isMobileVerify;
    data['isSuspended'] = this.isSuspended;
    data['isDeleted'] = this.isDeleted;
    data['authTokenIssuedAt'] = this.authTokenIssuedAt;
    data['inviteEmailToken'] = this.inviteEmailToken;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['__v'] = this.iV;
    data['resetToken'] = this.resetToken;
    data['resetTokenIssuedAt'] = this.resetTokenIssuedAt;
    return data;
  }
}
