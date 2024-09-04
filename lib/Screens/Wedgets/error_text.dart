import 'package:campuspro/Controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

Widget errocommponent({fontsize}) {
  final LoginController loginController = Get.find<LoginController>();
  return Text(
    loginController.formErrorText.value,
    style: TextStyle(
      fontSize: fontsize,
      fontWeight: FontWeight.w500,
      color: Colors.red,
    ),
  );
}

Widget errorWidget({required String errorText}) {
  return Padding(
    padding: EdgeInsets.only(top: 2.h, left: 10.w),
    child: Text(
      errorText,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.red,
      ),
    ),
  );
}
