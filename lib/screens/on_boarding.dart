import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/constant/AppStrings.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:flutter/material.dart';

import '../common_widgets/Indicator.dart';
import '../common_widgets/SliderPage.dart';
import '../constant/AppSizer.dart';
import '../utils/RouterNavigator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  int numberOfPages = 0;
  int currentPage = 0;
  List<OnBoardingModel> slides = [];
  bool showSkip = true;

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void setData() async {
   await AppCommonFeatures.instance.sharedPreferenceHelper.saveIntro(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides.add(OnBoardingModel(imgUrl: AppCommonFeatures.instance.imagesFactory.slide1,introTitle:  'Introduction Screen 2 Title Come Here',introDescription:  "Lorem Ipsum is simply dummy text of the printing and typesetting industry."));
    slides.add(OnBoardingModel(imgUrl: AppCommonFeatures.instance.imagesFactory.slide2,introTitle:  'Introduction Screen2 Title Come Here',introDescription:  "Lorem Ipsum is simply dummy text of the printing and typesetting industry."));
    slides.add(OnBoardingModel(imgUrl: AppCommonFeatures.instance.imagesFactory.slide3,introTitle:  'Introduction Screen2 Title Come Here',introDescription:  "Lorem Ipsum is simply dummy text of the printing and typesetting industry."));
    numberOfPages = slides.length;
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {

      });
    });
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(AppSizer.twenteey),
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Visibility(
                    visible: showSkip,
                    child: GestureDetector(
                      child: Text(AppStrings.skip.toUpperCase(),
                          style: const TextStyle(
                              fontSize: AppSizer.fifteen,
                              color: AppColor.grey_3)),
                      onTap: () async {
                        await Navigator.of(context).pushNamedAndRemoveUntil(RouterNavigator.loginScreen, (Route<dynamic> route) => false);
                      },
                    )),
              ),
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                bottom: 60,
                child: PageView.builder(
                  controller: controller,
                  itemBuilder: (BuildContext context, int index) {
                    OnBoardingModel onBoardingModel = slides[index];
                    return SliderPage(image: onBoardingModel.imgUrl, title: onBoardingModel.introTitle, description: onBoardingModel.introDescription);
                  },
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                      if (currentPage == numberOfPages - 1){
                        showSkip = false;
                      }else{
                        showSkip = true;
                      }
                    });
                  },
                  itemCount: numberOfPages,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: Indicator(
                        controller: controller,
                      ),
                    ),
                    SizedBox(
                      width: AppSizer.fifty,
                      height: AppSizer.fifty,
                      child: RawMaterialButton(
                        onPressed: () async {
                          if(currentPage==slides.length-1){
                            await Navigator.of(context).pushNamedAndRemoveUntil(RouterNavigator.loginScreen, (Route<dynamic> route) => false);
                          }else{
                            controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                          }
                        },
                        elevation: AppSizer.two,
                        fillColor: AppColor.theme_primary_blue,
                        padding: const EdgeInsets.all(AppSizer.ten),
                        shape: const CircleBorder(),
                        child: const Icon(Icons.arrow_forward_outlined,
                            color: Colors.white, size: AppSizer.sixteen),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class OnBoardingModel{
  String? imgUrl;
  String? introTitle;
  String? introDescription;
  OnBoardingModel({this.imgUrl, this.introTitle, this.introDescription});
}