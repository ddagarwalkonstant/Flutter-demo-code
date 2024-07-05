import 'package:base_arch_proj/models/NotificationModel.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'notificatioin_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  var page = 0;
  var perPage = 10;
  var totalCountMembers = 1;
  List<NotificationModel> arrNotification = [];

  loadNotificationList(List<NotificationModel> listData, String searchKeyWord) {
    if (listData.length < (totalCountMembers - 1)) {
      page += 1;
      notificationFetchCubit(searchKeyWord, true);
    } else {
      if (kDebugMode) {
        print("no need to call api");
      }
    }
  }

  notificationFetchCubit(String? searchText, bool showHud) async {
    final Map<String, dynamic> map = {};
    map['pagination'] = true;
    map['skip'] = page;
    map['limit'] = perPage;
    // map['search'] = searchText ?? '';

    if (showHud) {
      AppCommonFeatures.instance.showCircularProgressDialog();
    }

    await AppCommonFeatures.instance.apiRepository
        .fetchNotificationList(map)
        .then((value) async {
      if (value!.success!) {
        if (showHud) {
          AppCommonFeatures.instance.dismissCircularProgressDialog();
        }
        // totalCountMembers = value.data?.totalRecords ?? 0;
        arrNotification.addAll((value.data?.notifications ?? []));
        emit(NotificationStateLoaded(arrNotification, value.data?.showNotification ?? false));
      }else {
        if (showHud) {
          AppCommonFeatures.instance.dismissCircularProgressDialog();
        }
      }
    });
  }

  notificationMarkReadFetchCubit() async {
    final Map<String, dynamic> map = {};
    map['userId'] = AppCommonFeatures.instance.sharedPreferenceHelper.loginModel?.data?.user?.sId;

    AppCommonFeatures.instance.showCircularProgressDialog();

    await AppCommonFeatures.instance.apiRepository
        .markNotificationReadFetch(map)
        .then((value) async {
      if (value!.success!) {
        AppCommonFeatures.instance.dismissCircularProgressDialog();
      }else {
        AppCommonFeatures.instance.dismissCircularProgressDialog();
      }
    });
  }

}
