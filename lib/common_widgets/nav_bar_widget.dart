import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/res/fonts/font_family.dart';
import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? showTrailing;
  final String? trailingTitle;
  final IconData? trailingIcon;
  final VoidCallback? trailingAction;
  final VoidCallback? backAction;


  const NavigationBarWidget(
      {Key? key,
      this.title,
      this.trailingTitle,
      this.trailingAction,
      this.backAction,
      this.showTrailing, this.trailingIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Transform(
          transform: Matrix4.translationValues(0, 0, 0),
          child: Text(title ?? '',
              style: const TextStyle(
                  fontFamily: FontFamily.archivo,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white)),
        ),
        backgroundColor: AppColor.theme_primary_blue,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        titleSpacing: 10.0,
        centerTitle: true,
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: backAction ?? () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: trailingAction,
              child: Visibility(
                visible: showTrailing ?? false,
                child: Row(
                  children: [
                    (trailingIcon != null) ? Icon(
                      trailingIcon,
                      size: 25,
                      color: Colors.white,
                    ) :  const SizedBox(),
                    Text(trailingTitle ?? '',
                        style: const TextStyle(
                            fontFamily: FontFamily.archivo,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white)),
                  ],
                ),
              )),
          const SizedBox(
            width: 10,
          )
        ]);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
