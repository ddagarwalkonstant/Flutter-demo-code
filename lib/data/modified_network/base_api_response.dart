typedef FromJson = dynamic Function(Map<String, dynamic> json);

abstract class BaseApiResponse<T> {
  int? statusCode;
  String? message;
  T? data;

  BaseApiResponse({this.statusCode, this.message, this.data});

  bool validate({bool skipCodeCheck = false, int? codeForCheck}) {
    if (data is List) {
      return (codeForCheck != null &&
          (statusCode == codeForCheck )) ||
          (skipCodeCheck || (!skipCodeCheck && statusCode == 200)) &&
              data != null &&
              data != <T>[];
    }
    return (codeForCheck != null &&
        (statusCode == codeForCheck )) || (skipCodeCheck || (!skipCodeCheck && statusCode == 200)) &&
        data != null;
  }
/*  T fromJson(Map<String,dynamic> json){
   return (data! as dynamic).fromJson(json);
  }  */
}

/*
abstract class Func<T>{
  T fromJson();
  T toJson();
}*/
