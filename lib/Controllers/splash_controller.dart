// ignore_for_file: non_constant_identifier_names

import 'package:campuspro/Controllers/login_controller.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  //final InternetController internetController = Get.find<InternetController>();
  @override
  void onInit() {
    super.onInit();
    // internetController.networkConnectivity();
    redirectslash_screen();
  }

  void redirectslash_screen() async {
    final Sharedprefdata sharedprefdata = Sharedprefdata();
    final LoginController loginController = Get.find<LoginController>();
    bool value =
        (await sharedprefdata.getbooleandata(Sharedprefdata.loginKey)) ?? false;
    await Future.delayed(const Duration(seconds: 3), () async {
      if (value == true) {
        await loginController.userLogin();

        Get.offNamed(Routes.userType);
      } else {
        Get.offNamed(Routes.login);
      }
    });
  }
}
