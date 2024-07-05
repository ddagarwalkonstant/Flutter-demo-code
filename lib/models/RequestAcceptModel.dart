class RequestAcceptModel {
  bool? success;
  RequestData? data;
  String? message;

  RequestAcceptModel({
    this.success,
    this.data,
    this.message,
  });

  factory RequestAcceptModel.fromJson(Map<String, dynamic> json) => RequestAcceptModel(
    success: json["success"],
    data: json["data"] == null ? null : RequestData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class RequestData {
  String? id;
  String? userId;
  String? memberId;
  String? careTakerId;
  String? requestStatus;
  List<dynamic>? taskAssigned;
  bool? requestResent;
  bool? isSuspended;
  bool? isDeleted;
  DateTime? created;
  DateTime? updated;
  int? v;

  RequestData({
    this.id,
    this.userId,
    this.memberId,
    this.careTakerId,
    this.requestStatus,
    this.taskAssigned,
    this.requestResent,
    this.isSuspended,
    this.isDeleted,
    this.created,
    this.updated,
    this.v,
  });

  factory RequestData.fromJson(Map<String, dynamic> json) => RequestData(
    id: json["_id"],
    userId: json["userId"],
    memberId: json["memberId"],
    careTakerId: json["careTakerId"],
    requestStatus: json["requestStatus"],
    taskAssigned: json["taskAssigned"] == null ? [] : List<dynamic>.from(json["taskAssigned"]!.map((x) => x)),
    requestResent: json["requestResent"],
    isSuspended: json["isSuspended"],
    isDeleted: json["isDeleted"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "memberId": memberId,
    "careTakerId": careTakerId,
    "requestStatus": requestStatus,
    "taskAssigned": taskAssigned == null ? [] : List<dynamic>.from(taskAssigned!.map((x) => x)),
    "requestResent": requestResent,
    "isSuspended": isSuspended,
    "isDeleted": isDeleted,
    "created": created?.toIso8601String(),
    "updated": updated?.toIso8601String(),
    "__v": v,
  };
}
