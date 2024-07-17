import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appRights() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "CampusPro",
        style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xffffc107)),
      ),
      Text(
        " © Campuspro Edtech Pvt. Ltd.",
        style: TextStyle(
            fontSize: 12.sp, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    ],
  );
}
