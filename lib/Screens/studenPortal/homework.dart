// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utilities/colors.dart';
import '../Wedgets/StudentWidget/common_text_style.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildCalendar(),
            Expanded(child: homeworcard()),
          ],
        ),
      ),
    );
  }

  Widget buildCalendar() {
    StudentHomeWorkController studentHomeWorkController =
        Get.find<StudentHomeWorkController>();
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2050, 12, 31),
      focusedDay: DateTime.now(),
      calendarFormat: studentHomeWorkController.calendarFormat,
      //selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onFormatChanged: (format) {
        studentHomeWorkController.calendarFormat = format;
      },
      onPageChanged: (focusedDay) {
        studentHomeWorkController.focuseddate = focusedDay;
      },
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Colors.lightBlue.shade200,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.blue.shade700,
          shape: BoxShape.circle,
        ),
        markerDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

Widget homeworcard() {
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
                "nazish",
                style: AppTextStyles.cardTitle,
              ),
              // SizedBox(width:100.w),
              Text(("math"),
                  style: TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 16.sp)),

              SizedBox(width: 120.w),
              GestureDetector(
                  // onTap: () {
                  //   showChatScreenDialog(context);
                  // },
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

          // Text(
          //   'Subject: $subject',
          //   style: AppTextStyles.cardContent,
          // ),
          SizedBox(height: 12.h),
          Text(
            ";lkjhfghjkl;lkjhgf",
            style: AppTextStyles.cardContent,
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "tesrtgbnsdfghjklsdfghjkdghjkdfb",
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
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
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
}
