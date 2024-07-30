import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
            child: Image.asset('assets/images/helpdesk.png',
                width: 24, height: 24),
          ),
          label: 'Help & Support',
        ),
      ],
      currentIndex: widget.currentIndex,
      selectedItemColor: AppColors.appbuttonColor,
      backgroundColor: Colors.white,
      onTap: widget.onTap,
    );
  }
}
