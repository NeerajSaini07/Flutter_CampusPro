import 'dart:developer';

import 'package:campuspro/Controllers/StudentControllers/leave_controller.dart';
import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StudentLeaveRepo {
  //Get Student Attendance Status (Yearly)
  static Future<dynamic> getStudentAttendanceDataRepo() async {
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

      log(baseUrl + APIENDPOINT.studentAttendanceApi);

      dynamic response = await apiServices
          .postApiRequest(
              requestData, baseUrl + APIENDPOINT.studentAttendanceApi)
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

  //Get Student Leave Request List
  static Future<dynamic> getStudentLeaveRequestListRepo() async {
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
        "RequesterId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "RequestorType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? ""
      };

      log(requestData.toString());
      log(baseUrl + APIENDPOINT.studentLeaveRequestStatusApi);

      dynamic response = await apiServices
          .postApiRequest(
              requestData, baseUrl + APIENDPOINT.studentLeaveRequestStatusApi)
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

  //Get Class Teacher DestinationId
  static Future<dynamic> getClassTeacherRepo() async {
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
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? ""
      };

      log(requestData.toString());
      log(baseUrl + APIENDPOINT.studentLeaveRequestStatusApi);

      dynamic response = await apiServices
          .postApiRequest(
              requestData, baseUrl + APIENDPOINT.studentClassTeacherApi)
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

  //Apply for Student Leave
  static Future<dynamic> applyStudentLeaveRepo(
      {required String destinationId}) async {
    final StudentLeaveController leaveController =
        Get.find<StudentLeaveController>();
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    String mobile = await Sharedprefdata.getStrigData(Sharedprefdata.mobile);

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
        "RequesterId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "RequestorType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
        "DestinationId": destinationId,
        "txtdescription": leaveController.descriptionController.text,
        "RequestorPhone": mobile,
        "Leavetype": leaveController.selectedLeaveType.value.toString(),
        "FromDate": leaveController.fromDate.value != null
            ? DateFormat('dd-MMM-yyyy').format(leaveController.fromDate.value!)
            : "",
        "ToDate": leaveController.toDate.value != null
            ? DateFormat('dd-MMM-yyyy').format(leaveController.toDate.value!)
            : ""
      };

      log(requestData.toString());
      log(baseUrl + APIENDPOINT.studentRequestForLeaveApi);

      dynamic response = await apiServices
          .postApiRequest(
              requestData, baseUrl + APIENDPOINT.studentRequestForLeaveApi)
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
