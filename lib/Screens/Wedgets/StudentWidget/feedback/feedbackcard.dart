// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/feedback_controller.dart';
import 'package:campuspro/Modal/feedback_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/common_button.dart';
import 'package:campuspro/Screens/Wedgets/common_form_component.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/Wedgets/error_commponet.dart';
import 'package:campuspro/Screens/style/style.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Feedbackcard extends StatelessWidget {
  const Feedbackcard({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentFeedbackController studentFeedbackController =
        Get.find<StudentFeedbackController>();
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            backgroundColor: AppColors.whitetextcolor,
            appBar: customAppBar(context),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(5.r),
                    child: Column(children: [
                      Image.asset(
                        'assets/icon/feedback.png',
                        height: 140.h,
                        width: 200.w,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 241, 232, 232)),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Row(children: [
                                  Obx(() => Radio<String>(
                                        value: 'Complain',
                                        groupValue: studentFeedbackController
                                            .type.value,
                                        onChanged: (value) {
                                          studentFeedbackController.type.value =
                                              value!;
                                        },
                                      )),
                                  Text('Complain',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold)),
                                  Obx(() => Radio<String>(
                                        value: 'Suggestion',
                                        groupValue: studentFeedbackController
                                            .type.value,
                                        onChanged: (value) {
                                          studentFeedbackController.type.value =
                                              value!;
                                        },
                                      )),
                                  Text('Suggestion',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold)),
                                ]),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(
                                () => buildTextField(
                                  contentPadding: EdgeInsets.all(12.r),
                                  hintText: "Topic",
                                  controller:
                                      studentFeedbackController.topicController,
                                  focusNode:
                                      studentFeedbackController.topicNode,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    color: studentFeedbackController
                                            .isTopicFocus.value
                                        ? Colors.black
                                        : Colors.grey,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  onChanged: (value) {
                                    studentFeedbackController.showerror.value =
                                        false;

                                    studentFeedbackController.topic.value =
                                        value;
                                  },
                                ),
                              ),
                              Obx(() {
                                return studentFeedbackController
                                        .topicError.value.isNotEmpty
                                    ? errocommponent(
                                        fontsize: 10.sp,
                                        errorText: studentFeedbackController
                                            .topicError)
                                    : SizedBox();
                              }),
                              CustomeHeight(7.h),
                              Obx(
                                () => buildTextField(
                                  contentPadding: EdgeInsets.all(12.r),
                                  hintText: "subjects",
                                  controller: studentFeedbackController
                                      .subjectController,
                                  focusNode:
                                      studentFeedbackController.subjectNode,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    color: studentFeedbackController
                                            .isSubjectFocus.value
                                        ? Colors.black
                                        : Colors.grey,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  onChanged: (value) {
                                    studentFeedbackController.showerror.value =
                                        false;

                                    studentFeedbackController.subject.value =
                                        value;
                                  },
                                ),
                              ),
                              Obx(() {
                                return studentFeedbackController
                                        .subjectError.value.isNotEmpty
                                    ? errocommponent(
                                        fontsize: 10.sp,
                                        errorText: studentFeedbackController
                                            .subjectError)
                                    : SizedBox();
                              }),
                              CustomeHeight(7.h),
                              Obx(
                                () => buildTextField(
                                  contentPadding: EdgeInsets.all(12.r),
                                  hintText: "Messsage",
                                  controller: studentFeedbackController
                                      .detailController,
                                  focusNode:
                                      studentFeedbackController.detailNode,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    color: studentFeedbackController
                                            .isDetailFocus.value
                                        ? Colors.black
                                        : Colors.grey,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  onChanged: (value) {
                                    studentFeedbackController.showerror.value =
                                        false;

                                    studentFeedbackController.detail.value =
                                        value;
                                  },
                                  maxLines: 2,
                                ),
                              ),
                              Obx(() {
                                return studentFeedbackController
                                        .messageError.value.isNotEmpty
                                    ? errocommponent(
                                        fontsize: 10.sp,
                                        errorText: studentFeedbackController
                                            .messageError)
                                    : SizedBox();
                              }),
                              SizedBox(height: 10.h),
                              appCommonbutton(
                                  onpressed: () {
                                    studentFeedbackController
                                        .validateTopic(context);
                                  },
                                  text: "Submit "),
                            ],
                          ),
                        ),
                      )
                    ])))));
  }
}

Widget feedbackdetailCard() {
  final StudentFeedbackController studentFeedbackController =
      Get.put(StudentFeedbackController());
  return FutureBuilder<List<FeedbackModel>>(
      future: studentFeedbackController.studentFeedbackData(flag: "Get"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available.'));
        } else {
          List<FeedbackModel> feedbacklist = snapshot.data!;
          return ListView.builder(
            itemCount: feedbacklist.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.whitetextcolor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                margin: EdgeInsets.all(4.h),
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Type: ${feedbacklist[index].type.toString()}",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grediant2),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            feedbacklist[index].tranDate.toString(),
                            style: TextStyle(
                              color: AppColors.textfieldhintstycolor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),

                      Row(
                        children: [
                          Text(
                            "Topic: ",
                            style: TextStyle(
                              color: AppColors.blackcolor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              feedbacklist[index].topic.toString(),
                              style: TextStyle(
                                color: AppColors.blackcolor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 4.h),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Subject: ",
                            style: TextStyle(
                              color: AppColors.blackcolor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            feedbacklist[index].subject.toString(),
                            style: TextStyle(
                              color: AppColors.blackcolor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 4.h),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description: ",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.blackcolor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            feedbacklist[index].detail.toString(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.blackcolor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      // Reply container, shown only if adminRemarks is not empty
                      if (feedbacklist[index].adminRemarks != null &&
                          feedbacklist[index].adminRemarks!.isNotEmpty)
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 224, 234, 248),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 245, 205, 205)
                                          .withOpacity(0.5),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Remark:${feedbacklist[index].adminRemarks.toString()}",
                            style: TextStyle(
                              color: AppColors.blackcolor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      });
}
