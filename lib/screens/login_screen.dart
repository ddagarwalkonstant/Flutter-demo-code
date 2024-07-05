import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppSizer.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/res/fonts/font_family.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:base_arch_proj/utils/RouterNavigator.dart';
import 'package:base_arch_proj/utils/commonWidget.dart';
import 'package:base_arch_proj/utils/debug_utils/debug_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../bloc/login/login_cubit.dart';
import '../common_widgets/custom_button.dart';
import 'SocialLoginWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final CommonWidget commonWidget = CommonWidget();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final LoginCubit loginCubit = LoginCubit();
  var passwordIsObscure = true;
  late final FirebaseMessaging _messaging;

  @override
  void initState() {
    super.initState();
    // Initialize necessary features when the screen initializes
    init();
    // Register for notifications after the first frame is rendered
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _registerNotification();
    });
  }

  // Initialize any necessary data or services
  void init() async {
    AppCommonFeatures.instance.contextInit(context);
  }

  @override
  void dispose() {
    // Clean up controllers when the screen is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Register for push notifications
  void _registerNotification() async {
    // 1. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 2. Request permission for notifications (iOS specific)
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    // 3. Request permission to use notifications (Android specific)
    Map<Permission, PermissionStatus> statuses = await [
      Permission.notification,
    ].request();

    // Handle authorization status for notifications
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      DebugUtils.showLog('User granted permission');
      // TODO: Handle received notifications
    } else {
      DebugUtils.showLog('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizer.fifteen), // Use AppSizer constants for padding
          child: BlocProvider(
            create: (_) => loginCubit,
            child: BlocListener<LoginCubit, LoginState>(
              listener: (BuildContext context, state) {
                // Handle state changes in the login cubit
                if (state is UpdateLoginPasswordVisibilityState) {
                  passwordIsObscure = state.isObsecure;
                } else if (state is LoginStateLoaded) {
                  if (state.loginModel.data!.user!.isShowComplete!) {
                    // Navigate to the dashboard if user profile is complete
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      RouterNavigator.dashBoardScreen,
                          (Route<dynamic> route) => false,
                    );
                  } else {
                    // Navigate to complete profile if user profile is not complete
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      RouterNavigator.completeProfile,
                      arguments: {},
                          (Route<dynamic> route) => false,
                    );
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizer.fifteen), // Use AppSizer constants for horizontal padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title section
                    commonWidget.titleMultiColor(
                      '${AppStrings.welcome} ${AppStrings.to_} ',
                      '${AppStrings.appName}.',
                    ),
                    const SizedBox(height: 15),
                    commonWidget.title(
                      'Get ready to unlock a world of possibilities - log in to your account now!',
                    ),
                    const SizedBox(height: AppSizer.thirty),
                    // Email field
                    commonWidget.titleOfTextField(
                      "${AppStrings.email} ${AppStrings.id_}",
                    ),
                    const SizedBox(height: AppSizer.ten),
                    commonWidget.textfield(
                      '${AppStrings.enter_} ${AppStrings.email}',
                      emailController,
                      false,
                      keyboardType: TextInputType.emailAddress,
                      leftIcon: AppCommonFeatures.instance.imagesFactory.email,
                    ),
                    const SizedBox(height: AppSizer.thirty),
                    // Password field
                    commonWidget.titleOfTextField(AppStrings.password),
                    const SizedBox(height: AppSizer.ten),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return commonWidget.passwordTextFieldWithToggle(
                          hintText: '${AppStrings.enter_} ${AppStrings.password}',
                          controller: passwordController,
                          isObscureText: passwordIsObscure,
                          leftIcon: AppCommonFeatures.instance.imagesFactory.pass_lock,
                          onToggle: (bool isObscure) {
                            passwordIsObscure = isObscure;
                            loginCubit.emit(
                              UpdateLoginPasswordVisibilityState(
                                "password",
                                passwordIsObscure,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: AppSizer.thirty),
                    // Forgot password link
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.of(context)
                              .pushNamed(RouterNavigator.forgotPassword);
                        },
                        child: const Text(
                          AppStrings.forgot_password,
                          style: TextStyle(
                            color: AppColor.theme_primary_blue,
                            fontSize: AppSizer.sixteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizer.thirty),
                    // Login button
                    CustomButton(
                      label: AppStrings.login,
                      onPressed: () {
                        AppCommonFeatures.instance.contextInit(context);
                        loginCubit.loginFetchCubit(
                          emailController.text,
                          passwordController.text,
                        );
                      },
                    ),
                    const SizedBox(height: AppSizer.thirty),
                    // Divider with 'OR'
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: AppSizer.one,
                            color: AppColor.text_grey_.withOpacity(0.5),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: AppSizer.ten,
                            right: AppSizer.ten,
                          ),
                          child: CommonWidget().simpleText_body_text_color(
                            AppStrings.or_,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: AppSizer.one,
                            color: AppColor.text_grey_.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizer.thirty),
                    // Social login buttons
                    SocialLoginWidget(loginCubit, 'Login'),
                    const SizedBox(height: AppSizer.fifty),
                    // Register link
                    Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: AppStrings.dont_account,
                              style: TextStyle(
                                fontSize: AppSizer.sixteen,
                                fontFamily: FontFamily.archivo,
                                fontWeight: FontWeight.w500,
                                color: AppColor.text_grey_,
                              ),
                            ),
                            TextSpan(
                              text: AppStrings.registerNow,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await Navigator.of(context)
                                      .pushNamed(RouterNavigator.signupScreen);
                                },
                              style: const TextStyle(
                                fontSize: AppSizer.sixteen,
                                fontFamily: FontFamily.archivo,
                                fontWeight: FontWeight.w600,
                                color: AppColor.theme_primary_blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizer.thirty),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
