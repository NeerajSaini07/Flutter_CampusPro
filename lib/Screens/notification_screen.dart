// ignore_for_file: deprecated_member_use

import 'package:campuspro/Controllers/notificationController.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController =
        Get.find<NotificationController>();

    final WebController webController = Get.find<WebController>();

    return WillPopScope(
      onWillPop: () async {
        webController.showWebViewScreen.value = false;
        return true;
      },
      child: Scaffold(
        appBar: customAppBar(context, title: "Notifications"),
        backgroundColor: AppColors.whitetextcolor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      return displayBottomSheet(context);
                    },
                    child: Image.asset(
                      Constant.filtericon,
                      fit: BoxFit.cover,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Obx(
                  () => notificationController.notificationloader.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : notificationController.notificationList.isEmpty
                          ? const Center(
                              child: Text("Notification Not Availabe"),
                            )
                          : ListView.builder(
                              itemCount: notificationController
                                  .notificationList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: buildNotificationTile(index)),
                                );
                              },
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotificationTile(int index) {
    final NotificationController notificationController =
        Get.find<NotificationController>();

    return Obx(() {
      if (index < 0 ||
          index >= notificationController.notificationList.length) {
        return const SizedBox(); // Return an empty widget or handle gracefully
      }

      bool isExpanded = (index < notificationController.isExpandedList.length)
          ? notificationController.isExpandedList[index] ?? false
          : false;

      final notification = notificationController.notificationList[index];

      String message = notification.alertMessage.toString();

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 20,
                    child: Icon(
                      Icons.notifications,
                      size: 20.h,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.smsType.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        notification.alertDate.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    isExpanded || message.length <= 100
                        ? message
                        : "${message.substring(0, 100)}...",
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: AppColors.blackcolor,
                      fontSize: 11.sp,
                    ),
                  ),
                  if (message.length > 100)
                    GestureDetector(
                      onTap: () {
                        notificationController.toggleExpansion(index);
                      },
                      child: Text(
                        isExpanded ? "View Less" : "View More",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  void displayBottomSheet(BuildContext context) {
    final NotificationController notificationController =
        Get.find<NotificationController>();

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Filter Notifications',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "From:",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textfieldhintstycolor),
                      ),

                      // notificationController.getdateRage(
                      //       "fromDate", context);
                      Container(
                        height: 30.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.textfieldhintstycolor,
                            )),
                        child: TextFormField(
                          onTap: () {
                            notificationController.getdateRage(
                                "fromDate", context);
                          },
                          textAlign: TextAlign.center,
                          readOnly: true,
                          controller: notificationController.fromDateController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 6.h),
                            suffixIcon: InkWell(
                                onTap: () {}, child: Icon(Icons.date_range)),
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Select Date From",
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "To:",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textfieldhintstycolor),
                      ),
                      Container(
                        height: 30.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.textfieldhintstycolor,
                            )),
                        child: TextFormField(
                          onTap: () {
                            notificationController.getdateRage(
                                "todate", context);
                          },
                          controller: notificationController.toDatecontroller,
                          textAlign: TextAlign.center,
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 6.w),
                            suffixIcon: InkWell(
                                onTap: () {},
                                child: const Icon(Icons.date_range)),
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Select Date To",
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              CustomeHeight(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r)),
                          elevation: 0,
                          backgroundColor: AppColors.appbuttonColor),
                      onPressed: (notificationController
                                  .fromdate.value.isNotEmpty &&
                              (notificationController.todate.value.isNotEmpty))
                          ? () {
                              Get.back();
                              notificationController.removeFilter.value = true;
                              notificationController.filternotificationdata();
                            }
                          : null,
                      child: Text(
                        'Apply Filter',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.whitetextcolor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Obx(
                    () => notificationController.removeFilter.value
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              elevation: 0,
                              backgroundColor: AppColors.appbuttonColor,
                            ),
                            onPressed: () {
                              Get.back();
                              notificationController.fromdate.value = '';
                              notificationController.todate.value = '';
                              notificationController.removeFilter.value = false;
                              notificationController.getNotification();
                            },
                            child: Text(
                              'All Notifications',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.whitetextcolor,
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    ).whenComplete(() {
      if (notificationController.removeFilter.value == false) {
        notificationController.clearDateFields();
      }
    });
  }
}
