import 'package:campuspro/Utilities/routes.dart';
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

  void _updateConnectionStatus(List<ConnectivityResult> result) {
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
      _navigateBack();
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
    if (currentRoute != Routes.splash && currentRoute != Routes.login) {
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
