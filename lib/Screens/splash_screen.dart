// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/splash_controller.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashScreenController splashScreenController =
        Get.find<SplashScreenController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashScreenController.redirectslash_screen();
    });
    return Scaffold(
      backgroundColor: Color(0xffe9e9e9),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: Image.asset(Constant.applogoImage),
                // child: Text("schoolImage"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Text("Welcome To ${Constant.schoolName}",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.splashScreenHeading,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
