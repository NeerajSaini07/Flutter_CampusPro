// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_local_variable, deprecated_member_use, avoid_print, unnecessary_null_comparison

import 'dart:developer';

import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/drawer.dart';
import 'package:campuspro/Screens/Wedgets/bottom_bar.dart';
import 'package:campuspro/Utilities/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    late InAppWebViewController webViewController;
    final WebController webController = Get.find<WebController>();
    final BottomBarController bottomBarController =
        Get.find<BottomBarController>();

    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: customAppBar(context),
        bottomNavigationBar: Obx(
          () => BottomNavBar(
            currentIndex: bottomBarController.selectedBottomNavIndex.value,
            onTap: bottomBarController.onItemTappedChangeBottomNavIndex,
          ),
        ),
        drawer: AppDrawer(context),
        body: Obx(() {
          if (webController.currentUrl.isNotEmpty) {
            return InAppWebView(
              initialUrlRequest:
                  URLRequest(url: WebUri("${webController.currentUrl.value}")),
              initialOptions: InAppWebViewGroupOptions(
                android: AndroidInAppWebViewOptions(useHybridComposition: true),
                crossPlatform: InAppWebViewOptions(useOnDownloadStart: true),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webViewController = controller;
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url;
                if (uri != null && uri.scheme == 'tel') {
                  await _launchURL(uri.toString());
                  return NavigationActionPolicy.CANCEL;
                }
                return NavigationActionPolicy.ALLOW;
              },
              onLoadStart:
                  (InAppWebViewController controller, Uri? url) async {},
              onLoadStop: (InAppWebViewController controller, Uri? url) async {
                if (url
                    .toString()
                    .contains("https://app.campuspro.in/Login.aspx")) {
                  Get.offAllNamed(Routes.userType);
                }
              },
              onDownloadStartRequest: (controller, url) async {
                final String _urlFiles = "${url.url}";
                if (await canLaunch(_urlFiles)) {
                  await launch(_urlFiles);
                } else {
                  throw 'Could not launch $_urlFiles';
                }
              },
              onReceivedError: (controller, request, error) async {
                if (request.url.toString().contains('tel')) {
                  _launchURL(request.url.toString());
                }
                var uri = request.url;
                if (uri.scheme == 'tel') {
                  await _launchURL(uri.toString());
                  //return NavigationActionPolicy.CANCEL;
                }
                // return NavigationActionPolicy.ALLOW;
              },
            );

            // // return WebViewWidget(
            // //     controller: webController.viewcontroller.value!);
            //     initialUrlRequest: URLRequest(
            //         url: WebUri("${webController.currentUrl.value}")),
            //     // initialSettings: InAppWebViewSettings(
            //     //     useHybridComposition: true, useOnDownloadStart: true),
            //     initialOptions: InAppWebViewGroupOptions(
            //       android:
            //           AndroidInAppWebViewOptions(useHybridComposition: true),
            //       crossPlatform: InAppWebViewOptions(
            //           // debuggingEnabled: true,
            //           useOnDownloadStart: true),
            //     ),
            //     onWebViewCreated: (InAppWebViewController controller) =>
            //         webViewController = controller,
            //     onLoadStop:
            //         (InAppWebViewController controller, Uri? url) async {
            //       if (url
            //           .toString()
            //           .contains("https://app.campuspro.in/Login.aspx")) {
            //         Get.offAllNamed(Routes.userType);
            //       }
            //     },
            //     shouldOverrideUrlLoading: (controller, action) async {
            //       return NavigationActionPolicy.ALLOW;
            //     });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri launchUri = Uri(
      path: url,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
