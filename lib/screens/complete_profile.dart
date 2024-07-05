import 'dart:io';

import 'package:base_arch_proj/bloc/myprofile/my_profile_cubit.dart';
import 'package:base_arch_proj/constant/AppSizer.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/models/MyProfileModel.dart';
import 'package:base_arch_proj/res/fonts/font_family.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:base_arch_proj/utils/RouterNavigator.dart';
import 'package:base_arch_proj/utils/commonWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common_widgets/custom_button.dart';
import '../constant/AppColor.dart';
import '../utils/image_mixin/image_mixin.dart';

class CompleteProfileScreen extends StatefulWidget {

  String? type;
  MyProfileModel? myProfileModel;

  CompleteProfileScreen(map, {super.key}){
    type=map['type'];
    myProfileModel=map['module'];
  }

  @override
  State<StatefulWidget> createState() => CompleteProfileScreenState();
}

class CompleteProfileScreenState extends State<CompleteProfileScreen>
    with ImageMixin {
  final CommonWidget commonWidget = CommonWidget();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController uniqueIdController = TextEditingController();
  TextEditingController shortBioController = TextEditingController();
  final MyProfileCubit myProfileCubit = MyProfileCubit();
  File? file;
  String? imgPath;

  bool isChecked = false;

  bool pswdIsObsecure = true;
  bool confirmIsObsecure = true;

  var userImage = AppCommonFeatures.instance.imagesFactory.user;
  var isImageUpload = false;
  String? serverImage;

  // late final FirebaseMessaging _messaging;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();


  }

  init() async {
    controlFill();
    AppCommonFeatures.instance.contextInit(context);
    if(widget.type != "Edit"){
      SchedulerBinding.instance.addPostFrameCallback((_) {
        myProfileCubit.fetcMyProfile();
      });
    }
  }
  void controlFill() {
    if (widget.myProfileModel != null) {
      emailController.text = widget.myProfileModel?.data?.email ?? '';
      fullNameController.text = widget.myProfileModel?.data?.fullName ?? '';
      nickNameController.text = widget.myProfileModel?.data?.nickName ?? '';
      uniqueIdController.text = widget.myProfileModel?.data?.userName ?? '';
      if (widget.myProfileModel!.data!.dob != '') {
        dateController.text = AppCommonFeatures.instance.getFormattedDate(widget.myProfileModel!.data!.dob!);
      }
      mobileNumberController.text = widget.myProfileModel?.data?.phone ?? '';
      shortBioController.text = widget.myProfileModel?.data?.bio ?? '';
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    mobileNumberController.dispose();
    dateController.dispose();
    nickNameController.dispose();
    uniqueIdController.dispose();
    shortBioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.type == "Edit"
          ? commonWidget.getAppBar(context, AppStrings.editProfile)
          : null,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizer.fifteen),
        child: BlocProvider(
          create: (_) => myProfileCubit,
          child: BlocListener<MyProfileCubit, MyProfileState>(
            listener: (BuildContext context, state) {
              if(widget.type=="Edit"){
                if(state is MyPrfoileUpdateState){
                  Navigator.pop(context);
                }
              }else{
                if( state is MyPrfoileDetailsState){
                  widget.myProfileModel=state.myProfileModel;
                  controlFill();
                }else if(state is MyPrfoileUpdateState){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouterNavigator.dashBoardScreen, (Route<dynamic> route) => false);
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizer.fifteen),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.type != "Edit") ...[
                    getSkipWidget(true),
                    commonWidget.titleMultiColor(
                        '${AppStrings.complete_} ', '${AppStrings.profile}!'),
                    const SizedBox(height: 15),
                    commonWidget.title(
                        'Get ready to unlock a world of possibilities - log in to your account now!'),
                    const SizedBox(height: 15),
                  ],

                  BlocBuilder<MyProfileCubit, MyProfileState>(
                    builder: (context, state) {
                      return topProfileWidget();
                    },
                  ),
                  const SizedBox(
                    height: AppSizer.thirty,
                  ),

                  /// full name
                  commonWidget.titleOfTextField("${AppStrings.fullName}*"),
                  const SizedBox(
                    height: AppSizer.ten,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSizer.thirty),
                    child: commonWidget.textfield(
                        '${AppStrings.enter_} ${AppStrings.fullName}',
                        fullNameController,
                        false,
                        keyboardType: TextInputType.text,
                        leftIcon:
                            AppCommonFeatures.instance.imagesFactory.user),
                  ),

                  /// Nick Name
                  commonWidget.titleOfTextField(AppStrings.nickname),
                  const SizedBox(
                    height: AppSizer.ten,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSizer.thirty),
                    child: commonWidget.textfield(
                        '${AppStrings.enter_} ${AppStrings.nickname}',
                        nickNameController,
                        false,
                        keyboardType: TextInputType.text,
                        leftIcon: AppCommonFeatures
                            .instance.imagesFactory.nicknameIcon),
                  ),

                  /// Unique ID
                  commonWidget.titleOfTextField(AppStrings.uniqueID),
                  const SizedBox(
                    height: AppSizer.ten,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSizer.thirty),
                    child: commonWidget.textfield(
                        '${AppStrings.enter_} ${AppStrings.uniqueID}',
                        uniqueIdController,
                        false,
                        isEnable: false,
                        keyboardType: TextInputType.text,
                        leftIcon: AppCommonFeatures
                            .instance.imagesFactory.uniqueIcon),
                  ),
                  commonWidget.titleOfTextField('${AppStrings.dateOfBirth} (Optional)'),
                  const SizedBox(
                    height: AppSizer.ten,
                  ),
                  /// Date textfield
                  TextField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      suffixIconConstraints: const BoxConstraints(
                        minHeight: AppSizer.twenteeyFour,
                        minWidth: AppSizer.twenteeyFour,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(AppSizer.fifteen),
                        child: Image.asset(
                            AppCommonFeatures
                                .instance.imagesFactory.calenderIcon,
                            width: AppSizer.fourty,
                            height: AppSizer.twenteeyFour),
                      ),
                      fillColor: AppColor.textFieldBackground,
                      disabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColor.grey1),
                          borderRadius:
                              BorderRadius.circular(AppSizer.twenteeyFour)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColor.grey1),
                          borderRadius:
                              BorderRadius.circular(AppSizer.twenteeyFour)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.theme_primary_blue),
                          borderRadius:
                              BorderRadius.circular(AppSizer.twenteeyFour)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: AppSizer.ten),
                      hintStyle: const TextStyle(
                          color: AppColor.text_grey_,
                          fontSize: AppSizer.fifteen),
                      hintText: AppStrings.date_placeholder,
                    ),
                    onTap: () async {
                    String date = await AppCommonFeatures.instance.selectDateCubit(context, DateTime.now());
                    if(date != ''){
                      dateController.text = date;
                      myProfileCubit.emit(MyProfileInitial());
                    }

                    },
                  ),
                  const SizedBox(
                    height: AppSizer.thirty,
                  ),

                  /// Mobile Number
                  commonWidget.titleOfTextField("${AppStrings.mobile_number} (Optional)"),
                  const SizedBox(
                    height: AppSizer.ten,
                  ),
                  commonWidget.textfield(
                      '${AppStrings.enter_} ${AppStrings.mobile_number}',
                      mobileNumberController,
                      false,
                      keyboardType: TextInputType.phone,
                      leftIcon: AppCommonFeatures.instance.imagesFactory.phone),
                  const SizedBox(
                    height: AppSizer.thirty,
                  ),

                  /// Email Id
                  commonWidget.titleOfTextField(
                      "${AppStrings.email} ${AppStrings.id_}"),
                  const SizedBox(
                    height: AppSizer.ten,
                  ),
                  commonWidget.textfield(
                      '${AppStrings.enter_} ${AppStrings.email}',
                      emailController,
                      false,
                      isEnable: false,
                      keyboardType: TextInputType.emailAddress,
                      leftIcon: AppCommonFeatures.instance.imagesFactory.email),

                  const SizedBox(
                    height: AppSizer.thirty,
                  ),

                  /// short Bio
                  commonWidget.titleOfTextField(AppStrings.shortBio),
                  const SizedBox(
                    height: AppSizer.ten,
                  ),
                  SizedBox(
                    height: AppSizer.one_hundred_fifty,
                    width: screenWidth,
                    child: TextField(
                      maxLines: null, // Set this
                      expands: true,
                      controller: shortBioController,
                      maxLength: 500,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.textFieldBackground,
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColor.grey1),
                            borderRadius: BorderRadius.circular(AppSizer.ten)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColor.grey1),
                            borderRadius: BorderRadius.circular(AppSizer.ten)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColor.theme_primary_blue),
                            borderRadius: BorderRadius.circular(AppSizer.ten)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSizer.ten),
                        hintStyle: const TextStyle(
                            color: AppColor.textFieldBackground,
                            fontSize: AppSizer.fifteen),
                        hintText: AppStrings.date_hint,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: AppSizer.fifty,
                  ),
                  CustomButton(
                    label: widget.type == "Edit" ? AppStrings.save : AppStrings.submit,
                    onPressed: () async {
                      int? timeStamp;
                      if (dateController.text != '') {
                         timeStamp = AppCommonFeatures.instance.getStringFromTimeStamp(dateController.text);
                      }
                      myProfileCubit.updateProfile(fullNameController.text, nickNameController.text, mobileNumberController.text, timeStamp, shortBioController.text, imgPath);
                    },
                  ),
                  const SizedBox(
                    height: AppSizer.fifty,
                  ),
                  // SocialLoginWidget(loginCubit),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget getSkipWidget(bool isShow) {
    return Visibility(
      visible: true,
      child: SizedBox(
        width: screenWidth,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 32,
              width: 82,
              decoration: ShapeDecoration(
                color: AppColor.textFieldBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouterNavigator.dashBoardScreen, (Route<dynamic> route) => false);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.skip,
                        style: TextStyle(
                            fontSize: AppSizer.sixteen,
                            fontFamily: FontFamily.archivo,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                    Icon(Icons.arrow_forward, color: Colors.black, size: 13)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget topProfileWidget() {
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
                 child:  SizedBox(
                   height: 130,
                   width: 130,
                   child: CachedNetworkImage(
                     imageUrl: (widget.myProfileModel?.data?.avatar != null && widget.myProfileModel?.data?.avatar != '') ? '${AppCommonFeatures.instance.imageBaseUrl}${widget.myProfileModel?.data?.avatar}'
                         : '',
                     imageBuilder: (context, imageProvider) => Container(
                       decoration: BoxDecoration(
                         image: DecorationImage(
                             image: imageProvider, fit: BoxFit.cover),
                       ),
                     ),
                     placeholder: (context, url) =>
                     const CircularProgressIndicator(),
                     errorWidget: (context, url, error) => (imgPath != null) ? Platform.isAndroid ? Image.file(File(userImage), fit: BoxFit.cover,) : Image.asset(userImage,fit: BoxFit.cover, ) : Image.asset(userImage, fit: BoxFit.cover,),
                   ),
                 ),
               ),
                Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17.5),
                          color: AppColor.theme_primary_blue),
                      child: IconButton(
                        onPressed: () async {
                          AppCommonFeatures.instance.contextInit(context);
                          final pickedImg = await openImagePicker(
                              context,
                              50,
                              Platform.isAndroid ? await DeviceInfoPlugin().androidInfo : null);
                          if (mounted && pickedImg != null) {
                            file = pickedImg;
                            userImage = pickedImg.path;
                            imgPath = userImage;
                            widget.myProfileModel?.data?.avatar = imgPath;
                            myProfileCubit.emit(ImageUpdateState());
                          }
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Colors.white,
                        ),
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
