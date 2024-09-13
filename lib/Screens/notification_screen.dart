// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:campuspro/Controllers/notificationController.dart';

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

    return Scaffold(
      appBar: customAppBar(context),
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
                    ? Center(child: CircularProgressIndicator.adaptive())
                    : notificationController.notificationList.isEmpty
                        ? Center(
                            child: Text("Notification Not Availabe"),
                          )
                        : ListView.separated(
                            itemCount:
                                notificationController.notificationList.length,
                            separatorBuilder: (context, index) =>
                                Divider(height: 1),
                            itemBuilder: (context, index) {
                              return buildNotificationTile(index);
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNotificationTile(index) {
    final NotificationController notificationController =
        Get.find<NotificationController>();
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        // backgroundImage: AssetImage("assets/icon/notification.png"),
        radius: 25,
        child: Icon(
          Icons.notifications,
          size: 30.h,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            notificationController.notificationList[index].smsType.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            notificationController.notificationList[index].alertDate.toString(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
      subtitle: notificationController.notificationList[index].alertMessage
                  .toString()
                  .length >
              100
          ? Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: notificationController
                  .notificationList[index].alertMessage
                  .toString(),
              child: Text(
                "${notificationController.notificationList[index].alertMessage.toString().substring(0, 100)}...",
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: AppColors.blackcolor,
                  fontSize: 14.sp,
                ),
              ),
            )
          : Text(
              notificationController.notificationList[index].alertMessage
                  .toString(),
              style: TextStyle(
                fontWeight: FontWeight.w100,
                color: AppColors.blackcolor,
                fontSize: 11.sp,
              ),
            ),

      // tileColor: isUnread ? Colors.blue[50] : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      dense: true,
      //onTap: onTap,
    );
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
              SizedBox(height: 16),
              Text(
                'Filter Notifications',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
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
                      Container(
                        height: 30.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.textfieldhintstycolor,
                            )),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          readOnly: true,
                          controller: notificationController.fromDateController,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  notificationController.getdateRage(
                                      "fromDate", context);
                                },
                                child: Icon(Icons.date_range)),
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
                          controller: notificationController.toDatecontroller,
                          textAlign: TextAlign.center,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  notificationController.getdateRage(
                                      "todate", context);
                                },
                                child: Icon(Icons.date_range)),
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
                              notificationController.filternotificationdata();
                            }
                          : null,
                      child: Text(
                        'Apply Filter',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.whitetextcolor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    ).whenComplete(() {
      notificationController.clearDateFields();
    });
  }
}
