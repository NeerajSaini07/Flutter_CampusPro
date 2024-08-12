import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/bus_tracker_controller.dart';
import 'package:campuspro/Controllers/change_password_controller.dart';
import 'package:campuspro/Controllers/exception_controller.dart';
import 'package:campuspro/Controllers/fcm_token_controller.dart';
import 'package:campuspro/Controllers/forgotpassword_controller.dart';
import 'package:campuspro/Controllers/getpassController.dart';
import 'package:campuspro/Controllers/help_and_support_controller.dart';

import 'package:campuspro/Controllers/logout_controller.dart';
import 'package:campuspro/Controllers/transport_studentlist_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Controllers/login_controller.dart';
import 'package:campuspro/Controllers/splash_controller.dart';
import 'package:get/get.dart';
import 'package:campuspro/Controllers/web_controller.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());

    Get.lazyPut<LoginController>(() => LoginController());

    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());

    Get.lazyPut<UserTypeController>(() => UserTypeController());

    Get.lazyPut<LogoutController>(() => LogoutController());

    Get.lazyPut<ExceptionController>(() => ExceptionController());

    Get.lazyPut<WebController>(() => WebController());

    Get.lazyPut<FcmTokenController>(() => FcmTokenController());

    Get.lazyPut<BusTrackerController>(() => BusTrackerController());

    Get.lazyPut<GetPassController>(() => GetPassController());

    Get.lazyPut<TransportStudentListController>(
        () => TransportStudentListController());

    Get.lazyPut<AppbarController>(() => AppbarController());

    Get.lazyPut<BottomBarController>(() => BottomBarController());

    Get.lazyPut<HelpAndSupportController>(() => HelpAndSupportController());

    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}
