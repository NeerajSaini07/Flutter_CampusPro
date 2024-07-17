// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Screens/Wedgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DashBoradScreen extends StatelessWidget {
  const DashBoradScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WebController webController = Get.find<WebController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("DashBoard"),
      ),
      drawer: AppDrawer(context),
      body: Obx(() {
        if (webController.currentUrl.isNotEmpty) {
          webController.viewcontroller.value!
              .loadRequest(Uri.parse(webController.currentUrl.value));
          return WebViewWidget(controller: webController.viewcontroller.value!);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
