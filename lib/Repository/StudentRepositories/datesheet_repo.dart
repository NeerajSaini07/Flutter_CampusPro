import 'package:campuspro/Modal/fcmtoken_model.dart';

import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';

class StudentdatesheetRepo {
  static Future<dynamic> getdatesheet() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    // final apiToken = await Sharedprefdata.getStrigData(Sharedprefdata.apiToken);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    try {
      Map<String, dynamic> requestData = {
        "OUserId": uid.toString(),
      "Token": FcmTokenList.tokenlist.first.token.toString(),
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      "UserType":
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      "Schoolid":
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      "StudentId":
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
      "SessionId": UserTypeslist
          .userTypesDetails[usertypeIndex].currentSessionid
          .toString(),
      "YearId": StudentDetaillist.studentdetails.first.yearId.toString(),
      "StreamId": StudentDetaillist.studentdetails.first.streamId.toString(),
      "ClassId": StudentDetaillist.studentdetails.first.classId.toString(),
    };


      dynamic response =  await apiServices
          .postApiRequest(requestData, baseUrl + APIENDPOINT.datesheetApi)
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
