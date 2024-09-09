import 'package:campuspro/Controllers/GetPassController/getpassController.dart';
import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/getpass/gatepass_history_list.dart';
import 'package:campuspro/Screens/getpass/history_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget dashboardButton(BuildContext context) {
  final AppbarController appbarController = Get.find<AppbarController>();
  final GetPassController getPassController = Get.find<GetPassController>();
  return SizedBox(
    width: MediaQuery.sizeOf(context).width,
    child: Column(
      mainAxisSize: MainAxisSize.min, // Adjust according to your content
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            // getPassController.getpassHistory();
            appbarController.appBarName.value = 'Today Getpass';
            Get.back();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const GatePassHistoryListScreen();
            }));
            // shoGetPasslist();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Use primary for background color
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 12.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            "Show Today's Gates Pass History",
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500),
          ),
        ),
        CustomeHeight(16.h),
        ElevatedButton(
          onPressed: () async {
            appbarController.appBarName.value = 'Today Visitor';
            getPassController.showvisitorDetails.value = false;
            await Future.delayed(const Duration(microseconds: 10));
            getPassController.showOTPwidget.value = false;
            getPassController.getVisitorHistory();
            Get.back();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const VisitorHistoryPage();
            }));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Use primary for background color
            padding: EdgeInsets.symmetric(
              horizontal: 34.w,
              vertical: 12.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text("Show Today's Visitor History",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    ),
  );
}
