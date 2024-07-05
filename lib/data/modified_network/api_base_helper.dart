import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:base_arch_proj/utils/debug_utils/debug_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../constant/AppStrings.dart';
import 'api_response.dart';
import 'app_exception.dart';

class ApiBaseHelper {

  ApiBaseHelper._privateConstructor();
  static final ApiBaseHelper instance =
  ApiBaseHelper._privateConstructor();

  factory ApiBaseHelper() {
    return instance;
  }


  String _baseUrl = '';
  String baseUrlApp = '';
  String imageBaseUrl = '';


  setEnvironment(Environment env) {
    switch (env) {
      case Environment.local:
        imageBaseUrl = 'http://192.168.0.120:5002/';
        _baseUrl = 'http://192.168.0.120:5002';
        baseUrlApp = 'http://192.168.0.120:5002';
        break;
      case Environment.dev:
        imageBaseUrl = 'https://mymeetingdesk.com:7402/';
        _baseUrl = 'https://mymeetingdesk.com:7402';
        baseUrlApp = 'https://mymeetingdesk.com:7402';
        break;
      case Environment.stage:
        imageBaseUrl = 'https://mymeetingdesk.com:7402/';
        _baseUrl = 'https://mymeetingdesk.com:7402';
        baseUrlApp = 'https://mymeetingdesk.com:7402';
        break;
      case Environment.prod:
        imageBaseUrl = 'https://mymeetingdesk.com:7402/';
        _baseUrl = 'https://mymeetingdesk.com:7402';
        baseUrlApp = 'https://mymeetingdesk.com:7402';
        break;
    }
  }

  final _dio = Dio();

  /// Get:--------------------------------get api call with query params---------------------------------------
  Future<ApiResponse?> getApiCallWithQuery(
      String url,
      Map<String, dynamic> queryParameters,
      ) async {
    await getToken();
    DebugUtils.showLog('Api url get ==>> ${_baseUrl + url}');
    DebugUtils.showLog('Api query ==>> $queryParameters');
    final request = await _dio.get(_baseUrl + url, queryParameters: queryParameters).catchError((error, stackTrace) {
      return handleError(error);
    });
    final response = await safeApiCall(request);
    return response;
  }

  /// Get:-----------------------------------------------------------------------
  Future<ApiResponse?> get(String url) async {
    await getToken();
    DebugUtils.showLog('Api url get ==>> ${_baseUrl + url}');
    final request =
    await _dio.get(_baseUrl + url).catchError((error, stackTrace) {
      return handleError(error);
    });
    final response = await safeApiCall(request);
    return response;
  }

  /// Post:-----------------------------------------------------------------------
  Future<ApiResponse?> post(String url, Map<String, dynamic> jsonData) async {
    await getToken();
    DebugUtils.showLog('Api url post ==>> ${_baseUrl + url}');
    DebugUtils.showLog('Api Request ==>> $jsonData');
    final request = await _dio
        .post(
      _baseUrl + url,
      data: jsonData.isNotEmpty ? jsonData : null,
    )
        .catchError((error, stackTrace) {
      return handleError(error);
    });
    final response = await safeApiCall(request);
    return response;
    /*if (await ConnectionStatus.getInstance().checkConnection()) {

    } else {
      return ApiResponse<dynamic>.error(AppStrings.txtNoInternetConnection);
    }*/
  }

  /// Patch:-----------------------------------------------------------------------
  Future<ApiResponse?> patch(String url, Map<String, dynamic> map) async {
    await getToken();
    DebugUtils.showLog('Api url Patch ==>> ${_baseUrl + url}');
    DebugUtils.showLog('Api Request ==>> $map');
    final request = await _dio.patch(_baseUrl + url, data: map).catchError((error, stackTrace) {
      return handleError(error);
    });
    final response = await safeApiCall(request);
    return response;
  }

  /// Put:-----------------------------------------------------------------------
  Future<ApiResponse?> put(String url, Map<String, dynamic> jsonData) async {
    await getToken();
    DebugUtils.showLog('Api url put ==>> ${_baseUrl + url}');
    DebugUtils.showLog('Api Request ==>> $jsonData');
    final request = await _dio.put(_baseUrl + url, data: jsonData,).catchError((error, stackTrace) {
      return handleError(error);
    });
    final response = await safeApiCall(request);
    return response;
  }


  Future<ApiResponse?> putMultipart(String url,  FormData formData) async {
    await getToken();
    DebugUtils.showLog('Api url put ==>> ${_baseUrl + url}');
    DebugUtils.showLog('Api Request ==>> ${formData.fields}');
    _dio.options.headers['Content-Type'] = "multipart/form-data";
    final request = await _dio.put(_baseUrl + url, data: formData,).catchError((error, stackTrace) {
      return handleError(error);
    });
    final response = await safeApiCall(request);
    return response;
  }


  /// Delete:------------------------------------------------------
  Future<ApiResponse?> delete(String url) async {
    await getToken();
    DebugUtils.showLog('Api url ==>> ${_baseUrl + url}');
    final request = await _dio
        .delete(_baseUrl + url,)
        .catchError((error, stackTrace) {
      return handleError(error);
    });
    final response = await safeApiCall(request);
    return response;
  }

