// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/forgotpassword_controller.dart';
import 'package:campuspro/Screens/Wedgets/app_rights.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'Wedgets/common_button.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginscafoldcoolr,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomeHeight(100.h),
              Text(
                "Password Reset",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomeHeight(5.h),
              headingcomponent(),
              CustomeHeight(70.h),
              Center(
                child: Card(
                  color: Colors.white,
                  child: otpBox(context),
                ),
              ),
              CustomeHeight(100.h),
              appRights(),
            ],
          ),
        ),
      ),
    );
  }

// *******************************  Component ****************
  Widget headingcomponent() {
    final ForgotPasswordController forgotPasswordController =
        Get.find<ForgotPasswordController>();
    return Text.rich(
      TextSpan(
        text: "A verification code has been sent to your mobile: ",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w200,
          color: Colors.white,
        ),
        children: <TextSpan>[
          TextSpan(
            text: forgotPasswordController.mobileForForgotPass.value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget otpBox(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          children: [
            PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: AppColors.appbuttonColor,
                fontWeight: FontWeight.bold,
              ),
              length: 6,
              animationType: AnimationType.fade,
              validator: (v) {},
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                activeColor: AppColors.appbuttonColor,
                disabledColor: AppColors.blackcolor,
                inactiveColor: Colors.black,
                selectedColor: AppColors.loginscafoldcoolr,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              keyboardType: TextInputType.number,
              beforeTextPaste: (text) {
                return true;
              },
            ),
            appCommonbutton(
                onpressed: () {
                  Get.toNamed(Routes.CreatePassword);
                },
                text: "Very OTP"),
          ],
        ),
      ),
    );
  }

  // ********************************************* end component****************
}
