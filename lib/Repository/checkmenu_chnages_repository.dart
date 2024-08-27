import 'dart:developer';

import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';

class CheckmenuchangesRepo {
  static Future<dynamic> getApiCallStatusRepo() async {
    print("data for apistatus");
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    var usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    final data = {
      "SchoolId": UserTypeslist.userTypesDetails[usertypeIndex].schoolId,
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId,
      "UserType": UserTypeslist.userTypesDetails[usertypeIndex].ouserType,
      "ApiName": "ManageMenu"
    };
    log(data.toString());
    if (kDebugMode) {
      print(baseUrl + APIENDPOINT.apiCallStatus);
    }

    BaseApiServices apiServices = NetworkApiServices();
    try {
      dynamic response = apiServices
          .postApiRequest(data, baseUrl + APIENDPOINT.apiCallStatus)
          .onError((error, stackTrace) {});
      log(response.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
