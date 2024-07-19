//ignore_for_file: unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  RxBool internetChecker = false.obs;

  networkConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      internetChecker.value = true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      internetChecker.value = true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      internetChecker.value = true;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      internetChecker.value = true;
    } else {
      internetChecker.value = false;
    }
  }
}
