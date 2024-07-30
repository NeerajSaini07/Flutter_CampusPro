// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:campuspro/Screens/Wedgets/no_internet_widget.dart';
import 'package:campuspro/Screens/bus_tracker_screen.dart';
import 'package:campuspro/Screens/create_password_screen.dart';
import 'package:campuspro/Screens/dashboard_screen.dart';
import 'package:campuspro/Screens/forgot_password_screen.dart';
import 'package:campuspro/Screens/getpass/visitor_history.dart';
import 'package:campuspro/Screens/help_and_support_screen.dart';
import 'package:campuspro/Screens/login_screen.dart';
import 'package:campuspro/Screens/otp_screen.dart';
import 'package:campuspro/Screens/user_type_screen.dart';
import 'package:campuspro/Services/InternetConnection/internet_connectivity.dart';
import 'package:campuspro/Services/notificationService/notification_service.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:campuspro/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Dependency_injection/injection.dart';
import 'Screens/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.testMode = true;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize NotificationService
  NotificationService notificationService = NotificationService();
  await notificationService.initialize();
  initializeNotification();

  DependencyInjection.init();
  Get.put(ConnectivityService());
  // final token = await FirebaseMessaging.instance.getToken();
  // log("FCM Token generated => $token");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            theme: ThemeData(
                useMaterial3: true,
                textTheme: GoogleFonts.latoTextTheme(textTheme)),
            debugShowCheckedModeBanner: false,
            initialBinding: BindingsBuilder(() {
              Get.put(ConnectivityService());
            }),
            navigatorKey: navigatorKey,
            routes: {
              Routes.splash: (context) => const SplashScreen(),
              Routes.login: (context) => LoginScreen(),
              Routes.forgotpassword: (context) => ForgotPassword(),
              Routes.userType: (context) => UserTypeScreen(),
              Routes.CreatePassword: (context) => CreatePassword(),
              Routes.opt: (context) => OTPScreen(),
              Routes.webview: (context) => WebViewScreen(),
              Routes.noInternet: (context) => NoInternetScreen(),
              Routes.visitorHistory: (context) => GetPassvisitorHistory(),
              Routes.busTrackerScreen: (context) => BusTrackerScreen(),
              Routes.helpAndSupportScreen: (context) => HelpAndSupportScreen(),
            },
            home: SplashScreen());
      },
    );
  }
}