  Future<ApiResponse?> deleteWithQueryParam(String url,
      Map<String, dynamic> queryParameters,
      ) async {
    await getToken();
    DebugUtils.showLog('Api url delete ==>> ${_baseUrl + url}');
    DebugUtils.showLog('Api query ==>> $queryParameters');
    final request = await _dio.delete(_baseUrl + url, queryParameters: queryParameters).catchError((error, stackTrace) {
      return handleError(error);
    });
    final response = await safeApiCall(request);
    return response;
  }

  /// Post multipart file to server with json data:----------------------
  Future<ApiResponse?> postApiCallMultipart(String url, Map<String, dynamic> jsonData, FormData formData, {String? multiPartParameterName,}) async {
    await getToken();
    DebugUtils.showLog('Api url ==>> ${_baseUrl + url}');
    DebugUtils.showLog('Api Request ==>> ${formData.fields}');
    _dio.options.headers['Content-Type'] = "multipart/form-data";
    final request = await _dio.post(_baseUrl + url, data: formData)
        .catchError((error, stackTrace) {
      return handleError(error);
    });
    final response = await safeApiCall(request);

    return response;
    /*if (await ConnectionStatus.getInstance().checkConnection()) {

    } else {
      return ApiResponse<dynamic>.error(AppStrings.txtNoInternetConnection);
    }*/
  }

  getToken() async {
    try {
      String token =
      await AppCommonFeatures.instance.sharedPreferenceHelper.getToken();
      await getHeaders(token);
    } catch (e) {
      await getHeaders(null);
    }
  }

  getHeaders(String? token) async {
    String deviceType = Platform.isIOS ? 'ios' : 'android';
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    _dio.options.headers['Accept-Language'] = "en";
    _dio.options.headers['X-Care-Platform'] = Platform.operatingSystem;
    _dio.options.headers['X-Care-Version'] = version;
    _dio.options.headers['Content-Type'] = "application/json";
    _dio.options.headers['Accept'] = "application/json";
    if (token != null) {
      print("token $token");
      _dio.options.headers['Authorization'] = token;
    }
  }

  /// SafeApiCall Method is used to check if response is fine and doesn't contain any issue
  Future<ApiResponse?> safeApiCall(Response apiResponse) async {
    AppCommonFeatures.instance.dismissCircularProgressDialog();
    final formattedResponse =
    _returnResponse(apiResponse) as Map<String, dynamic>;
    return ApiResponse<dynamic>.success(formattedResponse);
    /*if (await ConnectionStatus.getInstance().checkConnection()) {
    } else {
      return ApiResponse<dynamic>.error(AppStrings.txtNoInternetConnection);
    }*/
  }

  dynamic _returnResponse(Response response) {
    if (kDebugMode) {
      log('Results>>>> ${response.statusCode}\n\n${jsonEncode(response.data)}\n\n\n');
    }
    switch (response.statusCode) {
      case 200:
        final responseJson = response.data as Map<String, dynamic>;
        // if (kDebugMode) {
        //   log(responseJson.toString());
        // }
        if (!responseJson["success"]) {
          AppCommonFeatures.instance.dismissCircularProgressDialog();
          AppCommonFeatures.instance.showToast(responseJson["message"]);
        }
        return responseJson;
      default:
        throw FetchDataException(
          '${AppStrings.txtServerError} ${response.statusCode}',
        );
    }
  }

  Future<String?> handleError(DioException error) {
    AppCommonFeatures.instance.dismissCircularProgressDialog();
    DebugUtils.showLog('Api Exception ==>> ${error.message ?? ''}');
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return AppCommonFeatures.instance.showToast(AppStrings.txtConnectionTimeOut);
      case DioExceptionType.sendTimeout:
        return  AppCommonFeatures.instance.showToast(AppStrings.txtConnectionTimeOut);
      case DioExceptionType.receiveTimeout:
        return AppCommonFeatures.instance.showToast(AppStrings.txtConnectionTimeOut);
      case DioExceptionType.badResponse:
      /*      if (error.response != null &&
            error.response?.statusCode != null &&
            error.response?.statusMessage != null) {
        } else {}*/

        switch (error.response?.statusCode!) {
          case 400:
            return AppCommonFeatures.instance.showToast(AppStrings.txtInvalidRequest);
          case 401:
            return AppCommonFeatures.instance.sessionExpireLogoutMethod(AppStrings.txtUnauthorised);
          case 403:
            return AppCommonFeatures.instance.showToast(AppStrings.something_went_wrong);
          case 404:
            return AppCommonFeatures.instance.showToast(AppStrings.something_went_wrong);
          default:
            return AppCommonFeatures.instance.showToast(AppStrings.txtSomethingWentWrong);
        }
      case DioExceptionType.cancel:
      default:
        return AppCommonFeatures.instance.showToast(error.message ?? '');
    }
  }
}
enum Environment { dev, stage, prod, local }