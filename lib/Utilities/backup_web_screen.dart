// // ignore_for_file: prefer_const_constructors

// import 'package:campuspro/Controllers/appbar_controller.dart';
// import 'package:campuspro/Controllers/web_controller.dart';
// import 'package:campuspro/Screens/Wedgets/drawer.dart';
// import 'package:campuspro/Screens/Wedgets/nev_bar.dart';
// import 'package:campuspro/Screens/bus_tracker_screen.dart';
// import 'package:campuspro/Utilities/colors.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewScreen extends StatefulWidget {
//   const WebViewScreen({super.key});

//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }

// class _WebViewScreenState extends State<WebViewScreen> {
//   @override
//   Widget build(BuildContext context) {
//     late InAppWebViewController webViewController;
//     final WebController webController = Get.find<WebController>();
//      final AppbarController appbarController = Get.find<AppbarController>();

//     return PopScope(
//       canPop: true,
//       child: Scaffold(
//         appBar: customAppBar(context),
//         bottomNavigationBar: Obx(
//           () => BottomNavBar(
//             currentIndex: webController.selectedBottomNavIndex.value,
//             onTap: webController.onItemTappedChangeBottomNavIndex,
//           ),
//         ),
//         drawer: AppDrawer(context),
//         body: Obx(() {
//           if (webController.currentUrl.isNotEmpty) {
//             return InAppWebView(
//               initialUrlRequest:
//                   URLRequest(url: WebUri("${webController.currentUrl.value}")),
//               // initialHeaders: {},
//               initialSettings: InAppWebViewSettings(
//                 useHybridComposition: true,
//                 geolocationEnabled: true,
//                 disableDefaultErrorPage: true,
//                 useOnDownloadStart: true,
//                 cacheEnabled: true,
//                 thirdPartyCookiesEnabled: true,
//                 databaseEnabled: true,
//                 domStorageEnabled: true,
//               ),
//               onWebViewCreated: (InAppWebViewController controller) =>
//                   webViewController = controller,
//               onLoadStart: (InAppWebViewController controller, Uri? url) {},
//               onLoadStop: (InAppWebViewController controller, Uri? url) async {
//                 await controller.evaluateJavascript(
//                     source:
//                         "window.localStorage.setItem('key', 'localStorage value!')");
//                 // await controller.evaluateJavascript(
//                 //     source: "alert(window.localStorage.getItem('key'))");
//               },
//               shouldOverrideUrlLoading: (controller, action) async {
//                 print(
//                     "shouldOverrideUrlLoading >>>>>>: ${action.request.url?.host}");
//                 if (action.request.url != null &&
//                     (action.request.url!.host.contains('meet.google.com') ||
//                         action.request.url!.toString().contains('tel:'))) {
//                   // launchUrl(
//                   //   Uri.parse(action.request.url!.toString()),
//                   //   mode: LaunchMode.externalApplication,
//                   // );
//                   return NavigationActionPolicy.CANCEL;
//                 }
//                 return NavigationActionPolicy.ALLOW;
//               },
//               onDownloadStartRequest: (
//                 controller,
//                 url,
//               ) async {
//                 print("onDownloadStart ${url.url}");
//                 final String _urlFiles = "${url.url}";
//                 void _launchURLFiles() async => await canLaunchUrl(
//                       Uri.parse(_urlFiles),
//                     )
//                         ? await launchUrl(Uri.parse(_urlFiles))
//                         : throw 'Could not launch $_urlFiles';
//                 _launchURLFiles();
//               },
//             );
//             // webController.viewcontroller.value!
//             //     .loadRequest(Uri.parse(webController.currentUrl.value));

//             // return WebViewWidget(
//             //     controller: webController.viewcontroller.value!);
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         }),
//       ),
//     );
//   }

//   AppBar customAppBar(BuildContext context) {
//     final WebController webController = Get.find<WebController>();
//     return AppBar(
//       backgroundColor: AppColors.primarycolor, // Change to your desired color
//       centerTitle: false,
//       title: Obx(
//         () => Text(
//           appbarController.appBarName.toString(),
//           style: TextStyle(
//             color: Colors.white, // Change to your desired title color
//             fontSize: 20, // Change to your desired font size
//             fontWeight: FontWeight.bold, // Change to your desired font weight
//           ),
//         ),
//       ),
//       iconTheme: const IconThemeData(color: Colors.white),
//       actions: [
//         PopupMenuButton<String>(
//           icon: Image.asset(
//             'assets/images/person_icon.png',
//             width: 24,
//             height: 24,
//           ),
//           onSelected: (value) {
//             // Navigator.push(
//             //     context,

//             //     MaterialPageRoute(
//             //       builder: (context) => BusTrackerScreen(),
//             //     ));
//           },
//           itemBuilder: (BuildContext context) {
//             return [
//               const PopupMenuItem<String>(
//                 value: 'change_password',
//                 child: ListTile(
//                   leading: Icon(Icons.lock, color: AppColors.primarycolor),
//                   title: Text('Change Password'),
//                 ),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'logout',
//                 child: ListTile(
//                   leading: Icon(Icons.logout, color: AppColors.primarycolor),
//                   title: Text('Logout'),
//                 ),
//               ),
//             ];
//           },
//         ),
//         PopupMenuButton<String>(
//           icon: Badge(
//             label: Text("1"),
//             child: const Icon(
//               Icons.notifications,
//               color: Colors.white,
//             ),
//           ),
//           onSelected: (String value) {
//             // Handle notification item selection
//             print('Selected: $value');
//           },
//           itemBuilder: (BuildContext context) {
//             return List<PopupMenuEntry<String>>.generate(
//               5,
//               (int index) => PopupMenuItem<String>(
//                 value: 'Notification $index',
//                 child: ListTile(
//                   leading: const Icon(Icons.notifications),
//                   title: Text('Notification $index'),
//                   subtitle: Text('this is detail $index'),
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
