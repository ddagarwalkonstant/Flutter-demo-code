
import 'base_api_response.dart';

class CommonResponse  extends BaseApiResponse<bool >{

  CommonResponse({super.data, super.statusCode, super.message});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] as bool?;
    statusCode = json['status_code'] as int?;
    message = json['message'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = this.data;
    data['status_code'] = statusCode;
    data['message'] = message;
    return data;
  }
}


class BaseModel {
  bool? success;
  dynamic data;
  String? message;

  BaseModel({
    this.success,
    this.data,
    this.message,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
    success: json["success"],
    data: json["data"] == null ? null : null,
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}