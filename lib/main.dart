// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:campuspro/Controllers/login_controller.dart';
import 'package:campuspro/Repository/login_repository.dart';
import 'package:campuspro/Screens/create_password_screen.dart';
import 'package:campuspro/Screens/dashboard_screen.dart';
import 'package:campuspro/Screens/forgot_password_screen.dart';
import 'package:campuspro/Screens/login_screen.dart';
import 'package:campuspro/Screens/otp_screen.dart';
import 'package:campuspro/Screens/user_type_screen.dart';

import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import 'Dependency_injection/injection.dart';
import 'Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              Routes.splash: (context) => const SplashScreen(),
              Routes.login: (context) => LoginScreen(),
              Routes.forgotpassword: (context) => ForgotPassword(),
              Routes.userType: (context) => UserTypeScreen(),
              Routes.CreatePassword: (context) => CreatePassword(),
              Routes.opt: (context) => OTPScreen(),
              Routes.dashboard: (context) => DashBoradScreen(),
            },
            home: SplashScreen());
      },
    );
  }
}
