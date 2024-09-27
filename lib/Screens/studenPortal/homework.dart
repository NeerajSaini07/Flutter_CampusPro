// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, deprecated_member_use, avoid_unnecessary_containers

import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/homework/calender_widget.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/homework/homeworklist.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentHomeWorkController studentHomeWorkController =
        Get.find<StudentHomeWorkController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(context, title: "Home Work"),
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
    );
  }
}
