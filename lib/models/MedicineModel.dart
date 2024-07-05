class MedicineModel {
  bool? success;
  MedicineModelData? data;
  String? message;

  MedicineModel({
    this.success,
    this.data,
    this.message,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) => MedicineModel(
    success: json["success"],
    data: json["data"] == null ? null : MedicineModelData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class MedicineModelData {
  String? member;
  String? user;
  String? name;
  String? image;
  String? dosage;
  String? description;
  String? dosageUnit;
  DateTime? date;
  bool? isSuspended;
  bool? isDeleted;
  String? id;
  List<Slot>? slots;
  DateTime? created;
  DateTime? updated;
  int? v;
  String? dataId;
  AddedBy? addedBy;
  UpdatedBy? updatedBy;
  List<MedicationData>? medicationData;

  MedicineModelData({
    this.member,
    this.user,
    this.name,
    this.image,
    this.dosage,
    this.description,
    this.dosageUnit,
    this.date,
    this.isSuspended,
    this.isDeleted,
    this.id,
    this.slots,
    this.created,
    this.updated,
    this.v,
    this.dataId,
    this.addedBy,
    this.updatedBy,
    this.medicationData
  });

  factory MedicineModelData.fromJson(Map<String, dynamic> json) => MedicineModelData(
    member: json["member"],
    user: json["user"],
    name: json["name"],
    image: json["image"],
    dosage: json["dosage"],
    description: json["description"],
    dosageUnit: json["dosage_unit"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    isSuspended: json["isSuspended"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
    slots: json["slots"] == null ? [] : List<Slot>.from(json["slots"]!.map((x) => Slot.fromJson(x))),
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    v: json["__v"],
    dataId: json["id"],
    addedBy: json["added_by"] == null ? null : AddedBy.fromJson(json["added_by"]),
    updatedBy: json["updated_by"] == null ? null : UpdatedBy.fromJson(json["updated_by"]),
    medicationData: json["medicationData"] == null ? [] : List<MedicationData>.from(json["medicationData"]!.map((x) => MedicationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "member": member,
    "user": user,
    "name": name,
    "image": image,
    "dosage": dosage,
    "description": description,
    "dosage_unit": dosageUnit,
    "date": date?.toIso8601String(),
    "isSuspended": isSuspended,
    "isDeleted": isDeleted,
    "_id": id,
    "slots": slots == null ? [] : List<dynamic>.from(slots!.map((x) => x.toJson())),
    "created": created?.toIso8601String(),
    "updated": updated?.toIso8601String(),
    "__v": v,
    "id": dataId,
    "added_by": addedBy?.toJson(),
    "updated_by": updatedBy?.toJson(),
    "medicationData": medicationData == null ? [] : List<dynamic>.from(medicationData!.map((x) => x.toJson())),
  };
}

class Slot {
  String? slot;
  String? image;
  String? note;
  String? id;
  String? slotId;
  bool? isCompleted;
  bool? isUpdated;
  AddedBy? addedBy;
  UpdatedBy? updatedBy;

  Slot({
    this.slot,
    this.image,
    this.note,
    this.id,
    this.slotId,
    this.isCompleted,
    this.isUpdated,
    this.addedBy,
    this.updatedBy,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    slot: json["slot"],
    image: json["image"],
    note: json["note"],
    isCompleted: json["isCompleted"],
    isUpdated: json["isUpdated"],
    id: json["_id"],
    slotId: json["id"],
    addedBy: json["added_by"] == null ? null : AddedBy.fromJson(json["added_by"]),
    updatedBy: json["updated_by"] == null ? null : UpdatedBy.fromJson(json["updated_by"]),
  );

  Map<String, dynamic> toJson() => {
    "slot": slot,
    "image": image,
    "note": note,
    "_id": id,
    "isCompleted": isCompleted,
    "isUpdated": isUpdated,
    "id": slotId,
    "added_by": addedBy?.toJson(),
    "updated_by": updatedBy?.toJson(),
  };
}




class MedicineListModel {
  bool? success;
  MedicineListModelData? data;
  String? message;

  MedicineListModel({
    this.success,
    this.data,
    this.message,
  });

  factory MedicineListModel.fromJson(Map<String, dynamic> json) => MedicineListModel(
    success: json["success"],
    data: json["data"] == null ? null : MedicineListModelData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class MedicineListModelData {
  int? totalRecords;
  List<MedicineModelData>? medicationList;

  MedicineListModelData({
    this.totalRecords,
    this.medicationList,
  });

  factory MedicineListModelData.fromJson(Map<String, dynamic> json) => MedicineListModelData(
    totalRecords: json["totalRecords"],
    medicationList: json["medicationList"] == null ? [] : List<MedicineModelData>.from(json["medicationList"]!.map((x) => MedicineModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalRecords": totalRecords,
    "medicationList": medicationList == null ? [] : List<dynamic>.from(medicationList!.map((x) => x.toJson())),
  };
}


class AddedBy {
  String? id;
  String? name;
  DateTime? date;

  AddedBy({
    this.id,
    this.name,
    this.date,
  });

  factory AddedBy.fromJson(Map<String, dynamic> json) => AddedBy(
    id: json["id"],
    name: json["name"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "date": date?.toIso8601String(),
  };
}

class UpdatedBy {
  String? name;
  DateTime? date;

  UpdatedBy({
    this.name,
    this.date,
  });

  factory UpdatedBy.fromJson(Map<String, dynamic> json) => UpdatedBy(
    name: json["name"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "date": date?.toIso8601String(),
  };
}

class MedicationData {
  DateTime? date;
  List<Slot>? slots;
  String? id;
  String? medicationDataId;
  bool? isSelected;

  MedicationData({
    this.date,
    this.slots,
    this.id,
    this.medicationDataId,
  });

  factory MedicationData.fromJson(Map<String, dynamic> json) => MedicationData(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    slots: json["slots"] == null ? [] : List<Slot>.from(json["slots"]!.map((x) => Slot.fromJson(x))),
    id: json["_id"],
    medicationDataId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "slots": slots == null ? [] : List<dynamic>.from(slots!.map((x) => x.toJson())),
    "_id": id,
    "id": medicationDataId,
  };
}

