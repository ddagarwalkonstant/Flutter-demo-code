import 'package:base_arch_proj/bloc/contactUs/contact_us_cubit.dart';
import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_widgets/custom_button.dart';
import '../constant/AppSizer.dart';
import '../res/fonts/font_family.dart';
import '../utils/commonWidget.dart';


class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  final CommonWidget commonWidget = CommonWidget();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController addNoteController = TextEditingController();

  final ContactUsCubit _contactCubit = ContactUsCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    // SchedulerBinding.instance.addPostFrameCallback((_) {
      // loginCubit.updatePasswordVisibility(passwordIsObsecure);
    // });
  }

  init() async {
    // await AppCommonFunctions().contextInit(context);
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    mobileNumberController.dispose();
    addNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: getAppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizer.fifteen),
              child: BlocProvider(
                create: (_) => _contactCubit,
                child: BlocListener<ContactUsCubit, ContactUsState>(
                  listener: (BuildContext context, state) {
                    if (state is ContactUsStateLoaded) {
                      if (state.isStateLoaded) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizer.fifteen),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// full name
                        commonWidget.titleOfTextField(AppStrings.fullName),
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

                        /// Email Id
                        commonWidget.titleOfTextField(
                            "${AppStrings.email} ${AppStrings.id_}"),
                        const SizedBox(
                          height: AppSizer.ten,
                        ),
                        commonWidget.textfield('${AppStrings.enter_} ${AppStrings.email}',
                            emailController,
                            false,
                            keyboardType: TextInputType.emailAddress,
                            leftIcon: AppCommonFeatures.instance.imagesFactory.email),

                        const SizedBox(
                          height: AppSizer.thirty,
                        ),

                        /// Mobile Number
                        commonWidget.titleOfTextField(
                            "${AppStrings.mobile_number} ${AppStrings.optional}"),
                        const SizedBox(
                          height: AppSizer.ten,
                        ),
                        commonWidget.textfield('${AppStrings.enter_} ${AppStrings.mobile_number}',
                            mobileNumberController,
                            false,
                            keyboardType: TextInputType.phone,
                            leftIcon: AppCommonFeatures.instance.imagesFactory.phone),
                        const SizedBox(
                          height: AppSizer.thirty,
                        ),

                        /// Add note
                        commonWidget.titleOfTextField(
                            AppStrings.addNote),
                        const SizedBox(
                          height: AppSizer.ten,
                        ),

                        SizedBox(
                          height: AppSizer.hundred,
                          width: screenWidth,
                          child: TextField(
                            maxLines: 5, // Set this
                            expands: false,
                            controller: addNoteController,
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
                                  borderSide: const BorderSide(color: AppColor.theme_primary_blue),
                                  borderRadius: BorderRadius.circular(AppSizer.ten)),
                              contentPadding: const EdgeInsets.all(AppSizer.ten),
                              hintStyle: const TextStyle(
                                  color: AppColor.text_grey_,
                                  fontSize: AppSizer.fifteen),
                              hintText: AppStrings.addNote,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: AppSizer.fifty,
                        ),
                        CustomButton(
                          label: AppStrings.submit,
                          onPressed: () {
                            AppCommonFeatures().contextInit(context);
                            _contactCubit.addContactUsCubit(fullNameController.text, emailController.text, mobileNumberController.text, addNoteController.text);
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
      )
    );
  }

  AppBar getAppBar() {
    return AppBar(
      title: Transform(
        transform: Matrix4.translationValues(0, 0, 0),
        child: const Text(AppStrings.contact_us,
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


}
