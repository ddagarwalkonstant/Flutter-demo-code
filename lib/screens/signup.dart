import 'package:base_arch_proj/bloc/signup/signup_cubit.dart';
import 'package:base_arch_proj/constant/AppSizer.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/res/fonts/font_family.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:base_arch_proj/utils/RouterNavigator.dart';
import 'package:base_arch_proj/utils/commonWidget.dart';
import 'package:base_arch_proj/utils/types.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login/login_cubit.dart';
import '../common_widgets/custom_button.dart';
import '../constant/AppColor.dart';
import 'SocialLoginWidget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final CommonWidget commonWidget = CommonWidget();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final SignupCubit signupCubit = SignupCubit();
  final LoginCubit loginCubit = LoginCubit();

  bool isChecked = false;

  bool pswdIsObsecure = true;
  bool confirmIsObsecure = true;
  // late final FirebaseMessaging _messaging;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();

  }

  init() async {
    AppCommonFeatures.instance.contextInit(context);
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    mobileNumberController.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizer.fifteen),
            child: MultiBlocProvider(
              providers: [

                BlocProvider<SignupCubit>(
                  create: (context) => signupCubit,
                ),
                BlocProvider<LoginCubit>(
                  create: (context) => loginCubit,
                ),
              ],

              child: MultiBlocListener(
                listeners: [
                  BlocListener<SignupCubit, SignupState>(
                    listener: (context, state) {
                      if (state is SignupStateLoaded) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            RouterNavigator.loginScreen, (Route<dynamic> route) => false);
                      } else if (state is UpdatePasswordVisibilityState) {
                        pswdIsObsecure = state.isObsecure;
                      }
                    },
                  ),
                  BlocListener<LoginCubit, LoginState>(
                    listener: (BuildContext context, state) {
                      if (state is LoginStateLoaded) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            RouterNavigator.dashBoardScreen, (Route<dynamic> route) => false);
                      }
                    },)
                ],

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizer.fifteen),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonWidget.titleMultiColor(
                          '${AppStrings.welcome} ${AppStrings.to_} ', '${AppStrings.appName}.'),
                      const SizedBox(height: 15),
                      commonWidget.title(
                          'Get ready to unlock a world of possibilities - log in to your account now!'),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),

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
                      commonWidget.textfield(
                          '${AppStrings.enter_} ${AppStrings.email}',
                          emailController,
                          false,
                          keyboardType: TextInputType.emailAddress,
                          leftIcon: AppCommonFeatures.instance.imagesFactory.email),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),

                      /// Mobile Number
                      commonWidget.titleOfTextField(
                          '${AppStrings.mobile_number} (${AppStrings.optional_})'),
                      const SizedBox(
                        height: AppSizer.ten,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSizer.thirty),
                        child: commonWidget.textfield(
                            '${AppStrings.enter_} ${AppStrings.mobile_number}',
                            mobileNumberController,
                            false,
                            keyboardType: TextInputType.number,
                            leftIcon:
                            AppCommonFeatures.instance.imagesFactory.phone),
                      ),

                      /// password
                      commonWidget.titleOfTextField(AppStrings.password),
                      const SizedBox(
                        height: AppSizer.ten,
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                            return commonWidget.passwordTextFieldWithToggle(
                              hintText: '${AppStrings.enter_} ${AppStrings.password}',
                              controller: passwordController,
                              isObscureText: pswdIsObsecure,
                              leftIcon:
                              AppCommonFeatures.instance.imagesFactory.pass_lock,
                              onToggle: (bool isObscure) {
                                pswdIsObsecure=isObscure;
                                signupCubit.emit(UpdatePasswordVisibilityState(pswdIsObsecure,TypesEnum.password.name));
                              },
                            );
                          }),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),

                      /// confirm password
                      commonWidget.titleOfTextField(AppStrings.confirm_password),
                      const SizedBox(
                        height: AppSizer.ten,
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                            return commonWidget.passwordTextFieldWithToggle(
                              hintText:
                              '${AppStrings.enter_} ${AppStrings.confirm_password}',
                              controller: confirmPasswordController,
                              isObscureText: confirmIsObsecure,
                              leftIcon:
                              AppCommonFeatures.instance.imagesFactory.pass_lock,
                              onToggle: (bool isObscure) {
                                confirmIsObsecure=isObscure;
                                signupCubit.emit(UpdatePasswordVisibilityState(confirmIsObsecure,TypesEnum.confirm_password.name));
                              },
                            );
                          }),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),
                      ListTileTheme(
                          horizontalTitleGap: 0,
                          child: CheckboxListTile(
                              activeColor: AppColor.theme_light_blue,
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: AppStrings.by_registering_accept,
                                        style: TextStyle(
                                            fontSize: AppSizer.sixteen,
                                            fontFamily: FontFamily.archivo,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.text_grey_)),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, RouterNavigator.staticPageScreen,
                                              arguments:
                                              AppStrings.terms_condition);
                                        },
                                      text: AppStrings.terms_of_services,
                                      style: const TextStyle(
                                          fontSize: AppSizer.sixteen,
                                          fontFamily: FontFamily.archivo,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.theme_primary_blue),
                                    ),
                                    const TextSpan(
                                        text: " & ",
                                        style: TextStyle(
                                            fontSize: AppSizer.sixteen,
                                            fontFamily: FontFamily.archivo,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.text_grey_)),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, RouterNavigator.staticPageScreen,
                                              arguments: AppStrings.privacy_policy);
                                        },
                                      text: AppStrings.privacy_policy,
                                      style: const TextStyle(
                                          fontSize: AppSizer.sixteen,
                                          fontFamily: FontFamily.archivo,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.theme_primary_blue),
                                    ),
                                  ],
                                ),
                              ),
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value ?? false;
                                });
                              })
                      ),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),
                      CustomButton(
                        label: AppStrings.submit,
                        onPressed: () async {
                          AppCommonFeatures.instance.contextInit(context);
                          signupCubit.signupFetchCubit(fullNameController.text, emailController.text, passwordController.text, confirmPasswordController.text, mobileNumberController.text, isChecked);


                        },
                      ),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Container(
                                width: double.infinity,
                                height: AppSizer.one,
                                color: AppColor.text_grey_.withOpacity(0.5),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: AppSizer.ten, right: AppSizer.ten),
                              child: CommonWidget()
                                  .simpleText_body_text_color(AppStrings.or_)),
                          Expanded(
                              child: Container(
                                width: double.infinity,
                                height: AppSizer.one,
                                color: AppColor.text_grey_.withOpacity(0.5),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),
                      SocialLoginWidget(loginCubit, 'SignUpScreen'),
                      const SizedBox(
                        height: AppSizer.fifty,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                  text: AppStrings.already_account,
                                  style: TextStyle(
                                      fontSize: AppSizer.sixteen,
                                      fontFamily: FontFamily.archivo,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.text_grey_)),
                              TextSpan(
                                text: AppStrings.login,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(
                                        context
                                    );
                                  },
                                style: const TextStyle(
                                    fontSize: AppSizer.sixteen,
                                    fontFamily: FontFamily.archivo,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.theme_primary_blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
