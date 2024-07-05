import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constant/AppSizer.dart';
import '../res/fonts/font_family.dart';
import '../utils/AppCommonFeatures.dart';


class MemberDetailWidget extends StatelessWidget {

  const MemberDetailWidget({Key? key, this.userImage, this.userName, this.userDOB,
    this.userRelation, this.userGender, this.showMoreIcon, this.onPressedOption}) : super(key: key);

  final String? userImage;
  final String? userName;
  final String? userDOB;
  final String? userRelation;
  final String? userGender;
  final bool? showMoreIcon;
  final VoidCallback? onPressedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.textFieldBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSizer.fourty,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: Transform.scale(
                      scale: 1,
                      child: CachedNetworkImage(
                        imageUrl: userImage ?? '',
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover),
                              ),
                            ),
                        placeholder: (context, url) => const CircularProgressIndicator(color: AppColor.grey1),
                        errorWidget: (context, url, error) => Image.asset(AppCommonFeatures.instance.imagesFactory.user ?? '', fit: BoxFit.cover, height: 22, width: 22,),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      userName ?? '',
                      style: const TextStyle(
                          fontFamily: FontFamily.archivo,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: AppColor.text_black_
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Visibility(
                    visible: showMoreIcon ?? false,
                    child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: onPressedOption,
                        child: Image.asset(AppCommonFeatures.instance.imagesFactory.moreIcon, height: 25, width: 50, color: AppColor.text_black_,)
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// DOB
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('DOB',
                            style: TextStyle(
                                fontFamily: FontFamily.archivo,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColor.text_grey_
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                          ),
                          Text(
                            userDOB ?? '',
                            style: const TextStyle(
                                fontFamily: FontFamily.archivo,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColor.text_black_
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                          ),
                        ],
                      )
                    ),
                  ),
                  /// Relation
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.relation,
                              style: TextStyle(
                                  fontFamily: FontFamily.archivo,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: AppColor.text_grey_
                              ),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                            ),
                            Text(
                              userRelation ?? '',
                              style: const TextStyle(
                                  fontFamily: FontFamily.archivo,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: AppColor.text_black_
                              ),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                            ),
                          ],
                        )
                    ),
                  ),

                  /// Gender
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.gender,
                              style: TextStyle(
                                  fontFamily: FontFamily.archivo,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: AppColor.text_grey_
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              userGender ?? '',
                              style: const TextStyle(
                                  fontFamily: FontFamily.archivo,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: AppColor.text_black_
                              ),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                            ),
                          ],
                        )

                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
