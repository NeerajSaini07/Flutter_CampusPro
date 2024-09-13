// ignore_for_file: sort_child_properties_last
import 'package:campuspro/Controllers/notificationController.dart';
import 'package:campuspro/Screens/notification_screen.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget recentnotificationOnDashboard(BuildContext context) {
  final NotificationController notificationController =
      Get.find<NotificationController>();
  double customHeight = ScreenUtil().screenHeight;

  return SizedBox(
    height: customHeight > 700 ? 78.h : 60.h,
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: notificationController.dashboardnotification.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 1),
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 16.r,
                          child: Image.asset("assets/icon/notification.png"),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text:
                                        "${notificationController.dashboardnotification[index].smsType}",
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blackcolor,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " (${notificationController.dashboardnotification[index].alertDate})",
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blackcolor,
                                    ),
                                  ),
                                ]),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                "${notificationController.dashboardnotification[index].alertMessage}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackcolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  index ==
                          notificationController.dashboardnotification.length -
                              1
                      ? Container(
                          margin: EdgeInsets.only(right: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(width: 0.1.w),
                          ),
                          height: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r))),
                              onPressed: () async {
                                Get.to(const NotificationScreen());
                              },
                              child: Text(
                                "View All",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackcolor),
                              )),
                        )
                      : const SizedBox()
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}
