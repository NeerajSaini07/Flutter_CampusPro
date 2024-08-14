// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'dart:io' show Platform;
import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/logout_controller.dart';
import 'package:campuspro/Controllers/transport_studentlist_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/drawer_model.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/approuting.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/drawer_image.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
Widget AppDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: AppColors.loginscafoldcoolr,
    child: Column(
      children: [
        Container(
          height: 160.h,
          decoration: BoxDecoration(color: AppColors.appbuttonColor),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomeHeight(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                  ],
                ),
                CircleAvatar(
                  radius: 20.w,
                  backgroundImage: AssetImage(Constant.companylogo),
                ),
                CustomeHeight(5.h),
                Text(
                  Constant.schoolName,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: buildMenuItems(context),
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

List<Widget> buildMenuItems(BuildContext context) {
  final webController = Get.find<WebController>();

  Get.lazyPut<TransportStudentListController>(
      () => TransportStudentListController());

  final appbarController = Get.find<AppbarController>();

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
        children: menuItem.subMenu!
            .where(
                (subMenuItem) => menuItem.menuName != subMenuItem.subMenuName)
            .map((subMenuItem) {
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
            onTap: () async {
              final AppRouting appRouting = AppRouting();
              print(subMenuItem.subMenuName);
              appRouting.navigate(
                  subMenuItem.subMenuName, subMenuItem.nevigateUrl, context);
              Navigator.pop(context);

              appbarController.appBarName.value =
                  subMenuItem.subMenuName.toString();
              // final AppRouting appRouting = AppRouting();
              // Navigator.pop(context);
              // final action = await appRouting.navigate(
              //     subMenuItem.subMenuName.toString().toLowerCase(), context);

              // if (action != null) {
              //   action(context);
              // } else {
              //   webController.generateWebUrl(
              //       subMenuItem.nevigateUrl, subMenuItem.subMenuName);
              // }
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
          onTap: () async {
            // final usertypeIndex = await Sharedprefdata.getIntegerData(
            //     Sharedprefdata.userTypeIndex);
            final AppRouting appRouting = AppRouting();
            if (menuItem.menuName != "Go to Site") {
              appbarController.appBarName.value = menuItem.menuName.toString();
            }
            appRouting.navigate(menuItem.menuName, menuItem.menuUrl, context);
            Navigator.pop(context);
            if (context.mounted) {
              // if (menuItem.menuName.toString().toLowerCase() == "dashboard" &&
              //     UserTypeslist.userTypesDetails[usertypeIndex].ouserType
              //             .toString()
              //             .toLowerCase() ==
              //         "t") {
              //   Get.to(() => TransportStudentList());
              // } else if (menuItem.menuName.toString().toLowerCase() ==
              //         "dashboard" &&
              //     UserTypeslist.userTypesDetails[usertypeIndex].ouserType
              //             .toString() ==
              //         "G") {
              //   Navigator.pop(context);
              //   Get.toNamed(Routes.visitorHistory);
              // } else {
              //   final AppRouting appRouting = AppRouting();

              //   appRouting.navigate(
              //       menuItem.menuName, menuItem.menuUrl, context);
              //   Navigator.pop(context);

              //   // print("ferer");
              //   // final AppRouting appRouting = AppRouting();
              //   // final action = await appRouting.navigate(
              //   //     menuItem.menuName.toString(), context);
              //   // if (action != null) {
              //   //   action(context);
              //   // } else {
              //   //   appbarController.appBarName.value =
              //   //       menuItem.menuName.toString();
              //   //   Navigator.pop(context);
              //   //   webController.generateWebUrl(
              //   //       menuItem.menuUrl, menuItem.menuName);
              //   // }
              // }
            }
          }
          // onTap: () {
          //   if (menuItem.menuName == 'Visitor New') {
          //     Navigator.pushNamed(context, Routes.visitorHistory);
          //   } else if (menuItem.menuName == 'Student Bus Location') {
          //     busTrackerController.getBusAllot(context);
          //     Navigator.pop(context);
          //   } else {
          //     webController.appBarName.value = menuItem.menuName.toString();
          //     Navigator.pop(context);
          //     webController.generateWebUrl(menuItem.menuUrl, menuItem.menuName);
          //   }
          // },
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
