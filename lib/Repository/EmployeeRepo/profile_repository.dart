import 'dart:developer';

import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/login_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';

class EmployeeProfileRepository {
  static Future<dynamic> getEmployeeProfileDetails() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    final userdata = {
      'OUserId': UserLogin.loginDetails[0].oUserid,
      'OrgId': UserTypeslist.userTypesDetails[usertypeIndex].organizationId,
      'UserType': UserTypeslist.userTypesDetails[usertypeIndex].ouserType,
      'Schoolid': UserTypeslist.userTypesDetails[usertypeIndex].schoolId,
      'EmpId': UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId,
      "Token": FcmTokenList.tokenlist[0].token,
      "SessionId":
          UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid,
    };
    log(userdata.toString());

    BaseApiServices apiServices = NetworkApiServices();

    try {
      dynamic response = await apiServices.postApiRequest(
          userdata, baseUrl + APIENDPOINT.employeeProfile);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
