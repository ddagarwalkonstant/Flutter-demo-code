import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:flutter/material.dart';



class IndicatorPager extends StatelessWidget {

  final int currentIndex;
  final int totalIndex;

  const IndicatorPager({Key? key, required this.currentIndex, required this.totalIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[ListView.builder(
              shrinkWrap: true,
              itemCount: totalIndex,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return _createIndicator(index);
              })],
        ),
      ),
    );
  }

  Widget _createIndicator(index) {
    double w=10;
    double h=10;
    double conW=26;
    Color color=AppColor.grey_4;

    if(currentIndex == index)
    {
      color=AppColor.theme_light_blue;
      h=6;
      w=36;
      conW=36;
    }

    return SizedBox(
      height: 26,
      width: conW,
      child: Center(
        child: AnimatedContainer(
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(5),
          width: w,
          height: h,
          duration: const Duration(milliseconds: 100),
        ),
      ),
    );
  }
}
