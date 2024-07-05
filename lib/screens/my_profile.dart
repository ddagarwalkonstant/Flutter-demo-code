import 'package:base_arch_proj/common_widgets/my_profile_list_widget.dart';
import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/models/MyProfileModel.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:base_arch_proj/utils/RouterNavigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/myprofile/my_profile_cubit.dart';
import '../common_widgets/popup_icon_button_widget.dart';
import '../constant/AppSizer.dart';
import '../res/fonts/font_family.dart';
import '../utils/image_mixin/image_mixin.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> with ImageMixin {
  var userImage = AppCommonFeatures.instance.imagesFactory.user;
  var isImageUpload = false;
  String? serverImage;
  MyProfileCubit myProfileCubit = MyProfileCubit();
  MyProfileModel? myProfileModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCommonFeatures.instance.contextInit(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      myProfileCubit.fetcMyProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: getAppBar(),
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => myProfileCubit,
          child: BlocBuilder<MyProfileCubit, MyProfileState>(
            builder: (context, state) {
              if (state is MyPrfoileDetailsState) {
                 myProfileModel=state.myProfileModel;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizer.twenteeyFour),
                    child: Column(children: [
                      topProfileWidget(myProfileModel?.data?.avatar),
                      const SizedBox(
                        height: AppSizer.twenteey,
                      ),
                       Text(myProfileModel!.data!.fullName!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: AppSizer.twenteeyFour,
                              fontFamily: FontFamily.archivo,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),
                      Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                            color: AppColor.textFieldBackground,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            MyProfileListWidget(
                              imgOption:
                                  AppCommonFeatures.instance.imagesFactory.user,
                              titleOption: AppStrings.fullName,
                              valueOption: myProfileModel?.data?.fullName,
                              showVerified: false,
                              verifiedVisible:false,
                            ),
                            getDivider(),
                            MyProfileListWidget(
                              imgOption: AppCommonFeatures
                                  .instance.imagesFactory.nicknameIcon,
                              titleOption: AppStrings.nickname,
                              valueOption: myProfileModel?.data?.nickName,
                              showVerified: false,
                              verifiedVisible:false,
                            ),
                            getDivider(),
                            MyProfileListWidget(
                              imgOption: AppCommonFeatures
                                  .instance.imagesFactory.uniqueIcon,
                              titleOption: AppStrings.uniqueID,
                              valueOption: myProfileModel?.data?.userName,
                              showVerified: false,
                              verifiedVisible:false,
                            ),
                            getDivider(),
                            MyProfileListWidget(
                              imgOption: AppCommonFeatures
                                  .instance.imagesFactory.calenderIcon,
                              titleOption: AppStrings.dateOfBirth,
                              valueOption: (myProfileModel?.data?.dob != null) ? AppCommonFeatures.instance.getFormattedDate(myProfileModel?.data?.dob) ?? '' : '',
                              showVerified: false,
                              verifiedVisible:false,
                            ),
                            getDivider(),
                            /// mobile number
                            MyProfileListWidget(
                              imgOption: AppCommonFeatures.instance.imagesFactory.mobile,
                              titleOption: AppStrings.mobile_number,
                              valueOption: myProfileModel?.data?.phone,
                              showVerified: false,
                              verifiedVisible:false,
                              showOptional: true,
                            ),
                            getDivider(),
                            MyProfileListWidget(
                              imgOption: AppCommonFeatures
                                  .instance.imagesFactory.email,
                              titleOption: AppStrings.email,
                              valueOption: myProfileModel?.data?.email,
                              showVerified: myProfileModel?.data?.isEmailVerify,
                              verifiedVisible:true,
                            ),
                            getDivider(),
                            MyProfileListWidget(
                              imgOption: AppCommonFeatures
                                  .instance.imagesFactory.short_bio,
                              titleOption: AppStrings.shortBio,
                              valueOption:myProfileModel?.data?.bio,
                              showVerified: false,
                              verifiedVisible:false,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: AppSizer.fifty,
                      ),
                      SizedBox(
                        width: screenWidth,
                        height: 50,
                        child: TextButton.icon(
                          icon: Image.asset(
                            AppCommonFeatures.instance.imagesFactory.delete ??
                                '',
                            height: 20,
                            width: 20,
                          ),
                          label: const Text(
                            AppStrings.deleteAccount,
                            style: TextStyle(
                                fontFamily: FontFamily.archivo,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                          onPressed: () {
                            /// delete tapped
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return PopupIconButtonWidget(
                                    title:
                                        'Are you sure you want to delete your profile?',
                                    titleDescription:
                                        'If the account is deleted, all data and records will also be deleted',
                                    okButtonText: AppStrings.delete,
                                    okButtonColor: AppColor.redDelete,
                                    topIcon: AppCommonFeatures.instance.imagesFactory.deleteIcons,
                                    onPressedCancel: () {
                                      Navigator.pop(context);
                                    },
                                    onPressedOk: () async {
                                      AppCommonFeatures.instance.contextInit(context);
                                      myProfileCubit.deleteFetchCubit();
                                      Navigator.pop(context);
                                    },
                                  );
                                });
                          },
                        ),
                      ),
                      SizedBox(
                        width: screenWidth,
                        height: 50,
                        child: TextButton.icon(
                            icon: Image.asset(
                              AppCommonFeatures.instance.imagesFactory.logout ??
                                  '',
                              height: 20,
                              width: 20,
                            ),
                            label: const Text(
                              AppStrings.logout,
                              style: TextStyle(
                                  fontFamily: FontFamily.archivo,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            onPressed: () {
                              /// logout tapped
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return PopupIconButtonWidget(
                                      title: 'Are you sure you want to logout?',
                                      okButtonText: AppStrings.logout,
                                      okButtonColor:
                                          AppColor.theme_primary_blue,
                                      topIcon: AppCommonFeatures
                                          .instance.imagesFactory.logoutIcons,
                                      onPressedCancel: () {
                                        Navigator.pop(context);
                                      },
                                      onPressedOk: () async {
                                        AppCommonFeatures.instance.contextInit(context);
                                        Navigator.pop(context);
                                        myProfileCubit.logoutFetchCubit();
                                      },
                                    );
                                  });
                            }),
                      ),
                      const SizedBox(
                        height: AppSizer.fifty,
                      ),
                    ]),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      title: Transform(
        transform: Matrix4.translationValues(0, 0, 0),
        child: const Text(AppStrings.my_profile,
            style: TextStyle(
                fontFamily: FontFamily.archivo,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white)),
      ),
      backgroundColor: AppColor.theme_primary_blue,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      titleSpacing: 10.0,
      centerTitle: true,
      leading: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget getDivider() {
    return const Divider(
      indent: AppSizer.twenteey,
      endIndent: AppSizer.twenteey,
      thickness: 2,
      color: Colors.white,
    );
  }

  Widget topProfileWidget(String? avatar) {
    return SizedBox(
      height: 180,
      width: screenWidth,
      child: Stack(
        children: [
          Positioned.fill(
            top: 30,
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(alignment: Alignment.center, children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(70),
                        border: Border.all(
                            color: AppColor.textFieldBackground, width: 2)),
                    height: 140,
                    width: 140),
                ClipRRect(
                  borderRadius: BorderRadius.circular(65),
                  child: SizedBox(
                    height: 130,
                    width: 130,
                    child: CachedNetworkImage(
                       imageUrl: (avatar != null && avatar !='') ? '${AppCommonFeatures.instance.imageBaseUrl}$avatar' : '',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(userImage)
                    ),
                  ),
                ),
                Positioned(
                    right: 5,
                    bottom: 10,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset:
                                  const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(17.5),
                          color: Colors.white),
                      child: IconButton(
                        onPressed: () async {
                          Map<String,dynamic> map=Map();
                          map['type']="Edit";
                          map['module']=myProfileModel;
                          await Navigator.pushNamed(
                              context, RouterNavigator.completeProfile,
                              arguments: map)
                              .then((value) {
                                AppCommonFeatures.instance.contextInit(context);

                            Future.delayed(Duration.zero, () {
                              myProfileCubit.fetcMyProfile();
                            });
                          });
                        },
                        icon: const Icon(Icons.edit,
                            size: 18, color: AppColor.theme_primary_blue),
                      ),
                    ))
              ]),
            ),
          )
        ],
      ),
    );
  }
}
