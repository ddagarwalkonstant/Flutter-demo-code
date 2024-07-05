import 'dart:io';

import 'package:base_arch_proj/screens/account_screen.dart';
import 'package:base_arch_proj/screens/home/home_screen.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../constant/AppColor.dart';
import '../../constant/AppSizer.dart';
import '../../constant/AppStrings.dart';


class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<StatefulWidget> createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const HomeScreen(),
    const AccountScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6,
            ),
          ],
        ),
        child: bottomBar(),
      ),
      body: _pages.elementAt(_selectedIndex),
    );
  }

  bottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 20,
      backgroundColor: Colors.white,
      selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: AppSizer.tweleve,
          color: AppColor.theme_light_blue),
      unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: AppSizer.tweleve,
          color: AppColor.theme_light_blue),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppCommonFeatures.instance.imagesFactory.home_)),
            label: AppStrings.home,
            activeIcon: ImageIcon(AssetImage(AppCommonFeatures.instance.imagesFactory.home_active))
        ),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppCommonFeatures.instance.imagesFactory.requests)),
            label: AppStrings.requests_,
            activeIcon: ImageIcon(AssetImage(AppCommonFeatures.instance.imagesFactory.requestsActive)
            )
        ),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppCommonFeatures.instance.imagesFactory.account)),
            label: AppStrings.account_,
            activeIcon: ImageIcon(AssetImage(AppCommonFeatures.instance.imagesFactory.account_active)
            )
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: AppColor.theme_primary_blue,
      unselectedItemColor: AppColor.grey_5,
      showUnselectedLabels: true,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  void init() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt > 32) {
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
            .requestPermission();
      }
    }
    // AppCommonFeatures().getLoginUserDetails();
  }
}
