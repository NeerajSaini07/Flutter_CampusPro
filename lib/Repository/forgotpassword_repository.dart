import 'package:campuspro/Controllers/forgotpassword_controller.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ForgotPasswordRepository {
  static Future<dynamic> checkschool() async {
    const url = APIENDPOINT.sendOtpForgotPassword;

    final ForgotPasswordController forgotPasswordController =
        Get.find<ForgotPasswordController>();

    var data = {
      "Mobile": forgotPasswordController.mobileForForgotPass.value,
      "Schoolid": forgotPasswordController.selectedvalue.value.isEmpty
          ? ""
          : forgotPasswordController.selectedvalue.value,
      "OrgId": forgotPasswordController.selectedDropDownId.value.isEmpty
          ? ""
          : forgotPasswordController.selectedDropDownId.value,
    };

    BaseApiServices apiServices = NetworkApiServices();

    try {
      dynamic response = await apiServices
          .postApiRequest(data, url)
          .onError((error, stackTrace) {});
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
