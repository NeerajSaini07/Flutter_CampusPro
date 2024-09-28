import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:campuspro/Controllers/StudentControllers/exam_test_result_controller.dart';
import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../Services/ApiService/Data/Network/base_api_services.dart';

class TestExamResultRepository {
  static Future<dynamic> getSingleExamMarksRepo() async {
    final ExameAnalysisController exameAnalysisController =
        Get.find<ExameAnalysisController>();

    final ExamTestExamResultController examResultController =
        Get.find<ExamTestExamResultController>();

    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    var getexamRequestdata = {
      "OUserId": uid.toString(),
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
      "StudentID":
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
      "ExamId": examResultController.examid.isNotEmpty
          ? examResultController.examid.value.toString()
          : examResultController.examnameListForResult.first.examId.toString()
    };

    try {
      dynamic response = await apiServices
          .postApiRequest(getexamRequestdata,
              baseUrl + APIENDPOINT.testexamresultsingleExam)
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

  static Future<dynamic> getExamnameForStudentResult() async {
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
      "StudentID":
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
    };

    print("get exam data : $analysisRequest");

    try {
      dynamic response = await apiServices
          .postApiRequest(
              analysisRequest, baseUrl + APIENDPOINT.studentresultexamName)
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
