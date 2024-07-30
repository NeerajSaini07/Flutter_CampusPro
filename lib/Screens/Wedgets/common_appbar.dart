// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/logout_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Screens/getpass/visitor_history.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

customAppBar(BuildContext context) {
  final AppbarController appbarController = Get.find<AppbarController>();
  final LogoutController logoutController = Get.find<LogoutController>();
  final WebController webController = Get.find<WebController>();

  return AppBar(
    backgroundColor: AppColors.primarycolor, // Change to your desired color
    centerTitle: false,
    title: Obx(
      () => Text(
        appbarController.appBarName.toString(),
        style: TextStyle(
          color: Colors.white, // Change to your desired title color
          fontSize: 20, // Change to your desired font size
          fontWeight: FontWeight.bold, // Change to your desired font weight
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    actions: [
      PopupMenuButton<String>(
        icon: Image.asset(
          'assets/images/person_icon.png',
          width: 24.w,
          height: 24.h,
        ),
        onSelected: (value) {
          if (value == 'logout') {
            logoutController.userlogOut();
          } else {
            webController.generateWebUrl('Profile.aspx', 'Profile');
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem<String>(
              value: 'Profile',
              child: ListTile(
                leading: Icon(Icons.person, color: AppColors.primarycolor),
                title: Text('Profile'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'logout',
              child: ListTile(
                leading: Icon(Icons.logout, color: AppColors.primarycolor),
                title: Text('Logout'),
              ),
            ),
          ];
        },
      ),
      // PopupMenuButton<String>(
      //   icon: Badge(
      //     label: Text("1"),
      //     child: const Icon(
      //       Icons.notifications,
      //       color: Colors.white,
      //     ),
      //   ),
      //   onSelected: (String value) {
      //     // Handle notification item selectio
      //   },
      //   itemBuilder: (BuildContext context) {
      //     return List<PopupMenuEntry<String>>.generate(
      //       5,
      //       (int index) => PopupMenuItem<String>(
      //         value: 'Notification $index',
      //         child: ListTile(
      //           leading: const Icon(Icons.notifications),
      //           title: Text('Notification $index'),
      //           subtitle: Text('this is detail $index'),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    ],
  );
}
