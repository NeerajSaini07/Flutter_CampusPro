// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/fileDownloadSerrvice/download.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:get/get.dart';

void studenthomeworkCommentsdialog(BuildContext context, int index) {
  final StudentHomeWorkController studentHomeWorkController =
      Get.find<StudentHomeWorkController>();

  final UserTypeController userTypeController = Get.find<UserTypeController>();

  final FileDownloadService downloadService = Get.find<FileDownloadService>();

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          height: 400.h,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(color: AppColors.loginscafoldcoolr),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        'Comments:',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w, left: 5.w),
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: AppColors.whitetextcolor,
                        ),
                        onPressed: () {
                          studentHomeWorkController.commentfile.value = '';
                          studentHomeWorkController.commentcontroller.clear();
                          studentHomeWorkController.filename.value = '';
                          studentHomeWorkController.showfileoncomment.value =
                              false;
                          Get.back();
                        },
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: studentHomeWorkController.homeworkcomments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: studentHomeWorkController
                                  .homeworkcomments[index].userType!
                                  .toLowerCase() ==
                              's'
                          ? Text(
                              UserTypeslist
                                  .userTypesDetails[
                                      userTypeController.usertypeIndex]
                                  .stuEmpName
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.appbuttonColor),
                            )
                          : Text(
                              "Teacher",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green),
                            ),
                      subtitle: Text(
                        studentHomeWorkController
                            .homeworkcomments[index].comment
                            .toString(),
                        style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.employeeTextcolor),
                      ),
                      trailing: studentHomeWorkController
                              .homeworkcomments[index].fileUrl!.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                downloadService.downloadFile(
                                    studentHomeWorkController
                                        .homeworkcomments[index].fileUrl
                                        .toString());
                              },
                              child: Icon(
                                Icons.download,
                                color: AppColors.appbuttonColor,
                              ),
                            )
                          : SizedBox(),
                    );
                  },
                ),
              ),
              Obx(
                () => studentHomeWorkController.showfileoncomment.value
                    ? Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              studentHomeWorkController.filename.value
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red),
                            ),
                            IconButton(
                                alignment: Alignment.bottomRight,
                                onPressed: () {
                                  studentHomeWorkController.commentfile.value =
                                      '';
                                  studentHomeWorkController
                                      .showfileoncomment.value = false;
                                },
                                icon: Icon(Icons.close_sharp))
                          ],
                        ),
                      )
                    : SizedBox(),
              ),
              Container(
                padding: EdgeInsets.only(left: 6.w, bottom: 10.h, right: 6.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: 80.h,
                          child: TextFormField(
                            maxLines: null,
                            controller:
                                studentHomeWorkController.commentcontroller,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    studentHomeWorkController.getfiles();
                                  },
                                  child: Icon(Icons.attach_file_rounded)),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 6.h,
                                horizontal: 10.w,
                              ),
                              hintText: "Add Comments...",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        studentHomeWorkController
                                    .commentcontroller.text.isEmpty &&
                                studentHomeWorkController
                                    .commentfile.value.isEmpty
                            ? null
                            : studentHomeWorkController
                                .addcommentsonHomeWork(index);
                      },
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColors.appbuttonColor,
                        child: Icon(
                          Icons.send,
                          color: AppColors.whitetextcolor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
