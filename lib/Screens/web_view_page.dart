import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/logout_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/urlLuncher/web_url_luncher.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controllers/bottombar_controller.dart';
import '../Controllers/web_controller.dart';

class WebViewDashboardPage extends StatelessWidget {
  const WebViewDashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    late InAppWebViewController webViewController;

    final BottomBarController bottomBarController =
        Get.find<BottomBarController>();

    final UserTypeController userTypeController =
        Get.find<UserTypeController>();
    final WebController webController = Get.find<WebController>();
    final AppbarController appbarController = Get.find<AppbarController>();

    final LogoutController logoutController = Get.find<LogoutController>();

    String extractPhoneNumber(String url) {
      final RegExp phoneRegExp = RegExp(r'tel:(\d+)');
      final Match? match = phoneRegExp.firstMatch(url);
      return match != null ? match.group(1) ?? '' : '';
    }

    return Obx(() {
      if (webController.currentUrl.isNotEmpty) {
        return InAppWebView(
            key: ValueKey(webController.currentUrl.value),
            initialUrlRequest:
                URLRequest(url: WebUri("${webController.currentUrl.value}")),
            // initialSettings: InAppWebViewSettings(
            //     useHybridComposition: true, useOnDownloadStart: true),
            initialOptions: InAppWebViewGroupOptions(
              android: AndroidInAppWebViewOptions(
                  domStorageEnabled: true,
                  databaseEnabled: true,
                  allowFileAccess: true,
                  disableDefaultErrorPage: true,
                  allowContentAccess: true,
                  geolocationEnabled: true,
                  thirdPartyCookiesEnabled: true,
                  useHybridComposition: true,
                  loadsImagesAutomatically: true),
              crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  cacheEnabled: true,
                  useShouldOverrideUrlLoading: true,
                  allowFileAccessFromFileURLs: true,
                  allowUniversalAccessFromFileURLs: true,
                  javaScriptCanOpenWindowsAutomatically: true,
                  useOnDownloadStart: true),
            ),
            onReceivedError: (controller, request, error) {
              if (request.url.host.contains('meet.google.com') ||
                  request.url.toString().contains('tel:')) {
                controller.goBack();
              }
            },
            onWebViewCreated: (InAppWebViewController controller) =>
                webViewController = controller,
            onLoadStart: (InAppWebViewController controller, Uri? url) async {
              if (url != null &&
                  (url.host.contains('meet.google.com') ||
                      url.toString().contains('tel:'))) {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: extractPhoneNumber(url.toString()),
                );
                if (await canLaunchUrl(launchUri)) {
                  await launchUrl(launchUri);
                } else {
                  throw 'Could not launch ${url.toString()}';
                }
              } else if (url.toString().contains("/Student/OnlineTest.aspx")) {
                UrlLuncher.launchUrls(url.toString());
                appbarController.appBarName.value = Constant.schoolName;
                webController.currentUrl.value = url.toString();
                webController.showWebViewScreen.value = false;
                webController.generateWebUrl('Index.aspx', 'Dashboard');
                bottomBarController.selectedBottomNavIndex.value = 0;
                bottomBarController.webviewpage.value = false;
              } else if (url.toString().contains("Student/Account.aspx") &&
                  UserTypeslist
                          .userTypesDetails[userTypeController.usertypeIndex]
                          .isPaymentPageOpenInChrome ==
                      '1') {
                UrlLuncher.launchUrls(url.toString());
                appbarController.appBarName.value = Constant.schoolName;
                webController.currentUrl.value = url.toString();
                webController.generateWebUrl('Index.aspx', 'Dashboard');
              } else {}
            },
            onLoadStop: (InAppWebViewController controller, Uri? url) async {
              await controller.evaluateJavascript(
                  source:
                      "window.localStorage.setItem('key', 'localStorage value!')");
              if (url
                  .toString()
                  .contains("https://app.campuspro.in/Login.aspx")) {
                Get.offAllNamed(Routes.userType);
              }
              controller.addJavaScriptHandler(
                  handlerName: 'downloadPDF',
                  callback: (args) async {
                    final pdfUrl = args[0];
                    if (await canLaunchUrl(Uri.parse(pdfUrl))) {
                      await launchUrl(Uri.parse(pdfUrl),
                          mode: LaunchMode.externalApplication);
                    } else {
                      throw 'Could not launch $pdfUrl';
                    }
                  });
            },
            onDownloadStartRequest: (
              controller,
              url,
            ) async {
              // await downloadFile(url.url.toString(), context);
              final String _urlFiles = "${url.url}";
              void _launchURLFiles() async => await canLaunchUrl(
                    Uri.parse(_urlFiles),
                  )
                      ? await launchUrl(
                          Uri.parse(_urlFiles),
                          mode: LaunchMode.externalApplication,
                        )
                      : throw 'Could not launch $_urlFiles';
              _launchURLFiles();
            },
            shouldOverrideUrlLoading: (controller, action) async {
              if (action.request.url.toString().contains("phonepe://") ||
                  action.request.url.toString().contains("tez://") ||
                  action.request.url.toString().contains("paytmmp://")) {
                return NavigationActionPolicy.CANCEL;
              } else if (action.request.url != null &&
                  (action.request.url!.host.contains('meet.google.com') ||
                      action.request.url!.toString().contains('tel:'))) {
                launchUrl(
                  Uri.parse(action.request.url!.toString()),
                  mode: LaunchMode.externalApplication,
                );
                return NavigationActionPolicy.CANCEL;
              } else if (action.request.url.toString().contains("login.aspx")) {
                logoutController.userlogOut();
                return NavigationActionPolicy.CANCEL;
              }
              return NavigationActionPolicy.ALLOW;
            });
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
