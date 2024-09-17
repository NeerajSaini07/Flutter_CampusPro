import 'dart:developer';

import 'package:campuspro/Controllers/notificationController.dart';
import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StudentProfileRepo {
  static Future<dynamic> studentDetailRepo() async {
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
        "StudentId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "SessionId":
            UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid ??
                "",
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
      };

      dynamic response = await apiServices
          .postApiRequest(requestData, baseUrl + APIENDPOINT.studentDetailApi)
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

  static Future<dynamic> notificationRepo(onload) async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    final NotificationController notificationController =
        Get.find<NotificationController>();

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
        "StuEmpId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
        "FromDate": onload == 0
            ? notificationController.fromdate.value
            : DateFormat('dd-MMM-yyyy').format(DateTime.now()).toString(),
        "ToDate": onload == 0
            ? notificationController.todate.value
            : DateFormat('dd-MMM-yyyy').format(DateTime.now()).toString(),
        "EmpId": UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "OnLoad": onload.toString()
      };

      print("Notification data: ${requestData}");
      dynamic response = await apiServices
          .postApiRequest(requestData, baseUrl + APIENDPOINT.notificationApi)
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

  //Get Student Profile
  static Future<dynamic> getStudentProfileRepo() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    try {
      Map<String, dynamic> requestData = {
        "OUserId": uid,
        "Token": FcmTokenList.tokenlist.first.token,
        "EmpStuId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "OrgId":
            UserTypeslist.userTypesDetails[usertypeIndex].organizationId ?? "",
        "Schoolid":
            UserTypeslist.userTypesDetails[usertypeIndex].schoolId ?? "",
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
        "SessionId":
            UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid ??
                "",
        "StudentID":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
      };

      log(requestData.toString());

      dynamic response = await apiServices
          .postApiRequest(requestData, baseUrl + APIENDPOINT.studentProfileApi)
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

  //Get Student Remark
  static Future<dynamic> getStudentRemarkRepo() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    try {
      Map<String, dynamic> requestData = {
        "OUserId": uid,
        "Token": FcmTokenList.tokenlist.first.token,
        "EmpStuId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "OrgId":
            UserTypeslist.userTypesDetails[usertypeIndex].organizationId ?? "",
        "Schoolid":
            UserTypeslist.userTypesDetails[usertypeIndex].schoolId ?? "",
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
        "SessionId":
            UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid ??
                "",
        "StudentID":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
      };

      log(requestData.toString());

      dynamic response = await apiServices
          .postApiRequest(requestData, baseUrl + APIENDPOINT.studentRemarkApi)
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
