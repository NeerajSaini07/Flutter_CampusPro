// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:campuspro/Controllers/fcm_token_controller.dart';
import 'package:campuspro/Modal/weburl_model.dart';
import 'package:campuspro/Repository/gerenateurl_repository.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:get/get.dart';

class WebController extends GetxController {
  var currentUrl = ''.obs;
  var pageLoader = false.obs;

  Future<void> initializeWebViewController(url) async {
    currentUrl.value = url;
  }

  // **************************************** redirecting to web app ******************

  gotoWebview(url) async {
    await initializeWebViewController(url);
    print("comming on this method");
    currentUrl.value = url;
    Get.toNamed(Routes.webview);
  }

  // ******************************** generating url  foer web

  generateWebUrl(pageurl, pageName) async {
    final FcmTokenController fcmTokenController = Get.put(FcmTokenController());
    currentUrl.value = '';
    await fcmTokenController.getFCMToken();
    await GenerateUrlRepository.getGenerateUrl(pageurl, pageName).then((value) {
      if (value != null) {
        WebUrlModel webUrlModel = WebUrlModel.fromJson(value);
        WebUrlList.urlListProperties = [webUrlModel];
        gotoWebview(WebUrlList.urlListProperties[0].url);
        currentUrl.value = WebUrlList.urlListProperties[0].url.toString();
      }
    });
  }
}
