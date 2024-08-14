import 'package:campuspro/Controllers/login_controller.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../Services/ApiService/Data/Network/network_api_service.dart';

class LoginRepository {
  static Future<dynamic> userLoginRepo() async {
    final LoginController loginController = Get.find<LoginController>();
    BaseApiServices apiServices = NetworkApiServices();
    const url = APIENDPOINT.loginApi;
    final sharedfdata = Sharedprefdata();

    try {
      bool value =
          (await sharedfdata.getbooleandata(Sharedprefdata.loginKey)) ?? false;
      Map<String, String> data = {};
      if (value == false) {
        data = {
          "MobileNo": loginController.mobileNumber.value,
          "Pass": loginController.passWord.value
        };
      } else {
        final mobile = await Sharedprefdata.getStrigData(Sharedprefdata.mobile);

        final pass = await Sharedprefdata.getStrigData(Sharedprefdata.password);

        data = {"MobileNo": mobile, "Pass": pass};
      }

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

  static Future<dynamic> changeUserPasswordRepo(String newPassword) async {
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final number = await Sharedprefdata.getStrigData(Sharedprefdata.mobile);
    try {
      Map<String, String> requestData = {
        "OUserId": uid!.toString(),
        "MobileNo": number.toString(),
        "NewPassword": newPassword
      };
      // log(requestData.toString());
      dynamic response = await apiServices
          .postApiRequest(requestData, APIENDPOINT.changePasswordApi)
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
