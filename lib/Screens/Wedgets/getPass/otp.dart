// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:campuspro/Controllers/getpassController.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/Wedgets/getPass/idproofwidget.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Widget otpModule(BuildContext context) {
  final GetPassController getPassController = Get.find<GetPassController>();
  return Card(
    color: Colors.white,
    elevation: 5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10, top: 10.h),
          child: Text(
            "OTP sent To: ${getPassController.mobileNo.value} ",
            style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),

        Obx(() => getPassController.showErrorfield.value
            ? Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  getPassController.errorMessage.value,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.red,
                      fontWeight: FontWeight.w500),
                ),
              )
            : SizedBox()),
        // Obx(() {
        //   if (getPassController.showotpErrorfield.value) {
        //     return Text(
        //       getPassController.errorMessage.value,
        //       style: TextStyle(
        //           fontSize: 12.sp,
        //           color: Colors.red,
        //           fontWeight: FontWeight.w500),
        //     );
        //   } else {
        //     return SizedBox();
        //   }
        // }),
        Obx(() => getPassController.showErrorfield.value
            ? CustomeHeight(10.h)
            : SizedBox()),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
          child: PinCodeTextField(
            appContext: context,
            pastedTextStyle: const TextStyle(
              color: AppColors.appbuttonColor,
              fontWeight: FontWeight.bold,
            ),
            length: 6,
            animationType: AnimationType.fade,
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
            onChanged: (value) {
              getPassController.otpValue.value = value;
            },
            cursorColor: Colors.black,
            onCompleted: (value) {
              getPassController.verifyvisitoryOTP();
              // getPassController.showOTPwidget.value = false;
              // getPassController.showvisitoryHistory.value = true;
            },
            animationDuration: const Duration(milliseconds: 300),
            keyboardType: TextInputType.number,
            beforeTextPaste: (text) {
              return true;
            },
            onEditingComplete: () {},
          ),
        ),
        CustomeHeight(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "OR",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.red),
            ),
          ],
        ),
        CustomeHeight(10.h),
        Padding(
          padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 1,
                      backgroundColor: AppColors.appbuttonColor),
                  onPressed: () {
                    idProvebottom(context);
                  },
                  child: Text(
                    "Upload Id Proof",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        )
      ],
    ),
  );
}
