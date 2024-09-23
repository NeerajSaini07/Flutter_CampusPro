// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/feedback_controller.dart';
import 'package:campuspro/Modal/feedback_model.dart';
import 'package:campuspro/Screens/Wedgets/common_button.dart';
import 'package:campuspro/Screens/Wedgets/common_form_component.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/Wedgets/error_commponet.dart';
import 'package:campuspro/Screens/style/style.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget feedbackCard(BuildContext context) {
  final StudentFeedbackController studentFeedbackController =
      Get.find<StudentFeedbackController>();

  return Card(
      color: AppColors.titleAndsubtitleColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Obx(() => Radio<String>(
                      value: 'Complain',
                      groupValue: studentFeedbackController.type.value,
                      onChanged: (value) {
                        studentFeedbackController.type.value = value!;
                      },
                    )),
                Text('Complain', style: TextStyle(fontSize: 14.sp)),
                Obx(() => Radio<String>(
                      value: 'Suggestion',
                      groupValue: studentFeedbackController.type.value,
                      onChanged: (value) {
                        studentFeedbackController.type.value = value!;
                      },
                    )),
                Text('Suggestion', style: TextStyle(fontSize: 14.sp)),
              ]),
              Obx(
                () => buildTextField(
                  contentPadding: EdgeInsets.all(12.r),
                  hintText: "Topic",
                  controller: studentFeedbackController.topicController,
                  focusNode: studentFeedbackController.topicNode,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: studentFeedbackController.isTopicFocus.value
                        ? Colors.black
                        : Colors.grey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  onChanged: (value) {
                    studentFeedbackController.showerror.value = false;

                    studentFeedbackController.topic.value = value;
                  },
                ),
              ),
              Obx(() {
                return studentFeedbackController.topicError.value.isNotEmpty
                    ? errocommponent(
                        fontsize: 10.sp,
                        errorText: studentFeedbackController.topicError)
                    : SizedBox();
              }),
              CustomeHeight(7.h),
              Obx(
                () => buildTextField(
                  contentPadding: EdgeInsets.all(12.r),
                  hintText: "subjects",
                  controller: studentFeedbackController.subjectController,
                  focusNode: studentFeedbackController.subjectNode,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: studentFeedbackController.isSubjectFocus.value
                        ? Colors.black
                        : Colors.grey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  onChanged: (value) {
                    studentFeedbackController.showerror.value = false;

                    studentFeedbackController.subject.value = value;
                  },
                ),
              ),
              Obx(() {
                return studentFeedbackController.subjectError.value.isNotEmpty
                    ? errocommponent(
                        fontsize: 10.sp,
                        errorText: studentFeedbackController.subjectError)
                    : SizedBox();
              }),
              CustomeHeight(7.h),
              Obx(
                () => buildTextField(
                  contentPadding: EdgeInsets.all(12.r),
                  hintText: "Messsage",
                  controller: studentFeedbackController.detailController,
                  focusNode: studentFeedbackController.detailNode,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: studentFeedbackController.isDetailFocus.value
                        ? Colors.black
                        : Colors.grey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  onChanged: (value) {
                    studentFeedbackController.showerror.value = false;

                    studentFeedbackController.detail.value = value;
                  },
                  maxLines: 2,
                ),
              ),
              Obx(() {
                return studentFeedbackController.messageError.value.isNotEmpty
                    ? errocommponent(
                        fontsize: 10.sp,
                        errorText: studentFeedbackController.messageError)
                    : SizedBox();
              }),
              SizedBox(height: 10.h),
              appCommonbutton(
                  onpressed: () {
                    studentFeedbackController.validateTopic(context);
                  },
                  text: "Submit Feedback"),
            ],
          ),
        ),
      ));
}

Widget feedbackdetailCard() {
  final StudentFeedbackController studentFeedbackController =
      Get.put(StudentFeedbackController());
  return FutureBuilder<List<FeedbackModel>>(
      future: studentFeedbackController.studentFeedbackData(
          flag: "Get"), // Correctly typed future function
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
          List<FeedbackModel> feedbacklist = snapshot.data!;
          return ListView.builder(
            itemCount: feedbacklist.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                color: AppColors.whitetextcolor,
                margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                feedbacklist[index].type.toString(),
                                style: AppTextStyles.cardTitle,
                                overflow: TextOverflow.ellipsis,
                              ),

                              Text(
                                feedbacklist[index].tranDate.toString(),
                                style: AppTextStyles.cardDate,
                              ),
                              // SizedBox(width:100.w),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "Subject:${feedbacklist[index].subject.toString()}",
                            style: AppTextStyles.cardContent,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "Topic:${feedbacklist[index].topic.toString()}",
                            style: AppTextStyles.cardContent,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "Message: ${feedbacklist[index].detail.toString()}",
                            style: AppTextStyles.cardContent,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "${feedbacklist[index].adminRemarks.toString()}",
                            style: AppTextStyles.cardContent,
                          ),
                        ])),
              );
            },
          );
        }
      });
}
