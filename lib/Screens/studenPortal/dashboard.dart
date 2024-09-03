// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/student_module_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/dashboard_menu.dart';
import 'package:campuspro/Modal/student_module/notification_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Utilities/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Utilities/approuting.dart';
import 'recent_notification.dart';

class StudentDashboad extends StatelessWidget {
  StudentDashboad({super.key});

  final AppbarController appbarController = Get.find<AppbarController>();
  final BottomBarController bottomBarController =
      Get.find<BottomBarController>();
  final WebController webController = Get.find<WebController>();
  final UserTypeController userTypeController = Get.find<UserTypeController>();
  final StudentModuleController studentController =
      Get.find<StudentModuleController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/userTypeBackGround.png'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 1.0,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primarycolor,
                      Colors.blue[300]!,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  // Add padding for spacing
                  child: Stack(children: [
                    // Left side: Text
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Hi , ${UserTypeslist.userTypesDetails[userTypeController.usertypeIndex].stuEmpName!.capitalizeFirst}',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            '${_getGreetingMessage()},',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Right side: CircleAvatar
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: CircleAvatar(
                    //     backgroundImage: AssetImage(
                    //         'assets/images/person_icon.png'), // Replace with your image path
                    //     radius: 30.r,
                    //   ),
                    // ),

                    SizedBox(height: 5.h),
                  ]),
                ),
              ),

              SizedBox(height: 5.h),
              // MarqueeWidget(),
              Obx(
                () => studentController.notificationStatus.value
                    ? SimpleSliderWidget(
                        notifications: NotificationList.notificationList,
                      )
                    : SizedBox(),
              ),
              SizedBox(height: 7.h),
              Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: _buildActionsCard()),
            ],
          ),
        ),
      ),
    );
  }

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Widget _buildActionCard(String title, String iconPath, Color color) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 10,
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(184, 84, 105, 238).withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(4, 7),
                  ),
                ],
                borderRadius: BorderRadius.circular(25.0),
              ),
              padding: EdgeInsets.all(5.0),
              child: SizedBox(
                width: 65.w, // Adjust the size of the container
                height: 58.h, // Adjust the size of the container
                child: Image.asset(
                  iconPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 3.h), // Space between the card and text
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildActionsCard() {
    return Padding(
      padding: EdgeInsets.zero,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          // mainAxisSpacing: 14.h,
          // crossAxisSpacing: 0.w,
          childAspectRatio: 0.8,
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: DashboardMenulist
            .dashboardMenulistdetails.length, // total number of items
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                shape: CircleBorder(),
                // RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(25.0),
                // ),
                elevation: 10,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24.r + 4),
                  onTap: () async {
                    //Navigation to Flutter or WebView
                    if (DashboardMenulist
                            .dashboardMenulistdetails[index].flag ==
                        "W") {
                      webController.showWebViewScreen.value = true;
                      final AppRouting appRouting = AppRouting();
                      await appRouting.navigate(
                          DashboardMenulist
                              .dashboardMenulistdetails[index].menuName,
                          DashboardMenulist
                              .dashboardMenulistdetails[index].menuURL,
                          context);
                    } else {}
                  },
                  child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 24.r,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.r),
                          child: Image.network(
                            DashboardMenulist
                                .dashboardMenulistdetails[index].imageUrl
                                .toString(),
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                'https://picsum.photos/200', // Replace with the path to your dummy image
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(height: 4.h), // Space between the card and text
              Text(
                DashboardMenulist.dashboardMenulistdetails[index].menuName
                    .toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
