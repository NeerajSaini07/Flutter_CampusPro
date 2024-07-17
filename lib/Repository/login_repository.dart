import 'package:campuspro/Controllers/login_controller.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../Services/ApiService/Data/Network/network_api_service.dart';

class LoginRepository {
  static Future<dynamic> userLoginRepo() async {
    final LoginController loginController = Get.find<LoginController>();

    const url = APIENDPOINT.loginApi;

    final data = {
      "MobileNo": loginController.mobileNumber.value,
      "Pass": loginController.passWord.value
    };
    BaseApiServices apiServices = NetworkApiServices();
    try {
      dynamic response = await apiServices
          .postApiRequest(data, url)
          .onError((error, stackTrace) {
        if (kDebugMode) {
          print(error);
        }
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
