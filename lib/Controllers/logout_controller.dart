import 'package:campuspro/Controllers/fcm_token_controller.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  Future<void> userlogOut() async {
    final FcmTokenController fcmTokenController =
        Get.find<FcmTokenController>();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await fcmTokenController.removeFCMToken();
    prefs.clear();
    Get.offAllNamed(Routes.login);
  }
}
