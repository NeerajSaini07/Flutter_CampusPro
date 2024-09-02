import 'package:campuspro/Controllers/login_controller.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget appCommonbutton({@required onpressed, text, disable = false}) {
  final LoginController loginController = Get.find();
  return Obx(
    () => SizedBox(
      height: 44.h,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor:
                  disable ? Colors.grey[400] : AppColors.appbuttonColor,
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.w))),
          onPressed: onpressed,
          child: loginController.loginLoader.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  text,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )),
    ),
  );
}
