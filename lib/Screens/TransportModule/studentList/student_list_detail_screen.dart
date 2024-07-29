// ignore_for_file: invalid_use_of_protected_member

import 'package:campuspro/Controllers/transport_studentlist_controller.dart';
import 'package:campuspro/Modal/student_list_detail_model.dart';
import 'package:campuspro/Screens/Wedgets/custom_width.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudentListDetail extends StatelessWidget {
  const StudentListDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final TransportStudentListController tStudentListController =
        Get.find<TransportStudentListController>();
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: AppColors.primarycolor,
          centerTitle: false,
          title: const Text(
            "Student List",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: Obx(() {
          if (tStudentListController.studentListDetail.value.isNotEmpty) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              separatorBuilder: (context, index) {
                return CustomeHeight(12.h);
              },
              shrinkWrap: true,
              itemCount: tStudentListController.studentListDetail.value.length,
              itemBuilder: (context, index) {
                return studentListCardView(context,
                    tStudentListController.studentListDetail.value[index]);
              },
            );
          } else {
            return Center(
              child: Text(
                "No Record Found",
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        }));
  }

  Widget studentListCardView(
      BuildContext context, StudentDetailsTable sDetail) {
    final TransportStudentListController tStudentListController =
        Get.find<TransportStudentListController>();
    return Obx(
      () => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFD2D0D0),
              offset: Offset(-1, 0),
              blurRadius: 20,
              spreadRadius: 4,
            ),
          ],
          border: Border.all(width: 0.5, color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                if (tStudentListController.sNo.value == sDetail.srNo) {
                  tStudentListController.sNo.value = 0;
                } else {
                  tStudentListController.sNo.value = sDetail.srNo;
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h)
                    .copyWith(bottom: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue[50]),
                          child: Icon(
                            Icons.person_2,
                            size: 30.w,
                            color: AppColors.primarycolor,
                          ),
                        ),
                        customWidth(16.w),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                sDetail.stName,
                                textScaler: TextScaler.noScaling,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              CustomeHeight(4.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 12.sp,
                                  ),
                                  customWidth(4.w),
                                  Text(
                                    sDetail.guardianMobileNo,
                                    textScaler: TextScaler.noScaling,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        customWidth(14.w),
                        (tStudentListController.sNo.value == sDetail.srNo)
                            ? Icon(
                                Icons.arrow_drop_up_rounded,
                                size: 40.w,
                                color: AppColors.primarycolor,
                              )
                            : Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 40.w,
                                color: AppColors.primarycolor,
                              ),
                      ],
                    )
                    // Row(
                    //   children: [
                    //     Text(
                    //       sDetail.stName,
                    //       textScaler: TextScaler.noScaling,
                    //       style: TextStyle(
                    //         fontSize: 16.sp,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     const Spacer(),
                    //     IconButton(
                    //         onPressed: () {
                    //           if (tStudentListController.sNo.value ==
                    //               sDetail.srNo) {
                    //             tStudentListController.sNo.value = 0;
                    //           } else {
                    //             tStudentListController.sNo.value = sDetail.srNo;
                    //           }
                    //         },
                    //         icon:
                    //             (tStudentListController.sNo.value == sDetail.srNo)
                    //                 ? Padding(
                    //                     padding:
                    //                         EdgeInsets.symmetric(horizontal: 4.w),
                    //                     child: Row(
                    //                       mainAxisSize: MainAxisSize.min,
                    //                       children: [
                    //                         Text(
                    //                           "View less",
                    //                           textScaler: TextScaler.noScaling,
                    //                           style: TextStyle(
                    //                             fontSize: 12.sp,
                    //                             fontWeight: FontWeight.bold,
                    //                           ),
                    //                         ),
                    //                         const Icon(Icons.arrow_drop_up)
                    //                       ],
                    //                     ),
                    //                   )
                    //                 : Padding(
                    //                     padding:
                    //                         EdgeInsets.symmetric(horizontal: 4.w),
                    //                     child: Row(
                    //                       mainAxisSize: MainAxisSize.min,
                    //                       children: [
                    //                         Text(
                    //                           "View more",
                    //                           textScaler: TextScaler.noScaling,
                    //                           style: TextStyle(
                    //                             fontSize: 12.sp,
                    //                             fontWeight: FontWeight.bold,
                    //                           ),
                    //                         ),
                    //                         Icon(Icons.arrow_drop_down)
                    //                       ],
                    //                     ),
                    //                   ))
                    //   ],
                    // ),
                    // CustomeHeight(6.h),
                    // Row(
                    //   children: [
                    //     Text(
                    //       "Adm No. : ",
                    //       textScaler: TextScaler.noScaling,
                    //       style: TextStyle(
                    //         fontSize: 14.sp,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //     Text(
                    //       sDetail.admNo,
                    //       textScaler: TextScaler.noScaling,
                    //       style: TextStyle(
                    //         fontSize: 14.sp,
                    //         color: AppColors.primarycolor,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     const Spacer(),
                    //     Container(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: 15.h, vertical: 4.w),
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //             width: 1, color: AppColors.primarycolor),
                    //         borderRadius: BorderRadius.circular(20.0),
                    //       ),
                    //       child: Text.rich(
                    //         overflow: TextOverflow.ellipsis,
                    //         TextSpan(
                    //           children: [
                    //             TextSpan(
                    //                 text: 'Fee Status : ',
                    //                 style: TextStyle(
                    //                   fontSize: 14.sp,
                    //                   color: AppColors.primarycolor,
                    //                   fontWeight: FontWeight.w500,
                    //                 )),
                    //             TextSpan(
                    //               text: sDetail.fee.toString() == "Y"
                    //                   ? '✔ Yes'
                    //                   : '✘ No',
                    //               style: TextStyle(
                    //                 fontSize: 14.sp,
                    //                 color: sDetail.fee.toString() == "Y"
                    //                     ? Colors.green
                    //                     : Colors.red,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: tStudentListController.sNo.value == sDetail.srNo,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomeHeight(6.h),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  CustomeHeight(6.h),
                  headingContent(heading: "Adm No. : ", content: sDetail.admNo),
                  headingContent(
                      heading: "Father Name : ", content: sDetail.fatherName),
                  headingContent(
                      heading: "Address : ", content: sDetail.prsntAddress),
                  headingContent(
                      heading: "Facility : ", content: "Both(Pick & Drop)"),
                ],
              ),
            ),
            CustomeHeight(6.h),
          ],
        ),
      ),
    );
  }

  Widget headingContent({required String heading, required String content}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w).copyWith(bottom: 6.h),
      child: Row(
        children: [
          Text(
            heading,
            textScaler: TextScaler.noScaling,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              content,
              textScaler: TextScaler.noScaling,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
