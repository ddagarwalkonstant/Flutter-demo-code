import 'package:base_arch_proj/screens/account_screen.dart';
import 'package:base_arch_proj/screens/change_password.dart';
import 'package:base_arch_proj/screens/contact_us.dart';
import 'package:base_arch_proj/screens/forgot_password.dart';
import 'package:base_arch_proj/screens/home/dashboard.dart';
import 'package:base_arch_proj/screens/home/home_screen.dart';
import 'package:base_arch_proj/screens/my_profile.dart';
import 'package:base_arch_proj/screens/notifications_screeen.dart';
import 'package:base_arch_proj/screens/on_boarding.dart';
import 'package:base_arch_proj/screens/reset_password.dart';
import 'package:base_arch_proj/screens/signup.dart';
import 'package:flutter/material.dart';

import '../screens/complete_profile.dart';
import '../screens/login_screen.dart';
import '../screens/static_page_screen.dart';

class RouterNavigator {
  static const String initial = '/';
  static const String onBoarding = '/onBoarding';
  static const String loginScreen = '/LoginScreen';
  static const String signupScreen = '/SignUpScreen';
  static const String forgotPassword = '/ForgotPasswordScreen';
  static const String resetPassword = '/ResetPasswordScreen';
  static const String completeProfile = '/CompleteProfileScreen';
  static const String accountScreen = '/AccountScreen';
  static const String dashBoardScreen = '/DashBoardScreen';
  static const String homeScreen = '/HomeScreen';
  static const String myProfile = '/myProfile';
  static const String notificationScreen = '/NotificationScreen';
  static const String contactUsScreen = '/ContactUsScreen';
  static const String changePasswordScreen = '/ChangePasswordScreen';
  static const String staticPageScreen = '/StaticPageScreen';
  static const String memberDetailScreen = '/MemberDetailScreen';
  static const String selectCaregiverScreen = '/SelectCaregiverScreen';
  static const String assignTaskScreen = '/AssignTaskScreen';
  static const String caregiverDetailScreen = '/CaregiverDetailScreen';
  static const String medicationListScreen = '/MedicationListScreen';
  static const String memberListScreen = '/MemberListScreen';
  static const String addMemberScreen = '/AddMemberScreen';
  static const String addMedicationScreen = '/AddMedicationScreen';
  static const String medicationDetailScreen = '/MedicationDetailScreen';
  static const String addIncidentScreen = '/AddIncidentScreen';
  static const String incidentScreen = '/incidentScreen';
  static const String caregiverScreen = '/CaregiverScreen';
  static const String requestScreen = '/RequestScreen';
  static const String sleepListScreen = '/SleepListScreen';
  static const String addSleepScreen = '/AddSleepScreen';
  static const String foodListScreen = '/FoodListScreen';
  static const String foodDetailsScreen = '/FoodDetailsScreen';
  static const String addFoodScreen = '/AddFoodScreen';
  static const String incidentDetailScreen = '/IncidentDetailScreen';
  static const String specialistsListScreen = '/SpecialistsListScreen';
  static const String addSpecialistsScreen = '/AddSpecialistsScreen';
  static const String fluidListScreen = '/FluidListScreen';
  static const String addFluidsScreen = '/AddFluidsScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signupScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case completeProfile:
        final arguments = settings.arguments as Map<dynamic,dynamic>;
        return MaterialPageRoute(builder: (_) =>  CompleteProfileScreen(arguments));
      case accountScreen:
        return MaterialPageRoute(builder: (_) => const AccountScreen());
      case dashBoardScreen:
        return MaterialPageRoute(builder: (_) => const DashBoardScreen());
      case myProfile:
        return MaterialPageRoute(builder: (_) => const MyProfileScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case contactUsScreen:
        return MaterialPageRoute(builder: (_) => const ContactUsScreen());
      case changePasswordScreen:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case staticPageScreen:
        final arguments = settings.arguments as String;
        return MaterialPageRoute(builder: (_) =>  StaticPageScreen(arguments));


      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
