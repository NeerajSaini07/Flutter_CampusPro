// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:campuspro/Controllers/StudentControllers/classroomcontroller.dart';
import 'package:campuspro/Modal/student_module/class_room_teacher_filter.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/classoom/class_room_list.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Wedgets/common_appbar.dart';

class StudentClassroom extends StatefulWidget {
  const StudentClassroom({super.key});

  @override
  State<StudentClassroom> createState() => _StudentClassroomState();
}

class _StudentClassroomState extends State<StudentClassroom> {
  final StudentClasssRoomController classsRoomController =
      Get.find<StudentClasssRoomController>();
  @override
  void initState() {
    super.initState();
    classsRoomController.filterBysubjectTecher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Class Room"),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => CustomDropdown<String>(
                excludeSelected: false,
                hintText: "All",
                hideSelectedFieldWhenExpanded: true,
                items: [
                  'All',
                  ...classsRoomController.filterList
                      .map((ClassRoomFilterDataListModel element) {
                    return element.empSub.toString();
                  }),
                ],
                onChanged: (value) {
                  if (value == 'All' || value == null) {
                    classsRoomController.empid.value = '';
                    classsRoomController.subjectid.value = '';
                    classsRoomController.refreshpage.value =
                        !classsRoomController.refreshpage.value;
                    classsRoomController.classRoomData();
                  } else {
                    final selectedModel = classsRoomController.filterList
                        .firstWhere(
                            (element) => element.empSub.toString() == value);

                    classsRoomController.empid.value =
                        selectedModel.empId.toString();
                    classsRoomController.subjectid.value =
                        selectedModel.subjectId.toString();
                    classsRoomController.refreshpage.value =
                        !classsRoomController.refreshpage.value;
                    classsRoomController.classRoomData();
                  }
                },
                decoration: CustomDropdownDecoration(closedShadow: [
                  CommonFunctions.commonsadhow(),
                ]),
              ),
            ),

            // DropdownButtonFormField<ClassRoomFilterDataListModel>(
            //   menuMaxHeight: 300.h,
            //   decoration: InputDecoration(
            //     isDense: true,
            //     hintText: "Select Teacher OR Subject",
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10.r),
            //     ),
            //   ),
            //   items: [
            //     DropdownMenuItem<ClassRoomFilterDataListModel>(
            //       value: null,
            //       child: Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 8.w),
            //           child: Text("All")),
            //     ),
            //     ...classsRoomController.filterList
            //         .map((ClassRoomFilterDataListModel subject) {
            //       return DropdownMenuItem<ClassRoomFilterDataListModel>(
            //         value: subject,
            //         child: Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 0.w),
            //           child: Text(
            //             subject.empSub.toString(),
            //             overflow: TextOverflow.ellipsis,
            //             style: TextStyle(
            //                 fontSize: 12.sp, fontWeight: FontWeight.w400),
            //           ),
            //         ),
            //       );
            //     }),
            //   ],
            //   onChanged: (value) {
            //     if (value == null) {
            //       classsRoomController.empid.value = '';
            //       classsRoomController.subjectid.value = '';
            //       classsRoomController.refreshpage.value =
            //           !classsRoomController.refreshpage.value;
            //       classsRoomController.classRoomData();
            //     } else {
            //       classsRoomController.empid.value = value.empId.toString();
            //       classsRoomController.subjectid.value =
            //           value.subjectId.toString();
            //       classsRoomController.refreshpage.value =
            //           !classsRoomController.refreshpage.value;
            //       classsRoomController.classRoomData();
            //     }
            //   },
            // ),
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
