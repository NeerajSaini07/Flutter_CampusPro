// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_local_variable, deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/help_and_support_screen.dart';
import 'package:campuspro/Screens/new_help_and_support.dart';
import 'package:campuspro/Screens/user_type_screen.dart';
import 'package:campuspro/Screens/web_view_page.dart';
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

import 'studenPortal/dashboard.dart';

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

    final UserTypeController userTypeController =
        Get.find<UserTypeController>();

    final List<Widget> screens = [
      UserTypeslist.userTypesDetails[userTypeController.usertypeIndex]
                  .ouserType ==
              'S'
          ? StudentDashboad()
          : WebViewDashboardPage(),
      UserTypeScreen(),
      if (bottomBarController.showChat.value) WebViewDashboardPage(),
      HelpAndSupportScreen(),
    ];

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
          () => customBottomNavBar(
              bottomBarController.selectedBottomNavIndex.value,
              bottomBarController.onItemTappedChangeBottomNavIndex),
        ),
        drawer: AppDrawer(context),
        body: Obx(
            () => screens[bottomBarController.selectedBottomNavIndex.value]),
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
