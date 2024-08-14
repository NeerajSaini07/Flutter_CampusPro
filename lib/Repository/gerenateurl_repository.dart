import 'dart:developer';

import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/login_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';

class GenerateUrlRepository {
  static Future<dynamic> getGenerateUrl(pageurl, pageName) async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    final data = {
      "OUserId": UserLogin.loginDetails[0].oUserid,
      "Token": FcmTokenList.tokenlist[0].token,
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId,
      "Schoolid": UserTypeslist.userTypesDetails[usertypeIndex].schoolId,
      "SessionId":
          UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid,
      "AppUrl": UserTypeslist.userTypesDetails[usertypeIndex].appUrl,
      "PageUrl": pageurl,
      "StuEmpId": UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId,
      "UserType": UserTypeslist.userTypesDetails[usertypeIndex].ouserType,
      "Flag": "F",
      "PageName": pageName,
    };
    String url = baseUrl + APIENDPOINT.gotoWebApp;

    log(data.toString());

    BaseApiServices apiServices = NetworkApiServices();
    try {
      dynamic response = await apiServices
          .postApiRequest(data, url)
          .onError((error, stackTrace) {
        throw stackTrace;
      });
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
