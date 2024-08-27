// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Modal/dashboard_menu.dart';
import 'package:campuspro/Screens/Wedgets/bottom_bar.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/drawer.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      bottomNavigationBar: Obx(
        () => BottomNavBar(
          currentIndex: bottomBarController.selectedBottomNavIndex.value,
          onTap: bottomBarController.onItemTappedChangeBottomNavIndex,
        ),
      ),
      drawer: AppDrawer(context),
      body: SingleChildScrollView(
        child: Container(
          height: 720.h,
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
                // Greeting Container
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
                              'Hi Name!',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              '${_getGreetingMessage()},',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Right side: CircleAvatar
                      Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images/person_icon.png'), // Replace with your image path
                          radius: 30.r,
                        ),
                      ),

                      SizedBox(height: 5.h),
                    ]),
                  ),
                ),

                SizedBox(height: 5.h),
                // MarqueeWidget(),
                SimpleSliderWidget(),
                SizedBox(height: 7.h),
                Container(
                    width: 335.w,
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
                    padding: EdgeInsets.all(1.0),
                    child: _buildActionsCard()),
              ],
            ),
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 14.h,
          crossAxisSpacing: 0.w,
          childAspectRatio: 1.04,
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: DashboardMenulist
            .dashboardMenulistdetails.length, // total number of items
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                elevation: 10,
                child: InkWell(
                  onTap: () {
                    final AppRouting appRouting = AppRouting();
                    appRouting.navigate(
                        DashboardMenulist
                            .dashboardMenulistdetails[index].menuName,
                        DashboardMenulist
                            .dashboardMenulistdetails[index].menuURL,
                        context);
                    Navigator.pop(context);
                    appbarController.appBarName.value = DashboardMenulist
                        .dashboardMenulistdetails[index].menuName
                        .toString();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(184, 84, 105, 238)
                              .withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(4, 7),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: 65.w,
                      height: 58.h,
                      child: Image.asset(
                        DashboardMenulist
                            .dashboardMenulistdetails[index].imageUrl
                            .toString(),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h), // Space between the card and text
              Text(
                DashboardMenulist.dashboardMenulistdetails[index].imageUrl
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
      // child: GridView.bu(
      //   shrinkWrap: true,
      //   crossAxisCount: 3,
      //   mainAxisSpacing: 14.h,
      //   crossAxisSpacing: 0.w,
      //   childAspectRatio: 1.04, // Adjusted aspect ratio for the new layout
      //   physics: NeverScrollableScrollPhysics(),
      //   children: [

      //   ],
      // children: [
      //   _buildActionCard(
      //       'Classroom', 'assets/icon/classroom.png', Colors.white),
      //   _buildActionCard(
      //       'Homework', 'assets/icon/homework.png', Colors.white),
      //   _buildActionCard('Online Exam', 'assets/icon/exam.png', Colors.white),
      //   _buildActionCard('Fee Payment', 'assets/icon/fees.png', Colors.white),
      //   _buildActionCard(
      //       'Notification', 'assets/icon/notification.png', Colors.white),
      //   _buildActionCard(
      //       'Leave Request', 'assets/icon/leave.png', Colors.white),
      //   _buildActionCard(
      //       'Exam Result', 'assets/icon/results.png', Colors.white),
      //   _buildActionCard(
      //       'Schedule', 'assets/icon/circular.png', Colors.white),
      //   _buildActionCard(
      //       'Activity', 'assets/icon/activity.png', Colors.white),
      //   _buildActionCard(
      //       'Attendance', 'assets/icon/attendance .png', Colors.white),
      // ],
    );
  }
}
