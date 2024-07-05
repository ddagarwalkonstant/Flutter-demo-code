import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:flutter/material.dart';

import '../constant/AppSizer.dart';
import '../res/fonts/font_family.dart';
import '../utils/AppCommonFeatures.dart';


class SleepDetailWidget extends StatelessWidget {

  final String? sleepTime;
  final String? wakeUpTime;
  final String? strBedTime;
  final String? strNote;
  final String? strAddedBy;
  final VoidCallback onPressedOption;

  const SleepDetailWidget({Key? key, this.sleepTime, this.wakeUpTime, this.strBedTime, this.strNote, required this.onPressedOption, this.strAddedBy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(AppSizer.fifteen),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.textFieldBackground
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  const Text(
                     AppStrings.sleepTime,
                    style: TextStyle(
                        fontFamily: FontFamily.archivo,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColor.text_grey_
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    sleepTime ?? '',
                    style: const TextStyle(
                        fontFamily: FontFamily.archivo,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  )
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              Column(
                children: [
                  const Text(
                    AppStrings.wakeUpTime,
                    style: TextStyle(
                        fontFamily: FontFamily.archivo,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColor.text_grey_
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                  ),
                  Text(
                    wakeUpTime ?? '',
                    style: const TextStyle(
                        fontFamily: FontFamily.archivo,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  )
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              Visibility(
                visible: true,
                child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: onPressedOption,
                    child: Image.asset(AppCommonFeatures.instance.imagesFactory.moreIcon, height: 22, width: 50, color: AppColor.text_black_,)
                ),
              )
            ],
          ),
          const SizedBox(
            height: AppSizer.fifteen,
          ),
        /// bed time
          Container(
            width: screenWidth,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: AppSizer.ten),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: Row(
              children: [
                Image.asset(AppCommonFeatures().imagesFactory.sleepIcon, height: 25, width: 25,),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  AppStrings.bedTime,
                  style: TextStyle(
                      fontFamily: FontFamily.archivo,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColor.text_grey_
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  strBedTime ?? '',
                  style: const TextStyle(
                      fontFamily: FontFamily.archivo,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                )
              ],
            ),
          ),
          const SizedBox(
            height: AppSizer.fifteen,
          ),
          /// add note
          Container(
            width: screenWidth,
            padding: const EdgeInsets.all(AppSizer.fifteen),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.addNoteOptional,
                  style: TextStyle(
                      fontFamily: FontFamily.archivo,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColor.text_grey_
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                ),
                Text(
                  strNote ?? '',
                  style: const TextStyle(
                      fontFamily: FontFamily.archivo,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
          ),
          const SizedBox(
            height: AppSizer.eight,
          ),
          Text(
            strAddedBy ?? '',
            style: const TextStyle(
                fontFamily: FontFamily.archivo,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColor.text_grey_
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: AppSizer.five,
          ),
        ],
      ),
    );
  }

}
