import 'package:campuspro/Controllers/bus_tracker_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRouting extends GetxService {
  final BusTrackerController busTrackerController =
      Get.find<BusTrackerController>();

  final WebController webController = Get.find<WebController>();

  navigate(name, pageurl, BuildContext context) async {
    switch (name) {
      case "Student Bus Location":
        await busTrackerController.getBusAllot(context);
        break;
      case "Visitor x New":
        Navigator.pushNamed(context, Routes.visitorHistory);
        break;
      case "G x":
        Navigator.pushNamed(context, Routes.visitorHistory);
        break;
      default:
        // Handle unknown actions or provide a default action

        webController.generateWebUrl(pageurl, name);
        break;
    }
  }
}
