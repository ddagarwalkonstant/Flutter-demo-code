import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppSizer.dart';
import 'package:flutter/material.dart';

import '../res/fonts/font_family.dart';

class MyProfileListWidget extends StatelessWidget {
  const MyProfileListWidget(
      {Key? key, this.imgOption, this.titleOption, this.valueOption, this.showVerified,this.verifiedVisible, this.showOptional})
      : super(key: key);

  final String? imgOption;
  final String? titleOption;
  final String? valueOption;
  final bool? showVerified;
  final bool? verifiedVisible;
  final bool? showOptional;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 18,
            child: Transform.scale(
              scale: 0.7,
              child: Image.asset(
                imgOption ?? '',
                height: 30,
                width: 30,
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: titleOption ?? '',
                          style: const TextStyle(
                              fontFamily: FontFamily.archivo,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: (showOptional ?? false) ? ' (Optional)' : '',
                          style: const TextStyle(
                              fontFamily: FontFamily.archivo,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColor.text_grey_),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: (verifiedVisible ?? false) ? screenWidth * 0.4 : screenWidth * 0.62,
                    child: Text(
                      valueOption ?? '',
                      style: const TextStyle(
                          fontFamily: FontFamily.archivo,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColor.text_grey_),
                    ),
                  ),
                ],
              )
          ),
           const Spacer(
             flex: 1,
           ),
           Visibility(
             visible: verifiedVisible ?? false,
             child: Container(
               height: 40,
               padding: const EdgeInsets.symmetric(horizontal: 5),
               child: const Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Icon( Icons.check , color:  Colors.green , size: 20,),
                   Text(
                     'Verified',
                     style: TextStyle(
                         fontFamily: FontFamily.archivo,
                         fontWeight: FontWeight.w400,
                         fontSize: 14,
                         color:  Colors.green),
                   ),
                 ],
               ),
             ),
           )
        ],
      ),
    );
  }
}
