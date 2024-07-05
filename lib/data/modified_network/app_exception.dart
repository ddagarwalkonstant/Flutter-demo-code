import 'package:base_arch_proj/constant/AppStrings.dart';


class AppException implements Exception {
  final String? _message;
  final String? _prefix;
  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, AppStrings.txtErrorDuringCommunication);
}

class BadRequestException extends AppException {
  BadRequestException([String? message])
      : super(message, AppStrings.txtInvalidRequest);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, AppStrings.txtUnauthorised);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, '');
}
class SessionExpire extends AppException {
  SessionExpire([String? message])
      : super(message, AppStrings.tokenExpired);
}

class FailedToFetch extends AppException {
  FailedToFetch([String?message])
      : super(message, AppStrings.txtSomethingWentWrong);
}



class AccountBlock extends AppException {
  AccountBlock([String? message]) : super(message, AppStrings.txtInvalidRequest);
}

class ForbiddenException extends AppException {
  ForbiddenException([String? message])
      : super(message, AppStrings.txtForbiddenException);
}

class NotFoundException extends AppException {
  NotFoundException([String? message])
      : super(message, AppStrings.txtNotFoundException);
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException([String? message])
      : super(message, AppStrings.txtInternalServerException);
}