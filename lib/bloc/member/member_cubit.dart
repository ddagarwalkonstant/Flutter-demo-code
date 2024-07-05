import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppSizer.dart';
import 'package:base_arch_proj/models/memberListModel.dart';
import 'package:base_arch_proj/res/fonts/font_family.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'member_state.dart';

class MemberCubit extends Cubit<MemberState> {
  MemberCubit() : super(MemberInitial());
  var skip = 0;
  var assignMemberSkip = 0;
  var perPage = 10;
  var totalCountMembers = 10;
  String? serverImage;
  bool isFromEdit = false;
  MemberListDataModel? memberDetail;

  final List<String> arrGender = ['Male', 'Female' ];


  List<MemberListDataModel> arrMemberList = [];

  selectGender(BuildContext context) async {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: Colors.white,
              height: 170,
              padding:
                  const EdgeInsets.only(right: 20, bottom: 5, left: 20, top: 0),
              child: Column(
                children: [
                  const SizedBox(height: AppSizer.twenteey),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => ListTile(
                            title: Text(arrGender[index] ?? '',
                                style: const TextStyle(
                                    fontFamily: FontFamily.archivo,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18)),
                            onTap: () {
                              emit(AddEditGenderSelected(arrGender[index]));
                              Navigator.pop(context);
                            },
                          ),
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: arrGender.length),
                ],
              ),
            );
          });
        }).whenComplete(() {});
  }

  imageUploadTrigger(String userImage, bool isImageUpload) {
    emit(AddEditImageSelected(userImage, isImageUpload, serverImage));
  }

  selectDateCubit(BuildContext context, DateTime selectedDate) async {
    var finalDate = '';
    var isoFormatSelectedDate = '';
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
      if (kDebugMode) {
        print(selectedDate);
      }
      isoFormatSelectedDate =
          DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(selectedDate);
    }
    emit(AddEditDateSelected(finalDate, isoFormatSelectedDate));
  }

  loadMemberList(List<MemberListDataModel> listData, String searchKeyWord) {
    if (arrMemberList.length < (totalCountMembers - 1)) {
      skip += 10;
      memberFetchCubit(searchKeyWord);
    } else {
      if (kDebugMode) {
        print("no need to call api");
      }
    }
  }

  loadAssignedMemberList(List<MemberListDataModel> listData, String searchKeyWord) {
    if (arrMemberList.length < (totalCountMembers - 1)) {
      assignMemberSkip += 10;
      assignedMemberFetchCubit(searchKeyWord);
    } else {
      if (kDebugMode) {
        print("no need to call api");
      }
    }
  }

  memberFetchCubit(String? searchText) async {
    final Map<String, dynamic> map = {};
    map['pagination'] = true;
    map['skip'] = skip;
    map['limit'] = perPage;
    // map['search'] = searchText ?? '';

    // AppCommonFeatures.instance.showCircularProgressDialog();
    await AppCommonFeatures.instance.apiRepository
        .fetchMemberList(map)
        .then((value) async {
      if (value?.success ?? false) {
        // AppCommonFeatures.instance.dismissCircularProgressDialog();
        totalCountMembers = value?.data?.totalRecords ?? 0;
        arrMemberList.addAll(value?.data?.memberList ?? []);
        emit(MemberStateLoaded(arrMemberList));
      }else {
        // AppCommonFeatures.instance.dismissCircularProgressDialog();
      }
    });
  }


  assignedMemberFetchCubit(String? searchText) async {
    final Map<String, dynamic> map = {};
    map['pagination'] = true;
    map['skip'] = assignMemberSkip;
    map['limit'] = perPage;
    // map['search'] = searchText ?? '';

    // AppCommonFeatures.instance.showCircularProgressDialog();
    /// feting member list for temporary basis...
    await AppCommonFeatures.instance.apiRepository
        .fetchAssignedMemberList(map)
        .then((value) async {
      if (value?.success ?? false) {
        // AppCommonFeatures.instance.dismissCircularProgressDialog();
        totalCountMembers = value?.data?.totalRecords ?? 0;
        arrMemberList.addAll(value?.data?.memberList ?? []);
        emit(AssignedMemberStateLoaded(arrMemberList));
      }else {
        // AppCommonFeatures.instance.dismissCircularProgressDialog();
      }
    });
  }


}
