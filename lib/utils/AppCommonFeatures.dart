
import 'dart:io';

import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/data/modified_network/api_base_helper.dart';
import 'package:base_arch_proj/services/navigator_service.dart';
import 'package:base_arch_proj/utils/debug_utils/debug_utils.dart';
import 'package:base_arch_proj/utils/permission/permission_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../constant/AppSizer.dart';
import '../constant/AppStrings.dart';
import '../data/api_repository.dart';
import '../data/shared_pref/shared_preference_helper.dart';
import '../factory/ImagesFactory.dart';
import 'AppLocalization.dart';

class AppCommonFeatures {
  AppCommonFeatures._privateConstructor();
  static final AppCommonFeatures instance =
      AppCommonFeatures._privateConstructor();

  factory AppCommonFeatures() {
    return instance;
  }


  String APP_VERSION = '1.0.0';

  ImagesFactory imagesFactory = ImagesFactory();
  ApiRepository apiRepository = ApiRepository();
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  AppLocalization appLocalization = AppLocalization();

  bool isProgress = false;
  late BuildContext context;

  // ApiRepository? _apiRepository = null;

  String? fcmToken;
  final String imageBaseUrl = ApiBaseHelper.instance.imageBaseUrl;
  final String baseUrlApp = ApiBaseHelper.instance.baseUrlApp;
  String deviceToken="123456678998765";



  RegExp emailregExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  RegExp passwordregex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~\%^.?]).{8,}$');


  RegExp nameRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  RegExp mobileNumberRegExp = RegExp(r'((?:[+0]9)?[0-9]$)');

  bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  Future<String> getDeviceToken() async {
    if (fcmToken == null) {
      if (Platform.isIOS) {
        fcmToken = await FirebaseMessaging.instance.getToken() ?? await FirebaseMessaging.instance.getAPNSToken() ?? '';
      } else {
        fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
      }
      DebugUtils.showLog("TOKEN: $fcmToken");
    }
    return fcmToken!;
  }

  getFormattedDate(int serverTimeStamp) {
    var timeStamp = serverTimeStamp;
    var dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    initializeDateFormatting('en','');
    return  DateFormat('dd MMM, yyyy').format(dt);
  }

  getCurrentDate() {
    var dt = DateTime.now();
    initializeDateFormatting('en','');
    return  DateFormat('dd MMM, yyyy').format(dt);
  }

  getDateFromTimeObject(DateTime dateTime) {
    initializeDateFormatting('en','');
    return DateFormat('dd MMM, yyyy').format(dateTime);
  }

  getDateFromTimeMedication(DateTime dateTime) {
    initializeDateFormatting('en','');
    return DateFormat('yyyy-MM-DD').format(dateTime);
  }

  getStringFromTimeStamp(String dateTime) {
    DateTime tempDate = DateFormat("dd MMM, yyyy").parse(dateTime);
    return  tempDate.millisecondsSinceEpoch;
  }

  getDateWeekdayName(DateTime dateTime) {
    return  DateFormat('EEE').format(dateTime);
  }

  getUpdatedByStr(String strName) {
    return 'Updated by $strName';
  }

  getAddedByStr(String strName) {
    return 'Added by $strName';
  }



  showToast(String message, {Toast? toastLength}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength ?? Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: AppSizer.tweleve);
  }

  contextInit(BuildContext context) {
    this.context = NavigationService.navigatorKey.currentContext!;
  }

  showCircularProgressDialog() {
    if (!isProgress) {
      isProgress = true;
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return const Dialog(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: SizedBox(
                  width: 55,
                  height: 55,
                  child: Center(
                    heightFactor: 55,
                    widthFactor: 55,
                    child: CircularProgressIndicator(
                      color: AppColor.theme_primary_blue,
                    ),
                  )
              ),
            );
          });
    }
  }

  dismissCircularProgressDialog() {
    if (isProgress) {
      Navigator.of(context).pop();
      isProgress = false;
    }
  }

  logOutUserSession(){
    sharedPreferenceHelper.forceLogout(context);
  }

  sessionExpireLogoutMethod(String msg) {
    PermissionUtil.showActionDialog(
      context: context,
      description: msg,
      shouldShowNegative: false,
      positiveText: AppStrings.ok_,
      onPositiveClick: () async {
        logOutUserSession();
      },
    );
  }

  selectDateCubit(BuildContext context, DateTime selectedDate) async {
    var finalDate = '';

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.theme_primary_blue,
              onPrimary: AppColor.body_text_color,
              onSurface: AppColor.theme_primary_blue,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.body_text_color, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked == null) {
      finalDate = '';
    } else {
      if (selectedDate != picked) selectedDate = picked;
      finalDate = DateFormat('dd MMM, yyyy').format(selectedDate);

    }
   return finalDate;
  }

}
