import 'dart:developer';

import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';

class TransportModuleRepository {
  static Future<dynamic> getStudentListRouteDropDown() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    try {
      Map<String, String> requestData = {
        "OUserId": uid,
        "Token": FcmTokenList.tokenlist.first.token.toString(),
        "OrgId":
            UserTypeslist.userTypesDetails[usertypeIndex].organizationId ?? "",
        "Schoolid":
            UserTypeslist.userTypesDetails[usertypeIndex].schoolId ?? "",
        "StuEmpId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
        "Flag": "TransportRouteDropdown",
        "SessionId":
            UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid ??
                "",
      };
      dynamic response = await apiServices
          .postApiRequest(
              requestData, baseUrl + APIENDPOINT.transportStudentdDetailsApi)
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

  static Future<dynamic> getStudentListAreaDropDown(String routeID) async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    try {
      Map<String, String> requestData = {
        "OUserId": uid,
        "Token": FcmTokenList.tokenlist.first.token.toString(),
        "OrgId":
            UserTypeslist.userTypesDetails[usertypeIndex].organizationId ?? "",
        "Schoolid":
            UserTypeslist.userTypesDetails[usertypeIndex].schoolId ?? "",
        "StuEmpId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
        "Flag": "TransportAreaDropdown",
        "SessionId":
            UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid ??
                "",
        "RouteNo": routeID
      };
      dynamic response = await apiServices
          .postApiRequest(
              requestData, baseUrl + APIENDPOINT.transportStudentdDetailsApi)
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

  static Future<dynamic> getStudentListDetails(
      String routeID, String areaID) async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    try {
      Map<String, String> requestData = {
        "OUserId": uid,
        "Token": FcmTokenList.tokenlist.first.token.toString(),
        "OrgId":
            UserTypeslist.userTypesDetails[usertypeIndex].organizationId ?? "",
        "Schoolid":
            UserTypeslist.userTypesDetails[usertypeIndex].schoolId ?? "",
        "StuEmpId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
        "Flag": "TransportStudentDetailsTable",
        "SessionId":
            UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid ??
                "",
        "RouteNo": routeID,
        "AreaID": areaID,
        "Date": "No"
      };
      dynamic response = await apiServices
          .postApiRequest(
              requestData, baseUrl + APIENDPOINT.transportStudentdDetailsApi)
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
