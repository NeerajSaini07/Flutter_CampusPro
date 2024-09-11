// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/StudentControllers/classroomcontroller.dart';
import 'package:campuspro/Modal/student_module/student_class_room_model.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/common_text_style.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/homework/reply_dialog.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget classRoomDataList() {
  return FutureBuilder<List<StudentClassRoomModel>>(
    future: fetchClassRoomData(), // Correctly typed future function
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Show a loading indicator while waiting for the data
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        // Handle any errors that occurred during the fetch
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        // Handle the case when no data is available
        return Center(child: Text('No data available.'));
      } else {
        // If the future is complete and has data, build the ListView
        List<StudentClassRoomModel> classRoomList = snapshot.data!;
        return ListView.builder(
          itemCount: classRoomList.length,
          itemBuilder: (context, index) {
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
                          "${classRoomList[index].subjectName} ",
                          style: AppTextStyles.cardTitle,
                        ),
                        SizedBox(width: 120.w),
                        GestureDetector(
                          onTap: () {
                            showChatScreenDialog(context);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.reply,
                              color: AppColors.appbuttonColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      classRoomList[index].cirContent.toString(),
                      style: AppTextStyles.cardContent,
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          classRoomList[index].circularDateFormatted.toString(),
                          style: AppTextStyles.cardDate,
                        ),
                        (classRoomList[index].circularFileUrl != null &&
                                classRoomList[index]
                                    .circularFileUrl!
                                    .isNotEmpty)
                            ? Container(
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
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    },
  );
}

Future<List<StudentClassRoomModel>> fetchClassRoomData() async {
  final StudentClasssRoomController studentClasssRoomController =
      Get.find<StudentClasssRoomController>();
  studentClasssRoomController.classRoomData();
  await Future.delayed(Duration(seconds: 1));

  // Simulate a delay
  return ClassRoomDataList
      .classRoomlist; // Ensure this returns List<StudentClassRoomModel>
}
