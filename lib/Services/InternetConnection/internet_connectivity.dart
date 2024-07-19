import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  var isConnected = true.obs;
  String? previousRoute;

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
    bool wasConnected = isConnected.value;
    isConnected.value = _isConnected(result);
    if (!isConnected.value && wasConnected) {
      // Get.snackbar(
      //   'No Internet Connection',
      //   'Please check your internet settings.',
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      _navigateToNoInternetScreen();
    } else if (isConnected.value && !wasConnected && previousRoute != null) {
      if (previousRoute == Routes.webview) {
        final UserTypeController userTypeController =
            Get.find<UserTypeController>();
        final WebController webController = Get.find<WebController>();
        final usertypeIndex =
            await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
        userTypeController.gotoDashBorad(
            webController.currentUrl.value.toString(),
            {usertypeIndex.toString(): usertypeIndex});
      } else {
        _navigateBack();
      }
    }
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
}
