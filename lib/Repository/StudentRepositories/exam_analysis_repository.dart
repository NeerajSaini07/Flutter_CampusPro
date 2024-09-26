// ignore_for_file: non_constant_identifier_names

import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ExamanalysisRepository {
  static Future<dynamic> getClasssessiondata() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    var analysisRequest = {
      "OUserId": uid,
      "Token": FcmTokenList.tokenlist.last.token.toString(),
      "EmpStuId":
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      "Schoolid":
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      "UserType":
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString()
    };

    try {
      dynamic response = await apiServices
          .postApiRequest(
              analysisRequest, baseUrl + APIENDPOINT.examanalysisSession)
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

  static Future<dynamic> getExamname() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
    final ExameAnalysisController exameAnalysisController =
        Get.find<ExameAnalysisController>();

    var analysisRequest = {
      "OUserId": uid,
      "Token": FcmTokenList.tokenlist.last.token.toString(),
      "EmpStuId":
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      "Schoolid":
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      "UserType":
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      "SessionId": exameAnalysisController.session.value.isNotEmpty
          ? exameAnalysisController.session.value
          : UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid
              .toString(),
      "ClassId": StudentDetaillist.studentdetails.last.classId.toString()
    };

    print("get exam data : $analysisRequest");

    try {
      dynamic response = await apiServices
          .postApiRequest(
              analysisRequest, baseUrl + APIENDPOINT.examanalysisExamName)
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

  //  **************************************   request for exam details  with scrore *****************************

  static Future<dynamic> examAnalysisReportData() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    final ExameAnalysisController exameAnalysisController =
        Get.find<ExameAnalysisController>();

    var details_request = {
      "OUserId": uid.toString(),
      "Token": FcmTokenList.tokenlist.last.token,
      "EmpStuId":
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      "Schoolid":
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      "UserType":
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      "SessionId": exameAnalysisController.session.value.isNotEmpty
          ? exameAnalysisController.session.value
          : UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid
              .toString(),
      "ExamId": exameAnalysisController.examName.isNotEmpty
          ? exameAnalysisController.examName.value
          : "0",
      "SectionId": exameAnalysisController.session.isNotEmpty
          ? exameAnalysisController.session.value
          : "0",
      "SubjectId": "0",
      "ClassId": StudentDetaillist.studentdetails.last.classId.toString(),
      "StreamId": StudentDetaillist.studentdetails.last.streamId.toString(),
      "SectionId":
          StudentDetaillist.studentdetails.last.classSectionId.toString(),
      "YearId": StudentDetaillist.studentdetails.last.yearId.toString(),
    };

    try {
      dynamic response = await apiServices
          .postApiRequest(
              details_request, baseUrl + APIENDPOINT.examanalysisreport)
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
