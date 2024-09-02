// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/dashboard_menu.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/Wedgets/common_userProfile_ondashboard.dart';
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

  final UserTypeController userTypeController = Get.find<UserTypeController>();

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
              userProfileName(),
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
    );
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
                  onTap: () async {
                    final AppRouting appRouting = AppRouting();
                    await appRouting.navigate(
                        DashboardMenulist
                            .dashboardMenulistdetails[index].menuName,
                        DashboardMenulist
                            .dashboardMenulistdetails[index].menuURL,
                        context);
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
                      width: 30.w,
                      height: 30.h,
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
                  ),
                ),
              ),
              SizedBox(height: 3.h), // Space between the card and text
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
