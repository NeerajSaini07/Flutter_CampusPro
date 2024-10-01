// ignore_for_file: non_constant_identifier_names

import 'package:campuspro/Controllers/login_controller.dart';
import 'package:campuspro/Services/AppUpdate/app_update_checker_service.dart';
import 'package:campuspro/Services/InternetConnection/internet_connectivity.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../localdatabase/db_helper.dart';

class SplashScreenController extends GetxController {
  void redirectslash_screen(BuildContext context) async {
    final Sharedprefdata sharedprefdata = Sharedprefdata();

    final AppUpdateCheckerService appUpdateChecker =
        Get.put(AppUpdateCheckerService());

    final databaseManager = DatabaseManager();
    databaseManager.initWinDB();
    final LoginController loginController = Get.find<LoginController>();
    appUpdateChecker.appupdatechecker(context);
    bool value =
        (await sharedprefdata.getbooleandata(Sharedprefdata.loginKey)) ?? false;

    await Future.delayed(const Duration(milliseconds: 500), () async {
      if (value == true) {
        await loginController.userLogin();

        Get.offNamed(Routes.userType);
      } else {
        Get.offNamed(Routes.login);
      }
    });

    appUpdateChecker.appupdatechecker(context);
  }
}
