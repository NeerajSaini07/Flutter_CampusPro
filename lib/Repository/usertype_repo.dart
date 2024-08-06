import 'dart:developer';

import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';

class UserTypeRepository {
  static Future<dynamic> getbaseUrlInRepo() async {
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final number = await Sharedprefdata.getStrigData(Sharedprefdata.mobile);
    try {
      Map<String, String> requestData = {
        "OUserId": uid!.toString(),
        "MobileNo": number.toString()
      };
      // log(requestData.toString());
      dynamic response = await apiServices
          .postApiRequest(requestData, APIENDPOINT.getBaseUrl)
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

  static Future<dynamic> getuserstypeInRepo() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final loginToken = await Sharedprefdata.getStrigData(Sharedprefdata.token);
    final number = await Sharedprefdata.getStrigData(Sharedprefdata.mobile);
    final pass = await Sharedprefdata.getStrigData(Sharedprefdata.password);

    final data = {
      "OUserId": uid!,
      "Token": loginToken!,
      "MobileNo": number,
      "Pwd": pass
    };
    log(data.toString());
    if (kDebugMode) {
      print(baseUrl + APIENDPOINT.userTypeApi);
    }

    BaseApiServices apiServices = NetworkApiServices();
    try {
      dynamic response = apiServices
          .postApiRequest(data, baseUrl + APIENDPOINT.userTypeApi)
          .onError((error, stackTrace) {});
      log(response.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> getDrawerData(index) async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    var url = baseUrl + APIENDPOINT.drawerApi;
    BaseApiServices apiServices = NetworkApiServices();

    try {
      final drawerData = {
        "OrgId": UserTypeslist.userTypesDetails[index].organizationId,
        "SchoolId": UserTypeslist.userTypesDetails[index].schoolId,
        "ID": '0',
        "UserType": UserTypeslist.userTypesDetails[index].ouserType,
      };

      log(drawerData.toString());
      log(url);

      dynamic response = apiServices
          .postApiRequest(drawerData, url)
          .onError((error, stackTrace) {});

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
