// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:campuspro/Controllers/StudentControllers/classroomcontroller.dart';
import 'package:campuspro/Modal/student_module/class_room_teacher_filter.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/classoom/class_room_list.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Wedgets/common_appbar.dart';

class StudentClassroom extends StatelessWidget {
  const StudentClassroom({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentClasssRoomController classsRoomController =
        Get.find<StudentClasssRoomController>();
    return Scaffold(
      appBar: customAppBar(context, title: "Class Room"),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DropdownButtonFormField<ClassRoomFilterDataListModel>(
              menuMaxHeight: 300.h,
              decoration: InputDecoration(
                isDense: true,
                hintText: "Select Teacher OR Subject",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              items: [
                DropdownMenuItem<ClassRoomFilterDataListModel>(
                  value: null,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text("All")),
                ),
                ...classsRoomController.filterList
                    .map((ClassRoomFilterDataListModel subject) {
                  return DropdownMenuItem<ClassRoomFilterDataListModel>(
                    value: subject,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(subject.empSub.toString()),
                    ),
                  );
                }),
              ],
              onChanged: (value) {
                if (value == null) {
                  classsRoomController.empid = '';
                  classsRoomController.subjectid = '';
                  classsRoomController.refreshpage.value =
                      !classsRoomController.refreshpage.value;
                  classsRoomController.classRoomData();
                } else {
                  classsRoomController.empid = value.empId.toString();
                  classsRoomController.subjectid = value.subjectId.toString();
                  classsRoomController.refreshpage.value =
                      !classsRoomController.refreshpage.value;
                  classsRoomController.classRoomData();
                }
              },
            ),
            CustomeHeight(10.h),
            Expanded(child: Obx(
              () {
                classsRoomController.refreshpage.value;
                return classRoomDataList();
              },
            )),
          ],
        ),
      ),
    );
  }
}