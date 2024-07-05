class MemberListModel {
  bool? success;
  MemberDataList? data;
  String? message;

  MemberListModel({
    this.success,
    this.data,
    this.message,
  });

  factory MemberListModel.fromJson(Map<String, dynamic> json) =>
      MemberListModel(
        success: json["success"],
        data:
            json["data"] == null ? null : MemberDataList.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class MemberDataList {
  int? totalRecords;
  List<MemberListDataModel>? memberList;

  MemberDataList({
    this.totalRecords,
    this.memberList,
  });

  factory MemberDataList.fromJson(Map<String, dynamic> json) => MemberDataList(
        totalRecords: json["totalRecords"],
        memberList: json["memberList"] == null
            ? []
            : List<MemberListDataModel>.from(json["memberList"]!
                .map((x) => MemberListDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalRecords": totalRecords,
        "memberList": memberList == null
            ? []
            : List<dynamic>.from(memberList!.map((x) => x.toJson())),
      };
}

class MemberListDataModel {
  String? id;
  String? fullName;
  String? avatar;
  String? dob;
  String? relation;
  String? gender;
  String? bio;
  String? relatedUser;
  bool? isSuspended;
  bool? isDeleted;
  DateTime? created;
  DateTime? updated;
  int? v;
  String? datumId;
  String? requestId;
  MemberDetail? memberDetail;
  CareGiverDetail? careGiverDetails;
  CareGiverDetail? userDetail;

  MemberListDataModel({
    this.id,
    this.fullName,
    this.avatar,
    this.dob,
    this.relation,
    this.gender,
    this.bio,
    this.relatedUser,
    this.isSuspended,
    this.isDeleted,
    this.created,
    this.updated,
    this.v,
    this.datumId,
    this.requestId,
    this.memberDetail,
    this.careGiverDetails,
    this.userDetail,
  });

  factory MemberListDataModel.fromJson(Map<String, dynamic> json) =>
      MemberListDataModel(
        id: json["_id"],
        fullName: json["fullName"],
        avatar: json["avatar"],
        dob: json["dob"],
        relation: json["relation"],
        gender: json["gender"],
        bio: json["bio"],
        relatedUser: json["related_user"],
        isSuspended: json["isSuspended"],
        requestId: json["requestId"],
        isDeleted: json["isDeleted"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
        v: json["__v"],
        datumId: json["id"],
        memberDetail: json["memberDetail"] == null
            ? null
            : MemberDetail.fromJson(json["memberDetail"]),
        careGiverDetails: json["careGiverDetail"] == null ? null : CareGiverDetail.fromJson(json["careGiverDetail"]),
        userDetail: json["userDetail"] == null ? null : CareGiverDetail.fromJson(json["userDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "avatar": avatar,
        "dob": dob,
        "relation": relation,
        "gender": gender,
        "bio": bio,
        "related_user": relatedUser,
        "isSuspended": isSuspended,
        "requestId": requestId,
        "isDeleted": isDeleted,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "__v": v,
        "id": datumId,
        "memberDetail": memberDetail?.toJson(),
        "careGiverDetail": careGiverDetails?.toJson(),
        "userDetail": userDetail?.toJson(),
      };
}

class MemberDetailsModel {
  bool? success;
  MemberListDataModel? data;
  String? message;

  MemberDetailsModel({this.success, this.data, this.message});

  MemberDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? MemberListDataModel.fromJson(json['data'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class CareGiverDetail {
  String? id;
  String? fullName;
  String? email;
  String? avatar;
  DateTime? created;
  DateTime? updated;
  int? v;

  CareGiverDetail({
    this.id,
    this.fullName,
    this.email,
    this.avatar,
    this.created,
    this.updated,
    this.v,
  });

  factory CareGiverDetail.fromJson(Map<String, dynamic> json) =>
      CareGiverDetail(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        avatar: json["avatar"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "avatar": avatar,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "__v": v,
      };
}

class MemberDetail {
  String? id;
  String? fullName;
  String? avatar;
  String? dob;
  String? relation;
  String? gender;
  String? bio;
  String? relatedUser;
  bool? isSuspended;
  bool? isDeleted;
  DateTime? created;
  DateTime? updated;
  int? v;

  MemberDetail({
    this.id,
    this.fullName,
    this.avatar,
    this.dob,
    this.relation,
    this.gender,
    this.bio,
    this.relatedUser,
    this.isSuspended,
    this.isDeleted,
    this.created,
    this.updated,
    this.v,
  });

  factory MemberDetail.fromJson(Map<String, dynamic> json) => MemberDetail(
        id: json["_id"],
        fullName: json["fullName"],
        avatar: json["avatar"],
        dob: json["dob"],
        relation: json["relation"],
        gender: json["gender"],
        bio: json["bio"],
        relatedUser: json["related_user"],
        isSuspended: json["isSuspended"],
        isDeleted: json["isDeleted"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "avatar": avatar,
        "dob": dob,
        "relation": relation,
        "gender": gender,
        "bio": bio,
        "related_user": relatedUser,
        "isSuspended": isSuspended,
        "isDeleted": isDeleted,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "__v": v,
      };
}
