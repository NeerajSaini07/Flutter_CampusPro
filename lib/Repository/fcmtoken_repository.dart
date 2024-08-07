import 'dart:io';

import 'package:campuspro/Controllers/fcm_token_controller.dart';
import 'package:campuspro/Modal/login_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';

class FcmTokenRepository {
  static Future<dynamic> getfcmTokendata() async {
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    final fcmTokenData = {
      'OuserId': UserLogin.loginDetails[0].oUserid,
      'OrgId': UserTypeslist.userTypesDetails[usertypeIndex].organizationId,
      'UserType': UserTypeslist.userTypesDetails[usertypeIndex].ouserType,
      'SchoolId': UserTypeslist.userTypesDetails[usertypeIndex].schoolId,
      'StuEmpId': UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId,
      'FcmToken': UserLogin.loginDetails[0].token,
      "IsUpdateToken": "N",
      "IsMstPwd": "0",
      "DeviceType": Platform.isAndroid ? 'Android' : 'Ios',
    };

    BaseApiServices apiServices = NetworkApiServices();

    try {
      dynamic response = await apiServices.postApiRequest(
          fcmTokenData, APIENDPOINT.saveFcmToken);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
