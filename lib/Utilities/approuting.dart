import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/bus_tracker_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Services/urlLuncher/web_url_luncher.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRouting extends GetxService {
  final BusTrackerController busTrackerController =
      Get.find<BusTrackerController>();

  final WebController webController = Get.find<WebController>();
  final AppbarController appbarController = Get.find<AppbarController>();
  final BottomBarController bottomBarController =
      Get.find<BottomBarController>();

  navigate(name, pageurl, BuildContext context) async {
    switch (name) {
      case "Student Bus Location":
        await busTrackerController.getBusAllot(context);
        break;
      case "Visitor x New":
        Navigator.pushNamed(context, Routes.visitorHistory);
        break;
      case "G":
        Navigator.pushNamed(context, Routes.visitorHistory);
        break;

      case "Go to Site":
        UrlLuncher.launchUrls(pageurl);
        break;

      default:
        if (pageurl == '') {
          pageurl = 'Index.aspx';
          appbarController.appBarName.value = Constant.schoolName;
        } else {
          webController.generateWebUrl(pageurl, name);
          appbarController.appBarName.value = name;
        }
        break;
    }
  }
}
