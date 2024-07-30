import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Screens/Wedgets/custom_width.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  var isConnected = true.obs;
  var isReconnected = false.obs;
  String? previousRoute;

  final WebController webController = Get.find<WebController>();
  @override
  void onInit() {
    super.onInit();
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      _updateConnectionStatus(result);
    });
    _checkInitialConnection();
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    // bool wasConnected = isConnected.value;
    isConnected.value = _isConnected(result);

    if (isConnected.value) {
      if (Get.isBottomSheetOpen == true) {
        Get.back(); // Close the bottom sheet
      }
    } else {
      _showNoConnectionBottomSheet();
    }

    // if (!wasConnected && isConnected.value) {
    //   isReconnected.value = true;
    //   if (previousRoute == Routes.webview) {}
    // } else {
    //   isReconnected.value = false; // Reset reconnected flag
    // }

    // if (!isConnected.value && wasConnected) {
    //   _navigateToNoInternetScreen();
    // } else if (isConnected.value && !wasConnected && previousRoute != null) {
    //   if (previousRoute == Routes.webview) {
    //     webController.currentUrl.value = webController.currentUrl.value;
    //     webController.gotoWebview(webController.currentUrl.value);
    //     Get.toNamed(Routes.webview);
    //   } else {
    //     _navigateBack();
    //   }
    // }
  }

  Future<void> _checkInitialConnection() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);
  }

  bool _isConnected(List<ConnectivityResult> result) {
    return result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.ethernet) ||
        result.contains(ConnectivityResult.vpn);
  }

  void _navigateToNoInternetScreen() {
    final currentRoute = Get.currentRoute;
    if (currentRoute != Routes.splash &&
        currentRoute != Routes.login &&
        currentRoute != Routes.webview) {
      previousRoute = currentRoute;
      Get.toNamed(Routes.noInternet);
    }
  }

  void _navigateBack() {
    if (previousRoute != null && Get.currentRoute == Routes.noInternet) {
      Get.offNamed(previousRoute!);
      previousRoute = null;
    }
  }

  void _showNoConnectionBottomSheet() {
    if (Get.isBottomSheetOpen == null || Get.isBottomSheetOpen == false) {
      Get.bottomSheet(
        Container(
          width: double.infinity,
          color: AppColors.primarycolor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                const Icon(
                  Icons.wifi_off,
                  color: Colors.white,
                  size: 50,
                ),
                customWidth(12.w),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No Internet Connection',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        'Please check your internet settings.',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        isDismissible: false,
        enableDrag: false,
      );
    }
  }
}
