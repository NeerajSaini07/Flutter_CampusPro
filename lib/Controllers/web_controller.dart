// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/fcm_token_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Modal/weburl_model.dart';
import 'package:campuspro/Repository/gerenateurl_repository.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:get/get.dart';
import '../Services/urlLuncher/web_url_luncher.dart';

class WebController extends GetxController {
  var currentUrl = ''.obs;
  var pageLoader = false.obs;

  Future<void> initializeWebViewController(url) async {
    currentUrl.value = url;
  }

  // **************************************** redirecting to web app ******************
  gotoWebview(url) async {
    await initializeWebViewController(url);
    currentUrl.value = url;
    Get.toNamed(Routes.Dashboardboard);
  }

  // ******************************** generating url  foer web

  generateWebUrl(pageurl, pageName) async {
    final AppbarController appbarController = Get.find<AppbarController>();
    final WebController webController = Get.find<WebController>();
    final FcmTokenController fcmTokenController = Get.put(FcmTokenController());

    final UserTypeController userTypeController =
        Get.find<UserTypeController>();
    currentUrl.value = '';
    await fcmTokenController.getFCMToken();
    await GenerateUrlRepository.getGenerateUrl(pageurl, pageName).then((value) {
      if (value != null) {
        WebUrlModel webUrlModel = WebUrlModel.fromJson(value);
        WebUrlList.urlListProperties = [webUrlModel];

// ******************************
//   **************  date of modification : 27-08-2024
//  *************** purpose of   modification : opening fee payment on brouwser

        if (WebUrlList.urlListProperties[0].url
                .toString()
                .contains("Student/Account.aspx") &&
            UserTypeslist.userTypesDetails[userTypeController.usertypeIndex]
                    .isPaymentPageOpenInChrome ==
                '1') {
          UrlLuncher.launchUrls(WebUrlList.urlListProperties[0].url.toString());
          appbarController.appBarName.value = Constant.schoolName;
          webController.currentUrl.value =
              WebUrlList.urlListProperties[0].url.toString();
          webController.generateWebUrl('Index.aspx', 'Dashboard');
        } else {
          appbarController.appBarName.value = pageName;
          gotoWebview(WebUrlList.urlListProperties[0].url);
          currentUrl.value = WebUrlList.urlListProperties[0].url.toString();
        }
      }
    });
  }
}
