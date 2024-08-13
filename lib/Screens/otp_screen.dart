// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/forgotpassword_controller.dart';
import 'package:campuspro/Screens/Wedgets/app_rights.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/Wedgets/error_commponet.dart';
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
    final ForgotPasswordController forgotPasswordController =
        Get.find<ForgotPasswordController>();
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
              headingcomponent(forgotPasswordController),
              CustomeHeight(70.h),
              Center(
                child: Card(
                  color: Colors.white,
                  child: otpBox(context, forgotPasswordController),
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
  Widget headingcomponent(ForgotPasswordController forgotPasswordController) {
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

  Widget otpBox(
      BuildContext context, ForgotPasswordController forgotPasswordController) {
    final formKey = GlobalKey<FormState>();

    return SizedBox(
      width: double.infinity,
      height: 240.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return forgotPasswordController.showerrortext.value
                    ? errocommponent(
                        fontsize: 12.sp,
                        errorText: forgotPasswordController.otperrorText)
                    : CustomeHeight(10.h);
              }),
              PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: AppColors.appbuttonColor,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                animationType: AnimationType.fade,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return "Please fill all the boxes";
                  }
                  return null;
                },
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

                onCompleted: (value) {
                  forgotPasswordController.otpValue.value = value;
                },
                //controller: forgotPasswordController.otpController,
                animationDuration: const Duration(milliseconds: 300),
                keyboardType: TextInputType.number,
                beforeTextPaste: (text) {
                  return true;
                },
              ),
              CustomeHeight(10.h),
              appCommonbutton(
                  onpressed: () {
                    if (formKey.currentState!.validate()) {
                      forgotPasswordController.verifyOTP();
                    }
                  },
                  text: "Verify OTP"),
              CustomeHeight(8.h),
              Align(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () {
                      Get.offAllNamed(Routes.login);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            " Login ",
                            style: TextStyle(
                                color: AppColors.primarytextcolor,
                                fontSize: 16.sp,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primarytextcolor,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ********************************************* end component****************
}
