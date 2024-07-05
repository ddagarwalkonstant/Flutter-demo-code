import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppSizer.dart';
import 'package:base_arch_proj/res/fonts/font_family.dart';
import 'package:flutter/material.dart';

import '../utils/commonWidget.dart';

class SliderPage extends StatelessWidget {

  final String? image;
  final String? title;
  final String? description;
  CommonWidget commonWidget = CommonWidget();

  SliderPage({super.key, this.image, this.title, this.description});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset(image ?? '', width: 300, height: 300,),
            const SizedBox(height: AppSizer.fifty,),
            Text(title ?? '',
                style: const TextStyle(
                    color: AppColor.text_black_,
                    fontSize: AppSizer.thirty,
                    fontFamily: FontFamily.archivo,
                    fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizer.ten,),
            commonWidget.simpleText_body_text_color(description ?? ''),

          ],
        ),
      ),
    );
  }
}