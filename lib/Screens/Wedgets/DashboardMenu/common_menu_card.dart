// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/dashboard_menu.dart';
import 'package:campuspro/Utilities/approuting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget buildActionsCard() {
  final BottomBarController bottomBarController =
      Get.find<BottomBarController>();
  final WebController webController = Get.find<WebController>();
  return Padding(
    padding: EdgeInsets.zero,
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
                  bottomBarController.selectedBottomNavIndex.value = 0;
                  webController.showWebViewScreen.value = true;
                  final AppRouting appRouting = AppRouting();
                  await appRouting.navigate(
                      DashboardMenulist
                          .dashboardMenulistdetails[index].menuName,
                      DashboardMenulist.dashboardMenulistdetails[index].menuURL,
                      context);
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
