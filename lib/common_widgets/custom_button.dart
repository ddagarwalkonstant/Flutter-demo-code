import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:flutter/material.dart';

import '../res/fonts/font_family.dart';


class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? color;
  final double? borderRadius;
  final double? height;
  final double? elevation;
  final EdgeInsets? padding;
  final double? loaderSize;
  final FontWeight? fontWeight;
  final Color? loaderColor;
  final double? fontSize;
  final Color? fontColor;
  final bool disabled;
  final bool fullWidth;
  final String? icon;

  const CustomButton({
    required this.label,
    required this.onPressed,
    this.fullWidth =true,
    super.key,
    this.isLoading = false,
    this.color,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.fontColor,
    this.disabled = false,
    this.loaderSize,
    this.loaderColor,
    this.padding, this.height, this.elevation, this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : isLoading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        padding: padding,
        disabledBackgroundColor: AppColor.text_grey_,
        backgroundColor: color ?? AppColor.theme_primary_blue,
        minimumSize: Size(fullWidth?double.infinity:0, height ?? 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: (icon != null) ? true : false,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(icon ?? '',
                height: 18,
                width: 18,
              ),
            ),
          ),
          isLoading
              ? SizedBox(
            height: loaderSize,
            width: loaderSize,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                loaderColor ?? Colors.white,
              ),
            ),
          )
              : Text(
            label,
            style: TextStyle(
              color: fontColor ?? Colors.white,
              fontSize: fontSize ?? 16,
              fontFamily: FontFamily.archivo,
              fontWeight: fontWeight ?? FontWeight.w500,
            ),
          ),
        ],
      )

    );
  }
}
