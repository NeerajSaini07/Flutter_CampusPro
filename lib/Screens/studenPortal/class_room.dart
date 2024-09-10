// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:campuspro/Controllers/StudentControllers/classroomcontroller.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/classoom/class_room_list.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Wedgets/StudentWidget/classoom/bottomesheet_dialog.dart';
import '../Wedgets/common_appbar.dart';

class StudentClassroom extends StatelessWidget {
  const StudentClassroom({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentClasssRoomController classsRoomController =
        Get.find<StudentClasssRoomController>();
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showFilterOptions(context);
                  },
                  child: Image.asset("assets/icon/filter.png",
                      fit: BoxFit.fitHeight, width: 20.w, height: 20.h),
                )
              ],
            ),
            CustomeHeight(10.h),
            Expanded(child: classRommDatalist()),
          ],
        ),
      ),
    );
  }
}
