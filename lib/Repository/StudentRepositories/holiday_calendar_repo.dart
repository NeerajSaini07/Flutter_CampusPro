import 'dart:developer';

import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';

class StudentHolidayCalendarRepo {
  //Get Student Holiday List
  static Future<dynamic> getStudentHolidayListRepo(
      {required String classId}) async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    try {
      Map<String, dynamic> requestData = {
        "OUserId": uid,
        "Token": FcmTokenList.tokenlist.first.token,
        "OrgId":
            UserTypeslist.userTypesDetails[usertypeIndex].organizationId ?? "",
        "Schoolid":
            UserTypeslist.userTypesDetails[usertypeIndex].schoolId ?? "",
        "SessionId":
            UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid ??
                "",
        "StudentId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "Classid": classId,
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? ""
      };

      log(baseUrl + APIENDPOINT.studentHolidayListApi);

      dynamic response = await apiServices
          .postApiRequest(
              requestData, baseUrl + APIENDPOINT.studentHolidayListApi)
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

  //Get Student Calendar Data
  static Future<dynamic> getStudentCalendarDataRepo() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    try {
      Map<String, dynamic> requestData = {
        "OUserId": uid,
        "Token": FcmTokenList.tokenlist.first.token,
        "OrgId":
            UserTypeslist.userTypesDetails[usertypeIndex].organizationId ?? "",
        "Schoolid":
            UserTypeslist.userTypesDetails[usertypeIndex].schoolId ?? "",
        "Flag": "GetStuDetails",
        "StuEmpId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "Year": DateTime.now().year.toString(),
        "Month": DateTime.now().month.toString(),
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
        "SessionId":
            UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid ??
                "",
      };

      log(baseUrl + APIENDPOINT.studentCalendarDataApi);

      dynamic response = await apiServices
          .postApiRequest(
              requestData, baseUrl + APIENDPOINT.studentCalendarDataApi)
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
