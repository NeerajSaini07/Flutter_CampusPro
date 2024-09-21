// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, deprecated_member_use, avoid_unnecessary_containers

import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';
import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/homework/homeworklist.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppbarController appbarController = Get.find<AppbarController>();
    BottomBarController bottomBarController = Get.find<BottomBarController>();
    final StudentHomeWorkController studentHomeWorkController =
        Get.find<StudentHomeWorkController>();
    return WillPopScope(
      onWillPop: () async {
        bottomBarController.selectedBottomNavIndex.value = 0;
        appbarController.appBarName.value = Constant.schoolName;
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              buildCalendar(studentHomeWorkController),
              Expanded(
                child: Obx(() {
                  studentHomeWorkController.tableRefresh.value;
                  return homeWorkListdata(studentHomeWorkController);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCalendar(StudentHomeWorkController studentHomeWorkController) {
    return Obx(
      () {
        return TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2050, 12, 31),
          focusedDay: studentHomeWorkController.focuseddate.value,
          calendarFormat: studentHomeWorkController.calendarFormat.value,
          selectedDayPredicate: (day) {
            studentHomeWorkController.gethomeworkbydate();
            return isSameDay(studentHomeWorkController.selectedDay.value, day);
          },
          onFormatChanged: (format) {
            studentHomeWorkController.calendarFormat.value = format;
          },
          eventLoader: (day) {
            return studentHomeWorkController.homeworkdatelist.where((event) {
              if (event.date != null) {
                try {
                  final dateParts = event.date!.split(' , ');
                  if (dateParts.length == 2) {
                    final monthDayParts = dateParts[0].split(' ');
                    final year = int.parse(dateParts[1].trim());
                    final month = int.parse(monthDayParts[0].trim());
                    final dayOfMonth = int.parse(monthDayParts[1].trim());

                    DateTime eventDate = DateTime(year, month, dayOfMonth);

                    return eventDate.year == day.year &&
                        eventDate.month == day.month &&
                        eventDate.day == day.day;
                  } else {
                    return false;
                  }
                } catch (e) {
                  return false;
                }
              }
              return false;
            }).toList();
          },
          onPageChanged: (focusedDay) {
            studentHomeWorkController.focuseddate.value = focusedDay;
          },
          onDaySelected: (date, focusedDay) {
            if (!isSameDay(studentHomeWorkController.selectedDay.value, date)) {
              studentHomeWorkController.gethomeworkbydate();
              studentHomeWorkController.tableRefresh.value =
                  !studentHomeWorkController.tableRefresh.value;
              studentHomeWorkController.selectedDay.value = date;
              studentHomeWorkController.focuseddate.value = focusedDay;
            }
          },
          calendarStyle: CalendarStyle(
            markersMaxCount: 1,
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
      },
    );
  }
}
