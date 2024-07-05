import 'package:base_arch_proj/bloc/myprofile/my_profile_cubit.dart';
import 'package:base_arch_proj/common_widgets/my_account_option_widget.dart';
import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:base_arch_proj/utils/RouterNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../res/fonts/font_family.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  MyProfileCubit myProfileCubit = MyProfileCubit();

  bool? isNotificationOn = true;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) => initSetup());
    super.initState();
  }

  initSetup() async {
     var model = await AppCommonFeatures.instance.sharedPreferenceHelper.getLoginUserDetails();
     isNotificationOn = model?.data?.user?.pushNotificationAllowed ?? false;
     myProfileCubit.emit(NotificationAllowState(model!));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: getAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => myProfileCubit,
            child: BlocListener<MyProfileCubit, MyProfileState>(
              listener: (BuildContext context, state) {
                if (state is NotificationAllowState) {
                  isNotificationOn = (state.model.data?.user?.pushNotificationAllowed ?? false);
                }
             },
              child: Column(children: [
              MyAccountOptionWidget(
                imgOption: AppCommonFeatures.instance.imagesFactory.user,
                titleOption: AppStrings.myProfile,
                onPressedOption: () {
                  Navigator.of(context).pushNamed(RouterNavigator.myProfile);
                },
              ),
              BlocBuilder<MyProfileCubit, MyProfileState>(
                 builder: (context, state) {
                return MyAccountOptionWidget(
                imgOption: AppCommonFeatures.instance.imagesFactory.notification_bell,
                titleOption: AppStrings.pushNotification,
                isNotificationOn: isNotificationOn,
                onPressedOption: () {
                  Navigator.of(context).pushNamed(RouterNavigator.notificationScreen);
                },
                notificationChanged: (value) {
                  myProfileCubit.allowNotificationCubit(isNotificationOn ?? false);
                },
              );
             }),
              MyAccountOptionWidget(
                imgOption:
                AppCommonFeatures.instance.imagesFactory.privacy_policy,
                titleOption: AppStrings.privacy_policy,
                onPressedOption: () {
                  Navigator.pushNamed(context, RouterNavigator.staticPageScreen,
                      arguments: AppStrings.privacy_policy);
                },
              ),
              MyAccountOptionWidget(
                imgOption:
                AppCommonFeatures.instance.imagesFactory.termsCondition,
                titleOption: AppStrings.terms_condition,
                onPressedOption: () {
                  Navigator.pushNamed(context, RouterNavigator.staticPageScreen,
                      arguments: AppStrings.terms_condition);
                },
              ),
              MyAccountOptionWidget(
                imgOption: AppCommonFeatures.instance.imagesFactory.change_password,
                titleOption: AppStrings.changePassword,
                onPressedOption: () {
                  Navigator.of(context).pushNamed(RouterNavigator.changePasswordScreen);
                },
              ),
              MyAccountOptionWidget(
                imgOption: AppCommonFeatures.instance.imagesFactory.FAQ,
                titleOption: AppStrings.faq,
                onPressedOption: () {
                  Navigator.pushNamed(context, RouterNavigator.staticPageScreen,
                      arguments: AppStrings.faq);
                },
              ),
              MyAccountOptionWidget(
                imgOption: AppCommonFeatures.instance.imagesFactory.contact_us,
                titleOption: AppStrings.contact_us,
                onPressedOption: () {
                  Navigator.of(context)
                      .pushNamed(RouterNavigator.contactUsScreen);
                },
              ),
            ]),
),
          ),
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      title: Transform(
        transform: Matrix4.translationValues(0, 0, 0),
        child: const Text(AppStrings.account_,
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
    );
  }
}
