import 'package:campuspro/Controllers/notificationController.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/student_module/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SimpleSliderWidget extends StatelessWidget {
  const SimpleSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final WebController webController = Get.find<WebController>();
    final NotificationController notificationController =
        Get.find<NotificationController>();
    return Center(
      child: Container(
        width: double.infinity,
        height: 90.h,
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
        child: PageView.builder(
          controller: notificationController.pageController,
          itemCount: 4,
          itemBuilder: (context, index) {
            int actualIndex = index % notificationController.messages.length;
            return Card(
              color: Colors.red[300],
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.chat,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          SizedBox(width: 10.w), // Space between icon and text
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notificationController.trimSentence(
                                    (notificationController
                                            .messages[actualIndex]
                                            .alertMessage ??
                                        ""),
                                    27),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    NotificationList
                                        .notificationList[actualIndex].smsType
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    " ( ${NotificationList.notificationList[actualIndex].alertDate} )",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     webController.showWebViewScreen.value = true;
                      //     final AppRouting appRouting = AppRouting();
                      //     await appRouting.navigate(
                      //         DashboardMenulist.dashboardMenulistdetails
                      //             .firstWhere((menu) =>
                      //                 menu.menuName.contains("Notification"))
                      //             .menuName,
                      //         DashboardMenulist.dashboardMenulistdetails
                      //             .firstWhere((menu) =>
                      //                 menu.menuName.contains("Notification"))
                      //             .menuURL,
                      //         context);
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: AppColors.appbuttonColor,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(8.r),
                      //     ),
                      //   ),
                      //   child: Text(
                      //     'View',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 14.sp,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                    ]),
              ),
            );
          },
          onPageChanged: (index) {
            notificationController.currentIndex =
                index % notificationController.messages.length;
          },
        ),
      ),
    );
  }
}
