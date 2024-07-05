import 'package:base_arch_proj/constant/AppSizer.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:base_arch_proj/utils/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login/login_cubit.dart';
import '../common_widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final CommonWidget commonWidget = CommonWidget();
  TextEditingController emailController =
  TextEditingController();
  final LoginCubit loginCubit = LoginCubit();


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
                  if(state is ForgotPasswordStateLoaded){
                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizer.fifteen),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonWidget.titleMultiColor('${AppStrings.forgot_} ', '${AppStrings.password}?'),
                      const SizedBox(height: 15),
                      commonWidget.title('Don’t worry! It happens, Please enter the email address associated with your account.'),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),
                      commonWidget.titleOfTextField("${AppStrings.email} ${AppStrings.id_}"),
                      const SizedBox(
                        height: AppSizer.ten,
                      ),
                      commonWidget.textfield('${AppStrings.enter_} ${AppStrings.email}', emailController, false, keyboardType: TextInputType.emailAddress, leftIcon: AppCommonFeatures.instance.imagesFactory.email),
                      const SizedBox(
                        height: AppSizer.thirty,
                      ),
                      CustomButton(label: AppStrings.submit, onPressed: () {
                       AppCommonFeatures.instance.contextInit(context);
                         loginCubit.forgotPasswordFetchCubit(emailController.text);
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
