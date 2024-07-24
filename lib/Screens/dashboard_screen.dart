// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Screens/Wedgets/drawer.dart';
import 'package:campuspro/Screens/Wedgets/nev_bar.dart';
import 'package:campuspro/Screens/bus_tracker_screen.dart';
import 'package:campuspro/Utilities/colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    final WebController webController = Get.find<WebController>();

    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: customAppBar(context),
        bottomNavigationBar: Obx(
          () => BottomNavBar(
            currentIndex: webController.selectedBottomNavIndex.value,
            onTap: webController.onItemTappedChangeBottomNavIndex,
          ),
        ),
        drawer: AppDrawer(context),
        body: Obx(() {
          if (webController.currentUrl.isNotEmpty) {
            webController.viewcontroller.value!
                .loadRequest(Uri.parse(webController.currentUrl.value));
            return WebViewWidget(
                controller: webController.viewcontroller.value!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }

  AppBar customAppBar(BuildContext context) {
    final WebController webController = Get.find<WebController>();
    return AppBar(
      backgroundColor: AppColors.primarycolor, // Change to your desired color
      centerTitle: false,
      title: Obx(
        () => Text(
          webController.appBarName.toString(),
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
            width: 24,
            height: 24,
          ),
          onSelected: (value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusTrackerScreen(),
                ));
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'change_password',
                child: ListTile(
                  leading: Icon(Icons.lock, color: AppColors.primarycolor),
                  title: Text('Change Password'),
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
        PopupMenuButton<String>(
          icon: Badge(
            label: Text("1"),
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
          onSelected: (String value) {
            // Handle notification item selection
            print('Selected: $value');
          },
          itemBuilder: (BuildContext context) {
            return List<PopupMenuEntry<String>>.generate(
              5,
              (int index) => PopupMenuItem<String>(
                value: 'Notification $index',
                child: ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Text('Notification $index'),
                  subtitle: Text('this is detail $index'),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
