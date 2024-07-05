import 'package:flutter/material.dart';

import '../bloc/login/login_cubit.dart';
import '../common_widgets/social_media_buttons.dart';
import '../constant/AppSizer.dart';
import '../constant/AppStrings.dart';
import '../utils/AppCommonFeatures.dart';


class SocialLoginWidget extends StatelessWidget {
  LoginCubit loginCubit;
  String? fromWhere;
  SocialLoginWidget(this.loginCubit, this.fromWhere, {super.key});



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialMediaButtons(
          strTitle: fromWhere != 'SignUpScreen' ? AppStrings.sign_with_google : AppStrings.register_with_google,
          imgName: AppCommonFeatures.instance.imagesFactory.google,
          onPressed: () async{
            AppCommonFeatures.instance.contextInit(context);
            final user = await loginCubit.signInWithGoogle();
            if (user != null) {
            await  loginCubit.SocialLoginApiRequest(
                'GOOGLE',
                user.providerData.first.displayName ?? '',
                user.providerData.first.email!,
                user.providerData.first.uid!
              );
            }
          },
        ),
        const SizedBox(
          height: AppSizer.fifteen,
        ),
        SocialMediaButtons(
          strTitle: fromWhere != 'SignUpScreen' ? AppStrings.sign_with_apple : AppStrings.register_with_apple,
          imgName: AppCommonFeatures.instance.imagesFactory.Apple,
          onPressed: () async{
            AppCommonFeatures.instance.contextInit(context);
            final user = await loginCubit.signInWithApple();
            if (user != null) {
             await loginCubit.SocialLoginApiRequest(
                  'APPLE',
                  user.providerData.first.displayName ?? '',
                  user.providerData.first.email!,
                  user.providerData.first.uid!
              );

            }
          },
        ),
        const SizedBox(
          height: AppSizer.fifteen,
        ),
        SocialMediaButtons(
          strTitle: fromWhere != 'SignUpScreen' ?  AppStrings.sign_with_facebook : AppStrings.register_with_facebook,
          imgName: AppCommonFeatures.instance.imagesFactory.facebook,
          onPressed: () async{
            AppCommonFeatures.instance.contextInit(context);
            final user = await loginCubit.signInWithFacebook();
            if (user != null) {
            await  loginCubit.SocialLoginApiRequest(
                  'FACEBOOK',
                  user.providerData.first.displayName! ?? '',
                  user.providerData.first.email! ?? '',
                  user.providerData.first.uid!
              );
            }
          },
        ),
      ],
    );
  }
}
