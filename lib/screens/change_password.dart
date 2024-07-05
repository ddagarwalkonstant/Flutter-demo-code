
import 'package:base_arch_proj/constant/AppSizer.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:base_arch_proj/utils/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login/login_cubit.dart';
import '../common_widgets/custom_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final CommonWidget commonWidget = CommonWidget();
  TextEditingController passwordController =
  TextEditingController();
  TextEditingController newPasswordController =
  TextEditingController();
  TextEditingController confirmPasswordController =
  TextEditingController();
  final LoginCubit loginCubit = LoginCubit();
  bool pswdIsObsecure = true;
  bool confirmIsObsecure = true;
  bool newPswdIsObsecure = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();

  }

  init() async {
     await AppCommonFeatures.instance.contextInit(context);
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonWidget.getAppBar(context, AppStrings.changePassword),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizer.fifteen),
            child: BlocProvider(
              create: (_) => loginCubit,
              child: BlocListener<LoginCubit, LoginState>(
                listener: (BuildContext context, state) {
                   if (state is LoginStateLoaded) {
                     Navigator.pop(context);
                   } else if (state is UpdateLoginPasswordVisibilityState) {
                     if(state.type==AppStrings.currentPassword){
                       pswdIsObsecure = state.isObsecure;
                     }else if(state.type==AppStrings.new_password){
                       newPswdIsObsecure = state.isObsecure;
                     }else if(state.type==AppStrings.confirm_password){
                       confirmIsObsecure = state.isObsecure;
                     }

                   }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizer.fifteen),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// current password
                      const SizedBox(
                        height: AppSizer.ten,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return commonWidget.passwordTextFieldWithToggle(
                              hintText: AppStrings.currentPassword,
                              controller: passwordController,
                              isObscureText: pswdIsObsecure,
                              leftIcon:
                              AppCommonFeatures.instance.imagesFactory.pass_lock,
                              onToggle: (bool isObscure) {
                                pswdIsObsecure=isObscure;
                                loginCubit.emit(UpdateLoginPasswordVisibilityState(AppStrings.currentPassword,pswdIsObsecure));
                              },
                            );
                          }),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),

                      /// password
                      const SizedBox(
                        height: AppSizer.ten,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return commonWidget.passwordTextFieldWithToggle(
                              hintText: AppStrings.new_password,
                              controller: newPasswordController,
                              isObscureText: newPswdIsObsecure,
                              leftIcon:
                              AppCommonFeatures.instance.imagesFactory.pass_lock,
                              onToggle: (bool isObscure) {
                                newPswdIsObsecure=isObscure;
                                loginCubit.emit(UpdateLoginPasswordVisibilityState(AppStrings.new_password,newPswdIsObsecure));
                              },
                            );
                          }),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),


                      const SizedBox(
                        height: AppSizer.ten,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return commonWidget.passwordTextFieldWithToggle(
                              hintText:
                              AppStrings.confirm_password,
                              controller: confirmPasswordController,
                              isObscureText: confirmIsObsecure,
                              leftIcon:
                              AppCommonFeatures.instance.imagesFactory.pass_lock,
                              onToggle: (bool isObscure) {
                                confirmIsObsecure=isObscure;
                                loginCubit.emit(UpdateLoginPasswordVisibilityState(AppStrings.confirm_password,confirmIsObsecure));
                              },
                            );
                          }),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),
                      CustomButton(label: AppStrings.submit, onPressed: () {
                        AppCommonFeatures.instance.contextInit(context);
                        loginCubit.changePassword(passwordController.text,newPasswordController.text,confirmPasswordController.text);
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
