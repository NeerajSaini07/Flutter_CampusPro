// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/dashboard_menu.dart';
import 'package:campuspro/Utilities/approuting.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget buildActionsCard() {
  final BottomBarController bottomBarController =
      Get.find<BottomBarController>();
  final WebController webController = Get.find<WebController>();
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 1.0.w,
    ),
    itemCount: DashboardMenulist.dashboardMenulistdetails.length,
    itemBuilder: (context, index) {
      return InkWell(
          onTap: () async {
            bottomBarController.selectedBottomNavIndex.value = 0;
            webController.showWebViewScreen.value = true;
            final AppRouting appRouting = AppRouting();
            await appRouting.navigate(
                DashboardMenulist.dashboardMenulistdetails[index].menuName,
                DashboardMenulist.dashboardMenulistdetails[index].menuURL,
                context,
                DashboardMenulist.dashboardMenulistdetails[index].flag);
          },
          child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30.r)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    CommonFunctions.fetchDahboardIcon(
                        menuname: DashboardMenulist
                            .dashboardMenulistdetails[index].menuName
                            .toString()),
                    // DashboardMenulist.dashboardMenulistdetails[index].imageUrl
                    //     .toString(),
                    fit: BoxFit.fill,
                    height: 40.h,
                    width: 40.w,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r)),
                        child: Image.network(
                          'https://picsum.photos/200', // Replace with the path to your dummy image
                          fit: BoxFit.fitHeight,
                          height: 30.h,
                          width: 30.w,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
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
              )));
    },
  );
}
