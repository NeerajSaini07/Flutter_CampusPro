// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Wedgets/login_screen_card.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double customHeight = ScreenUtil().screenHeight > 800 ? 550.h : 550.h;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.loginscafoldcoolr,
        body: SingleChildScrollView(
          child: SizedBox(
            height:
                MediaQuery.of(context).size.height, // Adjust height as needed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      height: customHeight,
                      width: double.infinity,
                      child: loginFormCard(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
