// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:campuspro/Controllers/StudentControllers/transportdetail_controller.dart';
import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';

import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TransportdetailScreen extends StatelessWidget {
  TransportdetailScreen({super.key});
  final TransportdetailController _controller =
      Get.find<TransportdetailController>();

  @override
  Widget build(BuildContext context) {
    AppbarController appbarController = Get.find<AppbarController>();
    BottomBarController bottomBarController = Get.find<BottomBarController>();

    return WillPopScope(
        onWillPop: () async {
          bottomBarController.selectedBottomNavIndex.value = 0;
          appbarController.appBarName.value = Constant.schoolName;
          return true;
        },
        child: Scaffold(
          backgroundColor: AppColors.whitetextcolor,
          appBar: customAppBar(context),
          body: Obx(() {
            if (_controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              final pickupinfo = _controller.pickinfo.isNotEmpty
                  ? _controller.pickinfo.first
                  : null;
              final studentinfo =
                  _controller.info.isNotEmpty ? _controller.info.first : null;
              final dropinfo = _controller.dropinfoo.isNotEmpty
                  ? _controller.dropinfoo.first
                  : null;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (studentinfo != null)
                      Card(
                        color: AppColors.whitetextcolor,
                        margin: EdgeInsets.all(10.r),
                        child: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Student Info',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Admission No.: ${studentinfo.admNo}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Student Name.: ${studentinfo.stName}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Father Name.: ${studentinfo.fatherName}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 8.h),
                            ],
                          ),
                        ),
                      ),
                    if (pickupinfo == null && dropinfo == null)
                      Center(
                        child: Text(
                          'Transport facility not available',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.headingcolor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (pickupinfo != null)
                      Card(
                        color: AppColors.whitetextcolor,
                        margin: EdgeInsets.all(10.r),
                        child: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pick Up Infornmation',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Pick Up NO: ${pickupinfo.routeName}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Bus Reg No: ${pickupinfo.regNo}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Bus No: ${pickupinfo.busNo}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Driver Name & No: ${pickupinfo.driverName}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Driver No: ${pickupinfo.driverMobileNo}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Conductor Name: ${pickupinfo.conductorName}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Conductor Mob No: ${pickupinfo.conductorMobileNo}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 8.h),
                            ],
                          ),
                        ),
                      ),
                    if (dropinfo != null)
                      Card(
                        color: AppColors.whitetextcolor,
                        margin: EdgeInsets.all(10.r),
                        child: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Drop Information',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Drop Route : ${dropinfo.routeName}', // Adjust field as needed
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Bus Reg No: ${dropinfo.busNo}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Driver Name: ${dropinfo.driverName}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Driver Mob No: ${dropinfo.driverMobileNo}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Conductor Name: ${dropinfo.conductorName}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Conductor Mob No: ${dropinfo.conductorMobileNo}',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              // Add more drop info fields here
                              SizedBox(height: 8.h),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }
          }),
        ));
  }
}
