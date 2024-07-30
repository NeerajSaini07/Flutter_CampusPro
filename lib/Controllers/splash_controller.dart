// ignore_for_file: non_constant_identifier_names

import 'package:campuspro/Controllers/login_controller.dart';
import 'package:campuspro/Services/InternetConnection/internet_connectivity.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  void redirectslash_screen() async {
    final Sharedprefdata sharedprefdata = Sharedprefdata();
    final ConnectivityService connectivityService =
        Get.find<ConnectivityService>();
    final LoginController loginController = Get.find<LoginController>();
    bool value =
        (await sharedprefdata.getbooleandata(Sharedprefdata.loginKey)) ?? false;
    await Future.delayed(const Duration(seconds: 3), () async {
      if (value == true) {
        await loginController.userLogin();

        connectivityService.isConnected.value
            ? Get.offNamed(Routes.userType)
            : Get.offAllNamed(Routes.noInternet);
      } else {
        Get.offNamed(Routes.login);
      }
    });
  }
}
