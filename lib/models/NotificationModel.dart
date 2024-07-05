class NotificationListModel {
  bool? success;
  NotificationData? data;
  String? message;

  NotificationListModel({
    this.success,
    this.data,
    this.message,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
    success: json["success"],
    data: json["data"] == null ? null : NotificationData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class NotificationData {
  int? totalRecords;
  List<NotificationModel>? notifications;
  bool? showNotification;

  NotificationData({
    this.totalRecords,
    this.notifications,
    this.showNotification,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    totalRecords: json["totalRecords"],
    showNotification: json["showNotification"],
    notifications: json["notifications"] == null ? [] : List<NotificationModel>.from(json["notifications"]!.map((x) => NotificationModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalRecords": totalRecords,
    "showNotification": showNotification,
    "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
  };
}

class NotificationModel {
  String? image;
  String? title;
  String? description;
  DateTime? created;
  DateTime? updated;

  NotificationModel({
    this.image,
    this.title,
    this.description,
    this.created,
    this.updated,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    image: json["image"],
    title: json["title"],
    description: json["description"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "title": title,
    "description": description,
    "created": created?.toIso8601String(),
    "updated": updated?.toIso8601String(),
  };
}
