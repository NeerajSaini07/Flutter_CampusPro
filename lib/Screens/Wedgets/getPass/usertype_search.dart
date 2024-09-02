import 'package:campuspro/Controllers/GetPassController/getpassController.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget userType() {
  final GetPassController getPassController = Get.find<GetPassController>();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            getPassController.visitorTyep.value = 'Father';
            getPassController.searchvistorByMobile();
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: AppColors.appbuttonColor,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5),
                Text(
                  'Father',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(width: 10), // Add space between containers
      Expanded(
        child: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            getPassController.visitorTyep.value = 'Mother';
            getPassController.searchvistorByMobile();
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: AppColors.appbuttonColor,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5),
                Text(
                  'Mother',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(width: 8), // Add space between containers
      Expanded(
        child: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            getPassController.visitorTyep.value = 'Other';
            getPassController.searchvistorByMobile();
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: AppColors.appbuttonColor,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                Text(
                  'Other',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
