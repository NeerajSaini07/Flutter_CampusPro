// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_local_variable

import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/drawer.dart';
import 'package:campuspro/Screens/Wedgets/bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

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
            // webController.viewcontroller.value!
            //     .loadRequest(Uri.parse(webController.currentUrl.value));

            return InAppWebView(
                initialUrlRequest: URLRequest(
                    url: WebUri("${webController.currentUrl.value}")),
                initialSettings: InAppWebViewSettings(
                    useHybridComposition: true, geolocationEnabled: true),
                onWebViewCreated: (InAppWebViewController controller) =>
                    webViewController = controller,
                shouldOverrideUrlLoading: (controller, action) async {
                  return NavigationActionPolicy.ALLOW;
                });

            // return InAppWebView(
            //   initialUrlRequest:
            //       URLRequest(url: WebUri("${webController.currentUrl.value}")),
            //   // initialHeaders: {},
            //   initialSettings: InAppWebViewSettings(
            //     useHybridComposition: true,
            //     geolocationEnabled: true,
            //     useOnDownloadStart: true,
            //     cacheEnabled: true,
            //     thirdPartyCookiesEnabled: true,
            //     databaseEnabled: true,
            //     domStorageEnabled: true,
            //   ),
            //   onWebViewCreated: (InAppWebViewController controller) =>
            //       webViewController = controller,
            //   onLoadStart: (InAppWebViewController controller, Uri? url) {},
            //   onLoadStop: (InAppWebViewController controller, Uri? url) async {
            //     await controller.evaluateJavascript(
            //         source:
            //             "window.localStorage.setItem('key', 'localStorage value!')");
            //     // await controller.evaluateJavascript(
            //     //     source: "alert(window.localStorage.getItem('key'))");
            //   },
            //   shouldOverrideUrlLoading: (controller, action) async {
            //     print(
            //         "shouldOverrideUrlLoading >>>>>>: ${action.request.url?.host}");
            //     if (action.request.url != null &&
            //         (action.request.url!.host.contains('meet.google.com') ||
            //             action.request.url!.toString().contains('tel:'))) {
            //       // launchUrl(
            //       //   Uri.parse(action.request.url!.toString()),
            //       //   mode: LaunchMode.externalApplication,
            //       // );
            //       return NavigationActionPolicy.CANCEL;
            //     }
            //     return NavigationActionPolicy.ALLOW;
            //   },
            //   onDownloadStartRequest: (
            //     controller,
            //     url,
            //   ) async {
            //     print("onDownloadStart ${url.url}");
            //     final String _urlFiles = "${url.url}";
            //     void _launchURLFiles() async => await canLaunchUrl(
            //           Uri.parse(_urlFiles),
            //         )
            //             ? await launchUrl(Uri.parse(_urlFiles))
            //             : throw 'Could not launch $_urlFiles';
            //     _launchURLFiles();
            //   },
            // );
            // return WebViewWidget(
            //     controller: webController.viewcontroller.value!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
