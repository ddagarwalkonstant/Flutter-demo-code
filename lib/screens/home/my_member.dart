import 'package:base_arch_proj/bloc/member/member_cubit.dart';
import 'package:base_arch_proj/common_widgets/member_detail_widget.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/models/memberListModel.dart';
import 'package:base_arch_proj/utils/RouterNavigator.dart';
import 'package:base_arch_proj/utils/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/AppColor.dart';
import '../../constant/AppSizer.dart';
import '../../utils/AppCommonFeatures.dart';

class MymemberScreen extends StatefulWidget {

  @override
  State<MymemberScreen> createState() => MymemberScreenState();
}

bool isblank=false;
final CommonWidget commonWidget = CommonWidget();

class MymemberScreenState extends State<MymemberScreen> {

  final MemberCubit _memberCubit = MemberCubit();
  List<MemberListDataModel> memberList = [];
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
    await _memberCubit.memberFetchCubit('');
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      AppCommonFeatures().contextInit(context);
      _memberCubit.loadMemberList(memberList, '');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: AppSizer.twenteey,
          left: AppSizer.twenteey,
          right: AppSizer.twenteey),
      color: Colors.white,
      child:  BlocProvider(
        create: (context) => _memberCubit,
        child: BlocBuilder<MemberCubit, MemberState>(
          builder: (context, state) {
            if (state is MemberStateLoaded ) {
              return (state.memberList.isEmpty)
                  ? commonWidget.blankData(AppStrings.new_member_msg,AppStrings.new_member_sub_msg,AppCommonFeatures.instance.imagesFactory.add_user,AppStrings.plus_add_member,() async {
                await Navigator.of(context).pushNamed(RouterNavigator.addMemberScreen, arguments: {'':''});
                _getMemberData();
              })
                  : Column(
                children: [

                  Row(
                    children: [
                      const Expanded(child: Text(AppStrings.my_members,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: AppSizer.twenteey))),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: AppSizer.thirty,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              surfaceTintColor: Colors.white,
                              shadowColor: AppColor.theme_primary_blue,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppSizer.twenteey),
                                  side: const BorderSide(color: AppColor.theme_primary_blue)),
                            ),
                            onPressed: () async {
                              /// add button tappped
                              await Navigator.of(context)
                                  .pushNamed(RouterNavigator.addMemberScreen, arguments: {'':''});
                              _getMemberData();
                            },
                            child: const Text(AppStrings.plus_add,
                                style: TextStyle(
                                    color: AppColor.theme_primary_blue,
                                    fontSize: AppSizer.fourteen)),
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: AppSizer.twenteey,
                  ),

                  Expanded(child: ListView.separated(
                    controller: _controller,
                    shrinkWrap: false,
                    primary: false,
                    physics: const AlwaysScrollableScrollPhysics(),
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
                                'memberId': state.memberList[index].id ?? '',
                                'index': index,
                                'fromWhere': 'myMember'
                              }).then((value) => {
                                if (value.toString() == 'memberDeleted') {
                                  _getMemberData()
                                }

                          });
                        },
                        child: MemberDetailWidget(
                          userImage:
                          '${AppCommonFeatures().imageBaseUrl}${state.memberList[index].avatar ?? ''}',
                          userName: state.memberList[index].fullName ?? '',
                          userDOB:
                          state.memberList[index].dob ?? '',
                          userGender:
                          state.memberList[index].gender ?? '',
                          userRelation:
                          state.memberList[index].relation ??
                              '',
                          showMoreIcon: true,
                          onPressedOption: () {
                            AppCommonFeatures.instance.contextInit(context);
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
                  ))
                ],
              );
            } else {
              return SizedBox(
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
    );
  }

}