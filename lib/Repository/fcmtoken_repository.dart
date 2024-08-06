import 'dart:developer';
import 'dart:io';
import 'package:campuspro/Modal/login_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';

class FcmTokenRepository {
  static Future<dynamic> getfcmTokendata() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
    String fcmToken =
        await Sharedprefdata.getStrigData(Sharedprefdata.fcmToken);

    final fcmTokenData = {
      'OuserId': UserLogin.loginDetails[0].oUserid,
      'OrgId': UserTypeslist.userTypesDetails[usertypeIndex].organizationId,
      'UserType': UserTypeslist.userTypesDetails[usertypeIndex].ouserType,
      'SchoolId': UserTypeslist.userTypesDetails[usertypeIndex].schoolId,
      'StuEmpId': UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId,
      'FcmToken': fcmToken,
      "IsUpdateToken": "N",
      "IsMstPwd": "0",
      "DeviceType": Platform.isAndroid ? 'Android' : 'Ios',
    };
    log(fcmTokenData.toString());

    BaseApiServices apiServices = NetworkApiServices();

    try {
      dynamic response = await apiServices.postApiRequest(
          fcmTokenData, baseUrl + APIENDPOINT.saveFcmToken);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> removefcmToken() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    String fcmToken =
        await Sharedprefdata.getStrigData(Sharedprefdata.fcmToken);

    final removeFcmTokenData = {
      'OUserId': UserLogin.loginDetails[0].oUserid,
      'FcmToken': fcmToken
    };
    log(removeFcmTokenData.toString());
    BaseApiServices apiServices = NetworkApiServices();

    try {
      dynamic response = await apiServices.postApiRequest(
          removeFcmTokenData, baseUrl + APIENDPOINT.removeFcmToken);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
