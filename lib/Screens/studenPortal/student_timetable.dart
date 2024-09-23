// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controllers/student_timetable_controller.dart'; // Import the intl package for date formatting

class StudentTimetableScreen extends StatelessWidget {
  StudentTimetableScreen({super.key});
  final StudenttimetableController _controller =
      Get.find<StudenttimetableController>();

  // List of days with date
  final List<DateTime> days = [
    DateTime.now().subtract(Duration(days: 6)),
    DateTime.now().subtract(Duration(days: 5)),
    DateTime.now().subtract(Duration(days: 4)),
    DateTime.now().subtract(Duration(days: 3)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now(),
    DateTime.now().add(Duration(days: 1)),
    DateTime.now().add(Duration(days: 2)),
    DateTime.now().add(Duration(days: 3)),
    DateTime.now().add(Duration(days: 4)),
    DateTime.now().add(Duration(days: 5)),
    DateTime.now().add(Duration(days: 6)),
  ];

  String formatDate(DateTime date) {
    return DateFormat(' d\nEEE').format(date);
  }

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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Horizontal list for days with date
                  SizedBox(
                    height: 60.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: days.length,
                      itemBuilder: (context, index) {
                        final date = days[index];
                        final formattedDate = formatDate(date);
                        bool isSelected =
                            _controller.selectedDay.value == formattedDate;

                        return InkWell(
                          borderRadius: BorderRadius.zero,
                          onTap: () {
                            _controller.selectedDay.value = formattedDate;
                            _controller.filterTimetableByDay(DateFormat('EEEE')
                                .format(date)); // Filter by day
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 5.h),
                            margin: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Expanded(child: Obx(() {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      itemCount: _controller.filteredTimetable.length,
                      itemBuilder: (context, index) {
                        final timetable = _controller.filteredTimetable[index];
                        final classInfo = _controller.classInfo.isNotEmpty
                            ? _controller.classInfo.first
                            : null;
                        final periods = _controller.periods;

                        return Card(
                          color: AppColors.whitetextcolor,
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (classInfo == null)
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Center(
                                      child: Text(
                                        'NO Class',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                if (classInfo != null) ...[
                                  // Day and Class Info
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Day: ${timetable.dayStr}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primarycolor,
                                        ),
                                      ),
                                      Text(
                                        'Class: ${timetable.combName ?? "N/A"}',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primarycolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                      thickness: 1.2,
                                      color: AppColors.textfieldhintstycolor),
                                  // Periods and Subjects
                                  ...List.generate(periods.length,
                                      (periodIndex) {
                                    final period = periods[periodIndex];
                                    String subject = '';

                                    switch (period.periodId) {
                                      case 2:
                                        subject = timetable.period1;
                                        break;
                                      case 3:
                                        subject = timetable.period2;
                                        break;
                                      case 4:
                                        subject = timetable.period3;
                                        break;
                                      case 5:
                                        subject = timetable.period4;
                                        break;
                                      case 7:
                                        subject = timetable.period5;
                                        break;
                                      case 8:
                                        subject = timetable.period6;
                                        break;
                                      case 9:
                                        subject = timetable.period7;
                                        break;
                                    }

                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                period.periodName,
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.blackcolor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            subject.isNotEmpty
                                                ? subject
                                                : 'No Class',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontStyle: subject.isEmpty
                                                  ? FontStyle.italic
                                                  : FontStyle.normal,
                                              color: subject.isEmpty
                                                  ? Colors.grey
                                                  : AppColors.blackcolor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }))
                ],
              );
            }
          }),
        ));
  }
}
