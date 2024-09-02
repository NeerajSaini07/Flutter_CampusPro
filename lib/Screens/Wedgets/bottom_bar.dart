import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customBottomNavBar(int currentIndex, Function(int) onTap) {
  final BottomBarController bottomBarController =
      Get.find<BottomBarController>();

  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: onTap,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    selectedItemColor: AppColors.appbuttonColor,
    backgroundColor: Colors.white,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Image.asset('assets/images/home.png', width: 24, height: 22),
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Image.asset('assets/images/switchuser.png',
              width: 24, height: 24),
        ),
        label: 'User',
      ),
      if (bottomBarController.showChat.value)
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset('assets/images/chat.png', width: 24, height: 24),
          ),
          label: 'Chat',
        ),
      BottomNavigationBarItem(
        icon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child:
              Image.asset('assets/images/helpdesk.png', width: 24, height: 24),
        ),
        label: 'Help & Support',
      ),
    ],
  );
}
