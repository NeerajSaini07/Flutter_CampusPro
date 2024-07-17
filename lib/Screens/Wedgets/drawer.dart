// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'dart:io' show Platform;
import 'package:campuspro/Controllers/logout_controller.dart';
import 'package:campuspro/Modal/drawer_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/Wedgets/custom_width.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/drawer_image.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
Widget AppDrawer(BuildContext context) {
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
          accountEmail: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    UserTypeslist.userTypesDetails[0].schoolName.toString(),
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.offAllNamed(Routes.userType);
                  },
                  child: Image.asset(
                    Constant.switchAccountIcon,
                    height: 28.h,
                    width: 28.w,
                  ),
                ),
                customWidth(6.w)
              ]),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: buildMenuItems(),
          ),
        ),
        Divider(),
        appLogOut(),
        Padding(
          padding: EdgeInsets.only(bottom: Platform.isAndroid ? 6.w : 16.w),
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

List<Widget> buildMenuItems() {
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
              if (kDebugMode) {
                print(subMenuItem.nevigateUrl);
              }
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
          // Handle menu item tap
        },
      );
    }
  }).toList();
}

Widget appLogOut() {
  final LogoutController logoutController = Get.find<LogoutController>();
  return InkWell(
    onTap: () {
      logoutController.userlogOut();
    },
    child: ListTile(
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
    ),
  );
}
