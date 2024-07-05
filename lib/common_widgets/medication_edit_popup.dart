import 'package:base_arch_proj/common_widgets/custom_button.dart';
import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/screens/home/my_member.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../constant/AppSizer.dart';

class MedicationEditPopup extends StatelessWidget {
  MedicationEditPopup({Key? key, this.descriptionController, required this.onPressedOk, required this.okButtonText, this.okButtonColor, required this.onPressClose, required this.uploadImageTapped, required this.imageUploadWidget}) : super(key: key);


  TextEditingController? descriptionController;
  late Color? okButtonColor;
  late String okButtonText;
  final ValueChanged<void> onPressedOk;
  final VoidCallback onPressClose;
  final VoidCallback uploadImageTapped;
  final Widget imageUploadWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 450,
              width: screenWidth * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppSizer.twenteey,
                  ),
                  /// description
                  commonWidget.titleOfTextField(
                      AppStrings.addNote),
                  const SizedBox(
                    height: AppSizer.ten,
                  ),
                  SizedBox(
                    height: 120,
                    width: screenWidth,
                    child: TextField(
                      maxLines: null, // Set this
                      expands: true,
                      controller: descriptionController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.textFieldBackground,
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColor.grey1),
                            borderRadius: BorderRadius.circular(AppSizer.ten)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColor.grey1),
                            borderRadius: BorderRadius.circular(AppSizer.ten)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColor.theme_primary_blue),
                            borderRadius: BorderRadius.circular(AppSizer.ten)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSizer.ten),
                        hintStyle: const TextStyle(
                            color: AppColor.text_grey_,
                            fontWeight: FontWeight.w400,
                            fontSize: AppSizer.fifteen),
                        hintText: '${AppStrings.enter_} ${AppStrings.description}',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSizer.thirty,
                  ),
                  /// description
                  commonWidget.titleOfTextField(
                      AppStrings.upload_image),
                  const SizedBox(
                    height: AppSizer.twenteey,
                  ),
                  DottedBorder(
                    color: AppColor.text_grey_,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    strokeWidth: 1,
                    dashPattern: const [4, 4],
                    child: imageUploadWidget,
                  ),
                  const SizedBox(
                    height: AppSizer.thirty,
                  ),
                  CustomButton(
                    color: okButtonColor ?? AppColor.theme_light_blue,
                    onPressed: () {
                      onPressedOk(null);
                    },
                    label: okButtonText,
                  )
                ],
              ),
            ),
            Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: onPressClose,
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration:  BoxDecoration(
                        color: AppColor.textFieldBackground,
                        borderRadius: BorderRadius.circular(17.5)
                    ),
                    child: const Icon(Icons.close, color: AppColor.theme_primary_blue, size: 18),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
