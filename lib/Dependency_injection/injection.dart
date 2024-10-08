import 'package:campuspro/Controllers/forgotpassword_controller.dart';
import 'package:campuspro/Controllers/internet_controller.dart';
import 'package:campuspro/Controllers/logout_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Controllers/login_controller.dart';
import 'package:campuspro/Controllers/splash_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
    Get.lazyPut<UserTypeController>(() => UserTypeController());
    Get.lazyPut<LogoutController>(() => LogoutController());
    // Get.lazyPut<InternetController>(() => InternetController());

    Get.lazyPut<WebController>(() => WebController());
  }
}
