
import 'package:base_arch_proj/constant/AppSizer.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:base_arch_proj/utils/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login/login_cubit.dart';
import '../common_widgets/custom_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final CommonWidget commonWidget = CommonWidget();
  TextEditingController passwordController =
  TextEditingController();
  TextEditingController confirmPasswordController =
  TextEditingController();
  final LoginCubit loginCubit = LoginCubit();
  // late final FirebaseMessaging _messaging;
  bool pswdIsObsecure = true;
  bool confirmIsObsecure = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // loginCubit.updatePasswordVisibility(passwordIsObsecure);
    });
  }

  init() async {
    // await AppCommonFunctions().contextInit(context);
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizer.fifteen),
            child: BlocProvider(
              create: (_) => loginCubit,
              child: BlocListener<LoginCubit, LoginState>(
                listener: (BuildContext context, state) {
                  // if (state is LoginStateLoaded) {
                  //   Navigator.of(context).pushNamedAndRemoveUntil(
                  //       Routerr.dashboard, (Route<dynamic> route) => false);
                  // } else if (state is UpdateLoginPasswordVisibilityState) {
                  //   passwordIsObsecure = state.isObsecure;
                  // }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizer.fifteen),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonWidget.titleMultiColor('${AppStrings.reset_} ', '${AppStrings.password}!'),
                      const SizedBox(height: 15),
                      commonWidget.title('Don’t worry! It happens, Please enter the emai address associated with your account.'),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),
                      /// password
                      commonWidget.titleOfTextField(AppStrings.new_password),
                      const SizedBox(
                        height: AppSizer.ten,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return commonWidget.passwordTextFieldWithToggle(
                              hintText: '${AppStrings.enter_} ${AppStrings.new_password}',
                              controller: passwordController,
                              isObscureText: pswdIsObsecure,
                              leftIcon:
                              AppCommonFeatures.instance.imagesFactory.pass_lock,
                              onToggle: (bool isObscure) {
                                // loginCubit.updatePasswordVisibility(isObscure);
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
                      BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return commonWidget.passwordTextFieldWithToggle(
                              hintText:
                              '${AppStrings.enter_} ${AppStrings.confirm_password}',
                              controller: confirmPasswordController,
                              isObscureText: confirmIsObsecure,
                              leftIcon:
                              AppCommonFeatures.instance.imagesFactory.pass_lock,
                              onToggle: (bool isObscure) {
                                // loginCubit.updatePasswordVisibility(isObscure);
                              },
                            );
                          }),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),
                      CustomButton(label: AppStrings.submit, onPressed: () {
                        AppCommonFeatures().contextInit(context);
                        // loginCubit.LoginFetchCubit(
                        //     emailController.text, password_controller.text);
                      },),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),

                      const SizedBox(
                        height: AppSizer.thirty,
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
}
