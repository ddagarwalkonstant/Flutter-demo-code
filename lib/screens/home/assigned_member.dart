import 'package:base_arch_proj/bloc/member/member_cubit.dart';
import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppSizer.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/models/memberListModel.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:base_arch_proj/utils/RouterNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_widgets/member_detail_widget.dart';
import '../../utils/commonWidget.dart';

class AssignMemberScreen extends StatefulWidget {
  @override
  State<AssignMemberScreen> createState() => AssignMemberScreenState();
}

class AssignMemberScreenState extends State<AssignMemberScreen> {
  bool isBlank = false;
  final CommonWidget commonWidget = CommonWidget();
  final MemberCubit _memberCubit = MemberCubit();
  List<MemberListDataModel> assignedMemberList = [];
  late final ScrollController _controller = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(_scrollListener);
    init();
  }

  init() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getMemberData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _getMemberData() async {
    AppCommonFeatures().contextInit(context);
    _memberCubit.arrMemberList = [];
    await _memberCubit.assignedMemberFetchCubit('');
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      AppCommonFeatures().contextInit(context);
      _memberCubit.loadAssignedMemberList(assignedMemberList, '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: isBlank
          ? commonWidget.blankData(
              AppStrings.your_assignmember_msg,
              AppStrings.assignmember_sub_msg,
              AppCommonFeatures.instance.imagesFactory.assign_user,
              "",
              null)
          : Padding(
            padding: const EdgeInsets.only(top: AppSizer.fifteen, left: AppSizer.twenteey, right: AppSizer.twenteey),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(AppStrings.assigned_members,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizer.twenteey)
                  ),
                  const SizedBox(height: AppSizer.fifteen),
                  SizedBox(
                    height: screenHeight * 0.565,
                    child: BlocProvider(
                      create: (context) => _memberCubit,
                      child: BlocBuilder<MemberCubit, MemberState>(
                        builder: (context, state) {
                          if (state is AssignedMemberStateLoaded) {
                            return (state.memberList.isEmpty)
                                ? commonWidget.blankData(
                                    AppStrings.your_assignmember_msg,
                                    AppStrings.assignmember_sub_msg,
                                    AppCommonFeatures
                                        .instance.imagesFactory.assign_user,
                                    "",
                                    null)
                                : ListView.separated(
                                    controller: _controller,
                                    shrinkWrap: false,
                                    primary: false,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          /// on member details tapped
                                          await Navigator.of(context).pushNamed(
                                              RouterNavigator.memberDetailScreen,
                                              arguments: {
                                                'memberId':
                                                    state.memberList[index].id ??
                                                        '',
                                                'index': index,
                                                'fromWhere': 'assignedMember'
                                              });
                                        },
                                        child: MemberDetailWidget(
                                          userImage:
                                              '${AppCommonFeatures.instance.imageBaseUrl}${state.memberList[index].avatar ?? ''}',
                                          userName:
                                              state.memberList[index].fullName ??
                                                  '',
                                          userDOB:
                                              state.memberList[index].dob ?? '',
                                          userGender:
                                              state.memberList[index].gender ??
                                                  '',
                                          userRelation:
                                              state.memberList[index].relation ??
                                                  '',
                                          showMoreIcon: false,
                                          onPressedOption: () {
                                            /// tapped
                                          },
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                          height: AppSizer.fifteen);
                                    },
                                    itemCount: state.memberList.length,
                                  );
                          } else {
                            return  SizedBox(
                                width: screenWidth,
                                height: screenHeight,
                                child: const Center(
                                  heightFactor: 55,
                                  widthFactor: 55,
                                  child: CircularProgressIndicator(
                                    color: AppColor.theme_primary_blue,
                                  ),
                                )
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
          ),
    );
  }
}
