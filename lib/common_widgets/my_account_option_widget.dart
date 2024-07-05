import 'package:base_arch_proj/constant/AppSizer.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../res/fonts/font_family.dart';

class MyAccountOptionWidget extends StatelessWidget {

  late String imgOption;
  late String titleOption;
  final VoidCallback? onPressedOption;
  final ValueChanged<bool>? notificationChanged;
  late bool? isNotificationOn;



  MyAccountOptionWidget({super.key, required this.imgOption,required this.titleOption, required this.onPressedOption,this.isNotificationOn, this.notificationChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 64,
      width: screenWidth,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onPressedOption,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imgOption,
              height: 20,
              width: 20,
              color: Colors.black45,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                titleOption,
                style: const TextStyle(
                    fontFamily: FontFamily.archivo,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black),
              )
            ),
            const Spacer(
              flex: 3,
            ),
            Visibility(
              visible: titleOption != AppStrings.pushNotification,
              child: const SizedBox(
                width: 60,
                height: 60,
                child: Icon(Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.black45),
              ),
            ),
            Visibility(
              visible: titleOption == AppStrings.pushNotification,
              child: CupertinoSwitch(
                activeColor: Colors.green,
                value: (isNotificationOn ?? false),
                onChanged: notificationChanged,
              ),
            )
          ],
        ),
      ),
    );
  }
}
