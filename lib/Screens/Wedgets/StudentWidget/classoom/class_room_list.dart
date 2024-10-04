// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:campuspro/Controllers/StudentControllers/classroomcontroller.dart';
import 'package:campuspro/Modal/student_module/student_class_room_model.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/classoom/class_room_comment_page.dart.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/common_text_style.dart';
import 'package:campuspro/Screens/Wedgets/custom_width.dart';
import 'package:campuspro/Services/downloadService/download_service.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget classRoomDataList() {
  final StudentClasssRoomController studentClasssRoomController =
      Get.find<StudentClasssRoomController>();

  final DownloadService downloadService = Get.find<DownloadService>();
  // final FileDownloadService downloadService = Get.find<FileDownloadService>();
  return FutureBuilder<List<StudentClassRoomModel>>(
    future: fetchClassRoomData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator.adaptive());
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No data available.'));
      } else {
        List<StudentClassRoomModel> classRoomList = snapshot.data!;
        return ListView.builder(
          itemCount: classRoomList.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: AppColors.whitetextcolor,
                  boxShadow: [
                    CommonFunctions.commonsadhow(),
                  ],
                  borderRadius: BorderRadius.circular(10.r)),
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
                        Row(
                          children: [
                            Obx(() => studentClasssRoomController
                                    .classRoomdatalist[index]
                                    .circularFileUrl!
                                    .isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      downloadService.downloadFile(
                                          studentClasssRoomController
                                              .classRoomdatalist[index]
                                              .circularFileUrl
                                              .toString());
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.appbuttonColor,
                                      radius: 12.r,
                                      child: Icon(
                                        Icons.download,
                                        color: AppColors.whitetextcolor,
                                      ),
                                    ),
                                  )
                                : SizedBox()),
                            customWidth(25.w),
                            GestureDetector(
                              onTap: () async {
                                await studentClasssRoomController
                                    .getclassRommComments(index);
                                Get.to(ClassRoomComments(
                                  index: index,
                                ));
                              },
                              child: Image.asset(
                                "assets/icon/show_message.png",
                                height: 20.h,
                                width: 20.w,
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 12.h),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: classRoomList[index]
                                      .cirContent
                                      .toString()
                                      .length >
                                  100
                              ? classRoomList[index]
                                  .cirContent!
                                  .substring(0, 100)
                              : classRoomList[index].cirContent,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackcolor),
                        ),
                        classRoomList[index].cirContent.toString().length > 100
                            ? TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    await studentClasssRoomController
                                        .getclassRommComments(index);
                                    Get.to(ClassRoomComments(
                                      index: index,
                                    ));
                                  },
                                text: "  ...View More",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent))
                            : TextSpan(),
                      ]),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          classRoomList[index].circularDateFormatted.toString(),
                          style: AppTextStyles.cardDate,
                        ),
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
  return studentClasssRoomController.classRoomdatalist;
}
