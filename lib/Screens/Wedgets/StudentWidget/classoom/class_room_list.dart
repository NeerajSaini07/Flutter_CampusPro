import 'package:campuspro/Screens/Wedgets/StudentWidget/common_text_style.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget classRommDatalist() {
  return ListView.builder(
    itemCount: 5,
    itemBuilder: (context, index) {
      return Card(
        color: AppColors.whitetextcolor,
        margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 8.h),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ("Nazish"),
                    style: AppTextStyles.cardTitle,
                  ),
                  // SizedBox(width:100.w),
                  Text(("Math"),
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16.sp)),

                  SizedBox(width: 120.w),
                  GestureDetector(
                      onTap: () {
                        //showChatScreenDialog(context);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.reply,
                          color: AppColors.appbuttonColor,
                        ),
                      ))
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                "Lorem epsion",
                style: AppTextStyles.cardContent,
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "1-9-2024",
                    style: AppTextStyles.cardDate,
                  ),
                  Container(
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(
                      color: AppColors.appbuttonColor,
                      borderRadius: BorderRadius.circular(14.r),
                      shape: BoxShape.rectangle,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.download,
                          size: 16.r,
                          color: AppColors.whitetextcolor,
                        ),
                        Text(
                          'Download',
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
