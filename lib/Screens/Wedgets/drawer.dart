// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/drawer_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';

import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/drawer_image.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
Widget AppDrawer(BuildContext context) {
  final WebController webController = Get.find<WebController>();
  return Drawer(
    backgroundColor: AppColors.loginscafoldcoolr,
    child: Column(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: AppColors.appbuttonColor),
          margin: EdgeInsets.zero,
          currentAccountPicture: CircleAvatar(
            child: Icon(Icons.access_time_rounded),
          ),
          accountName: Text(
            UserTypeslist.userTypesDetails[0].stuEmpName.toString(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          accountEmail: Text(
            UserTypeslist.userTypesDetails[0].schoolName.toString(),
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: buildMenuItems(context, webController),
          ),
        ),
        Divider(),
        appLogOut(),
        Padding(
          padding: EdgeInsets.only(bottom: 14.w),
          child: Text(
            "Powerd by CampusPro",
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xffffc107)),
          ),
        )
      ],
    ),
  );
}

List<Widget> buildMenuItems(BuildContext context, WebController webController) {
  return MenuItemList.menuItemDetails.map((menuItem) {
    if (menuItem.subMenu != null && menuItem.subMenu!.isNotEmpty) {
      return ExpansionTile(
        iconColor: Colors.white,
        backgroundColor: AppColors.appbuttonColor,
        leading: Image.asset(
          DrawerImages.getImage(menuItem.menuName ?? ''),
          height: 26,
          width: 26,
        ),
        title: Text(
          menuItem.menuName ?? 'No Menu Name',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        children: menuItem.subMenu!.map((subMenuItem) {
          return ListTile(
            leading: Image.asset(
              DrawerImages.getImage(subMenuItem.subMenuName ?? ''),
              height: 26,
              width: 26,
            ),
            title: Text(
              subMenuItem.subMenuName ?? 'No Submenu Name',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              webController.appBarName.value =
                  subMenuItem.subMenuName.toString();
              Navigator.pop(context);
              webController.generateWebUrl(
                  subMenuItem.nevigateUrl, subMenuItem.subMenuName);
              // Handle submenu tap
            },
          );
        }).toList(),
      );
    } else {
      return ListTile(
        leading: Image.asset(
          DrawerImages.getImage(menuItem.menuName ?? ''),
          height: 26,
          width: 26,
        ),
        title: Text(
          menuItem.menuName ?? 'No Menu Name',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        onTap: () {
          webController.appBarName.value = menuItem.menuName.toString();
          Navigator.pop(context);
          webController.generateWebUrl(menuItem.menuUrl, menuItem.menuName);
        },
      );
    }
  }).toList();
}

Widget appLogOut() {
  return ListTile(
    leading: Icon(
      Icons.logout,
      color: Colors.white,
    ),
    trailing: Icon(
      Icons.keyboard_arrow_right,
      color: Colors.white,
    ),
    title: Text(
      "Logout",
      style: TextStyle(
          fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
