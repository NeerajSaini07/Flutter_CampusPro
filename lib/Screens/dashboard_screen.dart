// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_local_variable, deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Services/urlLuncher/web_url_luncher.dart';
import 'package:campuspro/Utilities/constant.dart';

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
  final WebController webController = Get.find<WebController>();
  final AppbarController appbarController = Get.find<AppbarController>();

  @override
  Widget build(BuildContext context) {
    late InAppWebViewController webViewController;

    final BottomBarController bottomBarController =
        Get.find<BottomBarController>();

    String extractPhoneNumber(String url) {
      final RegExp phoneRegExp = RegExp(r'tel:(\d+)');
      final Match? match = phoneRegExp.firstMatch(url);
      return match != null ? match.group(1) ?? '' : '';
    }

    return WillPopScope(
      onWillPop: () async {
        if (appbarController.appBarName.value == Constant.schoolName) {
          Get.back();
          return true;
        } else {
          appbarController.appBarName.value = Constant.schoolName;
          webController.generateWebUrl('Index.aspx', 'Dashboard');
          return false;
        }
      },
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
                } else if (url.toString().contains(
                    "https://app.campuspro.in/Student/OnlineTest.aspx")) {
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
                print("Navigating to: $url");

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
        }),
      ),
    );
  }
}






















// Future<void> downloadFile(String url, BuildContext context) async {
//       double downloadProgress = 0.0;
//       bool isDownloading = true;
//       try {
//         // Request storage permission
//         var status = await Permission.storage.request();
//         if (status.isGranted) {
//           Directory? directory;
//           if (defaultTargetPlatform == TargetPlatform.android) {
//             directory = Directory('/storage/emulated/0/Download');
//           } else {
//             directory = await getApplicationDocumentsDirectory();
//           }

//           bool hasExisted = await directory.exists();
//           if (!hasExisted) {
//             directory.create();
//           }

//           String savePath = '${directory.path}/${url.split('/').last}';

//           // Show progress dialog
//           showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (context) => AlertDialog(
//               title: Text('Downloading'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   LinearProgressIndicator(value: downloadProgress),
//                   SizedBox(height: 16),
//                   Text('${(downloadProgress * 100).toStringAsFixed(2)}%'),
//                 ],
//               ),
//             ),
//           );

//           var response =
//               await http.Client().send(http.Request('GET', Uri.parse(url)));
//           int totalBytes = response.contentLength ?? 0;
//           int receivedBytes = 0;
//           List<int> bytes = [];

//           response.stream.listen(
//             (List<int> chunk) {
//               bytes.addAll(chunk);
//               receivedBytes += chunk.length;
//               downloadProgress = receivedBytes / totalBytes;
//               // Update progress indicator
//               Navigator.of(context).pop(); // Close the previous dialog
//               showDialog(
//                 context: context,
//                 barrierDismissible: false,
//                 builder: (context) => AlertDialog(
//                   title: Text('Downloading'),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       LinearProgressIndicator(value: downloadProgress),
//                       SizedBox(height: 16),
//                       Text('${(downloadProgress * 100).toStringAsFixed(2)}%'),
//                     ],
//                   ),
//                 ),
//               );
//             },
//             onDone: () async {
//               File file = File(savePath);
//               await file.writeAsBytes(bytes);
//               Navigator.of(context).pop(); // Close progress dialog
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Download completed: File saved on downloads'),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//               log('Download complete');
//             },
//             onError: (error) {
//               Navigator.of(context).pop(); // Close progress dialog
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Failed to download file'),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//               log('Error downloading file: $error');
//             },
//             cancelOnError: true,
//           );
//         } else {
//           log('Permission denied');
//         }
//       } catch (e) {
//         log('Error downloading file: $e');
//       }
//     }
