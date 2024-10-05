// ignore_for_file: prefer_const_constructors
import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/employee_module/employee_info.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/profile_pic.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

AppBar customAppBar(BuildContext context,
    {bool tabView = false,
    PreferredSizeWidget? tabBarWidget,
    String title = "",
    bool showProfile = true}) {
  final AppbarController appbarController = Get.find<AppbarController>();
  final WebController webController = Get.find<WebController>();
  final BottomBarController bottomBarController =
      Get.find<BottomBarController>();

  final UserTypeController userTypeController = Get.find<UserTypeController>();

  return AppBar(
    backgroundColor: AppColors.primarycolor,
    centerTitle: false,
    bottom: tabView ? tabBarWidget : null,
    title: title.isNotEmpty
        ? Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          )
        : Obx(
            () => Text(
              appbarController.appBarName.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
    iconTheme: const IconThemeData(color: Colors.white),
    actions: UserTypeslist
                .userTypesDetails[userTypeController.usertypeIndex].ouserType
                .toString() ==
            "G"
        ? null
        : showProfile
            ? [
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ProfilePic(
                                  radius: 26.r,
                                  fontSize: 22.sp,
                                ),
                                SizedBox(height: 10.h),
                                // Text(
                                //   "Hi, ${(UserTypeslist.userTypesDetails[userTypeController.usertypeIndex].stuEmpName).toString().capitalizeFirst}",
                                //   style: TextStyle(
                                //       fontSize: 14.sp,
                                //       fontWeight: FontWeight.bold,
                                //       color: AppColors.appbuttonColor),
                                // ),
                                // SizedBox(height: 2.h),
                                // RichText(
                                //   text: TextSpan(
                                //     children: [
                                //       TextSpan(
                                //         text: "UserType : ",
                                //         style: TextStyle(
                                //           fontSize: 12.sp,
                                //           fontWeight: FontWeight.w700,
                                //           color: AppColors.blackcolor,
                                //         ),
                                //       ),
                                //       TextSpan(
                                //         text: UserTypeslist
                                //             .userTypesDetails[userTypeController
                                //                 .usertypeIndex]
                                //             .ouserType
                                //             .toString(),
                                //         style: TextStyle(
                                //             fontSize: 12.sp,
                                //             fontWeight: FontWeight.w500,
                                //             color: AppColors.appbuttonColor),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      if (UserTypeslist
                                                  .userTypesDetails[
                                                      userTypeController
                                                          .usertypeIndex]
                                                  .ouserType ==
                                              'E' &&
                                          EmployeeDetailList
                                              .employeeDetails.isNotEmpty) ...{
                                        TextSpan(
                                          text: attendanceStatus(
                                                  EmployeeDetailList
                                                          .employeeDetails
                                                          .last
                                                          .attStatus ??
                                                      "")
                                              .first,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                            color: () {
                                              if (EmployeeDetailList
                                                      .employeeDetails
                                                      .last
                                                      .attStatus
                                                      .toString() ==
                                                  "P") {
                                                return Color.fromARGB(
                                                    255, 89, 162, 93);
                                              } else {
                                                return AppColors.warningColor;
                                              }
                                            }(),
                                          ),
                                        ),
                                        TextSpan(
                                          text: " | ",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.blackcolor,
                                          ),
                                        ),
                                      },
                                      if (UserTypeslist
                                              .userTypesDetails[
                                                  userTypeController
                                                      .usertypeIndex]
                                              .ouserType ==
                                          'S') ...{
                                        TextSpan(
                                          text: "UserType : ",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.blackcolor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      },
                                      TextSpan(
                                        text: UserTypeslist
                                            .userTypesDetails[userTypeController
                                                .usertypeIndex]
                                            .userName
                                            .toString()
                                            .capitalizeFirst,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.appbuttonColor),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                UserTypeslist
                                            .userTypesDetails[userTypeController
                                                .usertypeIndex]
                                            .ouserType !=
                                        'S'
                                    ? RichText(
                                        text: TextSpan(
                                          children: [
                                            // TextSpan(
                                            //   text: "Shift: ",
                                            //   style: TextStyle(
                                            //     fontSize: 12.sp,
                                            //     fontWeight: FontWeight.w700,
                                            //     color: Colors.black,
                                            //   ),
                                            // ),
                                            TextSpan(
                                              text: EmployeeDetailList
                                                      .employeeDetails
                                                      .last
                                                      .designationName ??
                                                  "Undefined",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.appbuttonColor),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                UserTypeslist
                                            .userTypesDetails[userTypeController
                                                .usertypeIndex]
                                            .ouserType ==
                                        'S'
                                    ? studentProfiledetails()
                                    : Container(),
                                SizedBox(height: 4.h),
                                UserTypeslist
                                            .userTypesDetails[userTypeController
                                                .usertypeIndex]
                                            .ouserType ==
                                        'G'
                                    ? SizedBox()
                                    : OutlinedButton(
                                        onPressed: () {
                                          bottomBarController
                                              .selectedBottomNavIndex.value = 0;
                                          appbarController.appBarName.value =
                                              Constant.schoolName;
                                          Navigator.pop(context);
                                          if (UserTypeslist
                                                  .userTypesDetails[
                                                      userTypeController
                                                          .usertypeIndex]
                                                  .ouserType
                                                  .toString() ==
                                              "S") {
                                            Get.toNamed(
                                                Routes.studentProfileScreen);
                                          } else {
                                            appbarController.appBarName.value =
                                                'Profile';
                                            webController.generateWebUrl(
                                                'Profile.aspx', 'Profile');
                                            webController
                                                .showWebViewScreen.value = true;
                                          }
                                        },
                                        style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.appbuttonColor,
                                            alignment: Alignment.center,
                                            elevation: 0,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 1.h),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.w))),
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
              ]
            : null,
  );
}

List<dynamic> attendanceStatus(String attStatus) {
  switch (attStatus) {
    case "-":
      return ["Not Marked", AppColors.warningColor];
    case "Y":
    case "P":
      return ["Present", AppColors.successColor];
    case "N":
    case "A":
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
          style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.blackcolor,
              fontWeight: FontWeight.w500),
        ),
        TextSpan(
          text: attendanceStatus(
                  StudentDetaillist.studentdetails.first.attStatus ?? "")
              .first,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: attendanceStatus(
                      StudentDetaillist.studentdetails.first.attStatus ?? "")
                  .last),
        ),
      ],
    ),
  );
}
