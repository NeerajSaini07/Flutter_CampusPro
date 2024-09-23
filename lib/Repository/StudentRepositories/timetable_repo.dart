import 'package:campuspro/Modal/fcmtoken_model.dart';

import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';

class StudenttimetableRepo {
  static Future<dynamic> gettimetable() async {
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
        "Schoolid":
            UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
        "EmpStuId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
        "EmpID": "0",
        // UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),

        "SessionId": UserTypeslist
            .userTypesDetails[usertypeIndex].currentSessionid
            .toString(),
        "ClassSecID":
            StudentDetaillist.studentdetails.first.classSectionId.toString(),
        "Flag": "FillClassesAndPeriods",
        "ClassID": StudentDetaillist.studentdetails.first.classId.toString(),
      };

      dynamic response = await apiServices
          .postApiRequest(requestData, baseUrl + APIENDPOINT.studenttimetable)
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


/////*********
