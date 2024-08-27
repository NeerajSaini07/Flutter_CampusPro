import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Screens/TransportModule/studentList/student_list_screen.dart';
import 'package:campuspro/Screens/Wedgets/bottom_bar.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/drawer.dart';
import 'package:campuspro/Screens/studenPortal/recent_notification.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TransportDashboard extends StatelessWidget {
  const TransportDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final AppbarController appbarController = Get.find<AppbarController>();
    final BottomBarController bottomBarController =
        Get.find<BottomBarController>();
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
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/userTypeBackGround.png'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
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
                          backgroundImage: const AssetImage(
                              'assets/images/person_icon.png'), // Replace with your image path
                          radius: 30.r,
                        ),
                      ),

                      SizedBox(height: 5.h),
                    ]),
                  ),
                ),

                SizedBox(height: 5.h),
                const SimpleSliderWidget(),
                SizedBox(height: 7.h),
                Container(
                    width: 335.w,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.all(1.0).copyWith(top: 12.h),
                    child: _buildActionsCard(context)),
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

  Widget _buildActionCard(
      BuildContext context, String title, String iconPath, Color color) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          elevation: 9,
          child: InkWell(
            onTap: () {
              if (title == 'Mark Attendance') {
                //  Get.offAll(AttendanceScreen());
              }
              if (title == 'Student List') {
                Get.to(TransportStudentList());
              }
              // Add more navigation logic for other titles here
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.8), color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18.0),
              ),
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width *
                    0.18, // Adjust the size of the container
                height: MediaQuery.sizeOf(context).width *
                    0.18, // Adjust the size of the container
                child: Image.asset(
                  iconPath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h), // Space between the card and text
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildActionsCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 17.h,
        crossAxisSpacing: 0.w,
        childAspectRatio: 1.04, // Adjusted aspect ratio for the new layout
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // _buildActionCard('Classroom', 'assets/drawer/classroom.png', Colors.white),
          // _buildActionCard('Homework', 'assets/drawer/homework.png', Colors.white),
          // _buildActionCard('Online Exam', 'assets/drawer/onlineTest.png', Colors.white),
          // _buildActionCard('Fee Payment', 'assets/drawer/fee.png', Colors.white),
          // _buildActionCard('Notification', 'assets/drawer/sub-popUpConfigure.png', Colors.white),
          // _buildActionCard('Leave Request', 'assets/drawer/leave.png', Colors.white),
          // _buildActionCard('Exam Result', 'assets/drawer/exam.png', Colors.white),
          // _buildActionCard('Circular', 'assets/drawer/circular.png', Colors.white),
          _buildActionCard(context, 'Student List',
              'assets/drawer/activity.png', Colors.white),
          _buildActionCard(context, 'Mark Attendance',
              'assets/drawer/attendance.png', Colors.white),
        ],
      ),
    );
  }
}
