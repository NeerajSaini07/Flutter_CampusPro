import 'package:campuspro/Controllers/appbar_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    late InAppWebViewController webViewController;

    final BottomBarController bottomBarController =
        Get.find<BottomBarController>();

    final UserTypeController userTypeController =
        Get.find<UserTypeController>();
    final WebController webController = Get.find<WebController>();
    final AppbarController appbarController = Get.find<AppbarController>();

    String extractPhoneNumber(String url) {
      final RegExp phoneRegExp = RegExp(r'tel:(\d+)');
      final Match? match = phoneRegExp.firstMatch(url);
      return match != null ? match.group(1) ?? '' : '';
    }

    print(UserTypeslist.userTypesDetails[userTypeController.usertypeIndex]
        .isPaymentPageOpenInChrome);

    return Obx(() {
      if (webController.currentUrl.isNotEmpty) {
        return InAppWebView(
          key: ValueKey(webController.currentUrl.value),
          initialUrlRequest:
              URLRequest(url: WebUri("${webController.currentUrl.value}")),
          // initialSettings: InAppWebViewSettings(
          //     useHybridComposition: true, useOnDownloadStart: true),
          initialOptions: InAppWebViewGroupOptions(
            ios: IOSInAppWebViewOptions(
              allowsInlineMediaPlayback: true,
            ),
            android: AndroidInAppWebViewOptions(useHybridComposition: true),
            crossPlatform: InAppWebViewOptions(
                // debuggingEnabled: true,
                javaScriptEnabled: true,
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

              ///Student/Account.aspx?
            } else if (url.toString().contains("/Student/OnlineTest.aspx")) {
              UrlLuncher.launchUrls(url.toString());
              appbarController.appBarName.value = Constant.schoolName;
              webController.currentUrl.value = url.toString();
              webController.generateWebUrl('Index.aspx', 'Dashboard');
            } else if (url.toString().contains("Student/Account.aspx") &&
                UserTypeslist.userTypesDetails[userTypeController.usertypeIndex]
                        .isPaymentPageOpenInChrome ==
                    '1') {
              UrlLuncher.launchUrls(url.toString());
              appbarController.appBarName.value = Constant.schoolName;
              webController.currentUrl.value = url.toString();
              webController.generateWebUrl('Index.aspx', 'Dashboard');
            }
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
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            final url = navigationAction.request.url.toString();

            if (url.endsWith('.pdf')) {
              // Open the PDF using an external application
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(
                  Uri.parse(url),
                  mode: LaunchMode.externalApplication,
                );
              } else {
                throw 'Could not launch $url';
              }
              return NavigationActionPolicy.CANCEL;
            }

            return NavigationActionPolicy.ALLOW;
          },
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
