import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.2),
                child: Image.asset(
                  Constant.noInternetIcon,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "You're offline",
                textScaler: TextScaler.noScaling,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: const Color(0xff515157),
                  fontWeight: FontWeight.w700,
                ),
              ),
              CustomeHeight(2.h),
              Text(
                "Check your internet connectivity.",
                textScaler: TextScaler.noScaling,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xff515157),
                  fontWeight: FontWeight.w400,
                ),
              ),
              CustomeHeight(20.h),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appbuttonColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.h),
                  ),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
