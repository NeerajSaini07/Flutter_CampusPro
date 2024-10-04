import 'package:campuspro/Controllers/StudentControllers/student_timetable_controller.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudentTimetableScreen extends StatefulWidget {
  const StudentTimetableScreen({super.key});

  @override
  State<StudentTimetableScreen> createState() => _StudentTimetableScreenState();
}

class _StudentTimetableScreenState extends State<StudentTimetableScreen> {
  final StudenttimetableController timeTableController =
      Get.find<StudenttimetableController>();

  @override
  void initState() {
    super.initState();
    timeTableController.fetchTimetableData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Student Time Table"),
      body: Obx(() {
        if (timeTableController.isLoading.value) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (timeTableController.filteredTimetable.isEmpty) {
          return Center(
              child: Text(
            "No Data found",
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.headingcolor),
          ));
        }

        return ListView(
          padding: EdgeInsets.only(top: 12.h),
          children: timeTableController.filteredTimetable.keys.map((day) {
            return Obx(() {
              bool isExpanded =
                  timeTableController.expandedStates[day] ?? false;

              return GestureDetector(
                onTap: () => timeTableController.toggleExpansion(day),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              day,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              isExpanded
                                  ? Icons.remove_circle_outline
                                  : Icons.add_circle_outline,
                            ),
                          ],
                        ),
                      ),
                      if (isExpanded) ...{
                        Divider(
                          height: 1.h,
                          thickness: 1.h,
                          color: AppColors.textfieldhintstycolor,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        _timeTableListView("Period", "Time", "Subject",
                            textColor: AppColors.blacktextcolor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                        ...timeTableController.filteredTimetable[day]!.map(
                            (period) => _timeTableListView(
                                (period['period_no'] != null &&
                                        period['period_no']!.isNotEmpty)
                                    ? "Period-${period['period_no']}"
                                    : "--",
                                period['period_time'] ?? "--",
                                period['period_name'] ?? "--")),
                      }
                    ],
                  ),
                ),
              );
            });
          }).toList(),
        );
      }),
    );
  }

  Widget _timeTableListView(String content1, String content2, String content3,
      {Color textColor = AppColors.appbuttonColor,
      double? fontSize,
      FontWeight? fontWeight}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w).copyWith(bottom: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              content1,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: fontSize ?? 12.sp,
                  fontWeight: fontWeight ?? FontWeight.normal,
                  color: textColor),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              content2,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: fontSize ?? 12.sp,
                  fontWeight: fontWeight ?? FontWeight.normal,
                  color: textColor),
            ),
          ),
          Expanded(
            flex: 9,
            child: Text(
              content3,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: fontSize ?? 12.sp,
                  fontWeight: fontWeight ?? FontWeight.normal,
                  color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
