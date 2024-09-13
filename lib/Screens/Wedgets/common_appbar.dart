// ignore_for_file: prefer_const_constructors
import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

AppBar customAppBar(BuildContext context, {bool tabView = false}) {
  final AppbarController appbarController = Get.find<AppbarController>();
  final WebController webController = Get.find<WebController>();
  final BottomBarController bottomBarController =
      Get.find<BottomBarController>();

  final UserTypeController userTypeController = Get.find<UserTypeController>();

  return AppBar(
    backgroundColor: AppColors.primarycolor,
    centerTitle: false,
    bottom: tabView
        ? TabBar(
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            indicatorColor: Colors.white,
            unselectedLabelStyle: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: "My Class",
              ),
              Tab(
                text: "My School",
              ),
              Tab(
                text: "Me Only",
              ),
            ],
          )
        : null,
    title: Obx(
      () => Text(
        appbarController.appBarName.toString(),
        style: TextStyle(
          color: Colors.white, // Change to your desired title color
          fontSize: 16.sp, // Change to your desired font size
          fontWeight: FontWeight.bold, // Change to your desired font weight
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    actions: UserTypeslist
                .userTypesDetails[userTypeController.usertypeIndex].ouserType
                .toString() ==
            "G"
        ? null
        : [
            PopupMenuButton(
              offset: Offset(0, kToolbarHeight - 5),
              elevation: 1,
              color: Colors.white,
              padding: EdgeInsets.only(right: 10.w),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              icon: ProfilePic(
                radius: 18.r,
                fontSize: 14.sp,
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 0,
                    enabled: false,
                    labelTextStyle: MaterialStatePropertyAll(
                        TextStyle(color: Colors.black)),
                    padding: EdgeInsets.zero,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          cardColor: Colors.white,
                          shadowColor: Colors.transparent,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfilePic(
                              radius: 26.r,
                              fontSize: 22.sp,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Hi, ${UserTypeslist.userTypesDetails[userTypeController.usertypeIndex].stuEmpName}",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            SizedBox(height: 8.h),
                            UserTypeslist
                                        .userTypesDetails[
                                            userTypeController.usertypeIndex]
                                        .ouserType ==
                                    'S'
                                ? studentProfiledetails()
                                : Container(),
                            SizedBox(height: 8.h),
                            UserTypeslist
                                        .userTypesDetails[
                                            userTypeController.usertypeIndex]
                                        .ouserType ==
                                    'G'
                                ? SizedBox()
                                : OutlinedButton(
                                    onPressed: () {
                                      bottomBarController
                                          .selectedBottomNavIndex.value = 0;
                                      appbarController.appBarName.value =
                                          'Profile';
                                      webController.generateWebUrl(
                                          'Profile.aspx', 'Profile');
                                      webController.showWebViewScreen.value =
                                          true;
                                      Navigator.pop(context);
                                    },
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.appbuttonColor,
                                        alignment: Alignment.center,
                                        elevation: 0,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 1.h),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.w))),
                                    child: Text(
                                      'Manage Profile',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
            ),
          ],
  );
}

List<dynamic> attendanceStatus(String attStatus) {
  switch (attStatus) {
    case "-":
      return ["Not Marked", AppColors.warningColor];
    case "Y":
      return ["Present", AppColors.successColor];
    case "N":
      return ["Absent", AppColors.warningColor];
    case "L":
      return ["On Leave", AppColors.successColor];
    default:
      return ["Not Marked", AppColors.warningColor];
  }
}

Widget studentProfiledetails() {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: "Attendance : ",
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        TextSpan(
          text: attendanceStatus(
                  StudentDetaillist.studentdetails.first.attStatus ?? "")
              .first,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: attendanceStatus(
                      StudentDetaillist.studentdetails.first.attStatus ?? "")
                  .last),
        ),
      ],
    ),
  );
}
