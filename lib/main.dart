import 'dart:io';
import 'dart:ui';

import 'package:base_arch_proj/constant/AppColor.dart';
import 'package:base_arch_proj/data/modified_network/api_base_helper.dart';
import 'package:base_arch_proj/l10n/app_localizations.dart';
import 'package:base_arch_proj/models/LoginModel.dart';
import 'package:base_arch_proj/res/fonts/font_family.dart';
import 'package:base_arch_proj/services/navigator_service.dart';
import 'package:base_arch_proj/services/push_notification_service.dart';
import 'package:base_arch_proj/utils/AppCommonFeatures.dart';
import 'package:base_arch_proj/utils/RouterNavigator.dart';
import 'package:base_arch_proj/utils/debug_utils/debug_utils.dart';
import 'package:base_arch_proj/utils/notificationsHandling.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';

// Entry point for background messaging handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationHandle notificationHandle = NotificationHandle();
  await notificationHandle.setupFlutterNotifications();
  notificationHandle.showFlutterNotification(message);
  DebugUtils.showLog('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set API environment (e.g., development, production)
  ApiBaseHelper.instance.setEnvironment(Environment.dev);

  // Initialize Firebase
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }

  // Initialize push notifications
  await Future.delayed(const Duration(milliseconds: 500), () async {
    await PushNotificationService().initialise();
  });

  // Handle Flutter errors using Firebase Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Handle platform-specific errors using Firebase Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Enable Crashlytics data collection
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  // Enable auto initialization of Firebase Messaging
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  // Initialize notification handling
  NotificationHandle notificationHandle = NotificationHandle();
  await notificationHandle.setupFlutterNotifications();

  // Handle initial message when app is started from terminated state
  FirebaseMessaging.instance.getInitialMessage().then((message) async {
    if (message != null) {
      notificationHandle.showFlutterNotification(message);
    }
  });

  // Set background message handler
  FirebaseMessaging.onBackgroundMessage((_firebaseMessagingBackgroundHandler));

  // Set preferred orientations for the app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Run the application
  runApp(const MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Care',
      debugShowCheckedModeBanner: false,
      // Set app locale from AppCommonFeatures instance
      locale: AppCommonFeatures.instance.appLocalization.locale,
      // Generate routes using RouterNavigator class
      onGenerateRoute: RouterNavigator.generateRoute,
      // Set navigation key for navigator service
      navigatorKey: NavigationService.navigatorKey,
      // Set initial route using RouterNavigator class
      initialRoute: RouterNavigator.initial,
      // Localizations delegates for internationalization
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Supported locales from AppCommonFeatures instance
      supportedLocales: AppCommonFeatures.instance.appLocalization.all,
      // Theme data for the app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // Enable Material 3
        fontFamily: FontFamily.archivo, // Set default font family
      ),
      // Set home page to MyHomePage
      home: const MyHomePage(),
    );
  }
}

// Home page widget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// State class for MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  var _showIntro = false;

  @override
  void initState() {
    super.initState();

    // Delayed initialization after 6 seconds
    Future.delayed(const Duration(seconds: 6), () {
      init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.theme_primary_blue,
        child: Center(
          child: Image.asset(
            AppCommonFeatures.instance.imagesFactory.careAnimation,
            width: 250,
            height: 260,
          ),
        ),
      ),
    );
  }

  // Initialization method
  init() async {
    // Check if intro has been shown
    _showIntro = await AppCommonFeatures.instance.sharedPreferenceHelper.isIntroShown ?? false;
    LoginModel? loginModel;
    try {
      // Retrieve login user details from shared preferences
      loginModel = await AppCommonFeatures.instance.sharedPreferenceHelper.getLoginUserDetails();
    } catch (e) {
      debugPrint(e.toString());
    }

    // Navigate based on app state
    if (_showIntro == false) {
      // Navigate to on boarding screen if intro has not been shown
      Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamedAndRemoveUntil(
        RouterNavigator.onBoarding,
            (Route<dynamic> route) => false,
      );
    } else if (loginModel != null) {
      // Navigate based on user profile completion
      if (loginModel.data!.user!.isShowComplete!) {
        // Navigate to dashboard screen if user profile is complete
        Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamedAndRemoveUntil(
          RouterNavigator.dashBoardScreen,
              (Route<dynamic> route) => false,
        );
      } else {
        // Navigate to complete profile screen if user profile is not complete
        Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamedAndRemoveUntil(
          RouterNavigator.completeProfile,
              (Route<dynamic> route) => false,
          arguments: {},
        );
      }
    } else {
      // Navigate to login screen if no user is logged in
      Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamedAndRemoveUntil(
        RouterNavigator.loginScreen,
            (Route<dynamic> route) => false,
      );
    }
  }
}
