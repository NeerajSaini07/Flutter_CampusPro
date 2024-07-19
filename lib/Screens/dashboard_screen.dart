// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Screens/Wedgets/drawer.dart';
import 'package:campuspro/Services/InternetConnection/internet_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iamport_webview_flutter/iamport_webview_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WebController webController = Get.find<WebController>();
    final ConnectivityService connectivityService =
        Get.find<ConnectivityService>();

    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Obx(() => Text(webController.appBarName.toString())),
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
}
