// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:campuspro/Controllers/StudentControllers/classroomcontroller.dart';
import 'package:campuspro/Modal/student_module/class_room_teacher_filter.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/classoom/class_room_list.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:flutter/material.dart';
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
      appBar: customAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DropdownButtonFormField(
              decoration: InputDecoration(
                  hintText: "Select Teacher OR Subject",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r))),
              items: classsRoomController.filterList
                  .map((ClassRoomFilterDataListModel subject) {
                return DropdownMenuItem<ClassRoomFilterDataListModel>(
                  value: subject,
                  child: Text(subject.empSub.toString()),
                );
              }).toList(),
              onChanged: (value) {
                classsRoomController.empid = value!.empId.toString();
                classsRoomController.subjectid = value.subjectId.toString();
                classsRoomController.refreshpage.value =
                    !classsRoomController.refreshpage.value;
                classsRoomController.classRoomData();
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
