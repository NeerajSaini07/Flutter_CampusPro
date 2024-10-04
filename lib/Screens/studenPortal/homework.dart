// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, deprecated_member_use, avoid_unnecessary_containers

import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/homework/calender_widget.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/homework/homeworklist.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeworkScreen extends StatefulWidget {
  const HomeworkScreen({super.key});

  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  final StudentHomeWorkController studentHomeWorkController =
      Get.find<StudentHomeWorkController>();

  @override
  void initState() {
    super.initState();
    studentHomeWorkController.calendarFormat = CalendarFormat.week.obs;
    studentHomeWorkController.selectedDay = DateTime.now().obs;
    studentHomeWorkController.focuseddate = DateTime.now().obs;
    studentHomeWorkController.markgreenhomedate();
    studentHomeWorkController.gethomeworkbydate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(context, title: "Home Work"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => studentHomeWorkController.loader.value
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Column(
                  children: [
                    buildCalendar(studentHomeWorkController),
                    Expanded(
                        child: homeWorkListdata(studentHomeWorkController)),
                  ],
                ),
        ),
      ),
    );
  }
}
