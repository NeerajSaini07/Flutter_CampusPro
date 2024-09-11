import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';

class StudentClassRoomRepo {
  static Future<dynamic> getClassRoomdata() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    // final apiToken = await Sharedprefdata.getStrigData(Sharedprefdata.apiToken);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    Map<String, dynamic> requestData = {
      "OUserId": uid.toString(),
      "Token": FcmTokenList.tokenlist.first.token.toString(),
      "StudentId": StudentDetaillist.studentdetails.first.studentId.toString(),
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      "UserType":
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      "Schoolid":
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      "EmpId": "0",
      "SubjectId": "0",
      "NoRows": "0",
      "Counts": "0",
      "LastId": "0",
      "ClassId": StudentDetaillist.studentdetails.first.classId.toString(),
      "StreamId": StudentDetaillist.studentdetails.first.streamId.toString(),
      "SectionId":
          StudentDetaillist.studentdetails.first.classSectionId.toString(),
      "YearId": StudentDetaillist.studentdetails.first.yearId.toString(),
    };

    if (kDebugMode) {
      print("Class Romm Data set : $requestData");
    }
    try {
      dynamic response = await apiServices
          .postApiRequest(requestData, baseUrl + APIENDPOINT.classroom)
          .onError((error, stackTrace) {
        if (kDebugMode) {
          print(error);
        }
      });
      print("class room :$response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

//  ********************* Get teacherlist for filder class room data ***************
  static Future<dynamic> filterdataList() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    Map<String, dynamic> requestDataforFilter = {
      "OUserId": uid.toString(),
      "Token": FcmTokenList.tokenlist.first.token.toString(),
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      "UserType":
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      "Schoolid":
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      "StuEmpId":
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
      "SessionId": UserTypeslist
          .userTypesDetails[usertypeIndex].currentSessionid
          .toString(),
      "YearId": StudentDetaillist.studentdetails.first.yearId.toString(),
      "StreamId": StudentDetaillist.studentdetails.first.streamId.toString(),
      "SectionId":
          StudentDetaillist.studentdetails.first.classSectionId.toString(),
      "Classid": StudentDetaillist.studentdetails.first.classId.toString(),
    };

    print("Filterdatarequest: $requestDataforFilter");

    try {
      dynamic response = await apiServices
          .postApiRequest(
              requestDataforFilter, baseUrl + APIENDPOINT.subjectTecherlits)
          .onError((error, stackTrace) {
        if (kDebugMode) {
          print(error);
        }
      });

      print("teacherlist :$response");

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
