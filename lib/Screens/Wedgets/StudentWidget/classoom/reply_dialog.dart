// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/StudentControllers/classroomcontroller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:get/get.dart';

void showChatScreenDialog(BuildContext context, int index) {
  final StudentClasssRoomController studentClasssRoomController =
      Get.find<StudentClasssRoomController>();

  final UserTypeController userTypeController = Get.find<UserTypeController>();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                          studentClasssRoomController.fileName.value = '';
                          studentClasssRoomController.filesource.value = '';
                          studentClasssRoomController.comment.clear();
                          Get.back();
                        },
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: studentClasssRoomController.commentlist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: studentClasssRoomController
                                  .commentlist[index].userType!
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
                        studentClasssRoomController.commentlist[index].comment
                            .toString(),
                        style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.employeeTextcolor),
                      ),
                      trailing: studentClasssRoomController
                              .commentlist[index].fileUrl!.isNotEmpty
                          ? Icon(
                              Icons.download,
                              color: AppColors.appbuttonColor,
                            )
                          : SizedBox(),
                    );
                  },
                ),
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
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    studentClasssRoomController.getfiles();
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
                        studentClasssRoomController
                            .addCommentOnClassRoom(index);
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
