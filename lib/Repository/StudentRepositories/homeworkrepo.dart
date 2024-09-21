// ignore_for_file: unused_element

import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';
import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Services/ApiService/Data/Network/network_api_service.dart';
import '../../Utilities/sharedpref.dart';

class HomeWorkRepository {
  static Future<dynamic> gethomedate() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    DateTime currentDateTime = DateTime.now();

    int currentMonth = currentDateTime.month;
    int currentYear = currentDateTime.year;

    Map<String, dynamic> requestData = {
      "OUserId": uid,
      "Token": FcmTokenList.tokenlist.first.token,
      "StudentId":
          (StudentDetaillist.studentdetails.first.studentId ?? "").toString(),
      "OrgId":
          UserTypeslist.userTypesDetails[usertypeIndex].organizationId ?? "",
      "Schoolid": UserTypeslist.userTypesDetails[usertypeIndex].schoolId ?? "",
      "UserType": UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
      "Year": currentYear.toString(),
      "Month": currentMonth.toString(),
      "Classid":
          (StudentDetaillist.studentdetails.first.classId ?? "").toString(),
      "StreamId": StudentDetaillist.studentdetails.first.streamId.toString(),
      "YearId": StudentDetaillist.studentdetails.first.yearId.toString(),
      "SessionId":
          UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid ?? "",
      "SectionId":
          StudentDetaillist.studentdetails.first.classSectionId.toString(),
    };

    try {
      dynamic response = await apiServices
          .postApiRequest(
              requestData, baseUrl + APIENDPOINT.studenthomeworkDate)
          .onError((error, stackTrace) {});

      return response;
    } catch (e) {
      rethrow;
    }
  }

//  ********************************   get home work data by date  **************************
  static Future<dynamic> gethomeworkdatabydatesheet() async {
    final StudentHomeWorkController homeWorkController =
        Get.find<StudentHomeWorkController>();

    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    String getFormattedDateOrCurrent(DateTime? selectedDay) {
      final date = selectedDay ?? DateTime.now();
      return DateFormat('dd-MMM-yyyy').format(date);
    }

    Map<String, dynamic> data = {
      "OUserId": uid.toString(),
      "Token": FcmTokenList.tokenlist.first.token.toString(),
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      "UserType":
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      "Schoolid":
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      "StudentId":
          (StudentDetaillist.studentdetails.first.studentId).toString(),
      "SessionId": UserTypeslist
          .userTypesDetails[usertypeIndex].currentSessionid
          .toString(),
      "FromDate":
          getFormattedDateOrCurrent(homeWorkController.selectedDay.value)
              .toString(),
      "TillDate":
          getFormattedDateOrCurrent(homeWorkController.selectedDay.value)
              .toString(),
      "Onload": '0'
    };

    print(data);
    if (kDebugMode) {
      print("by date : $data");
    }

    dynamic response = await apiServices
        .postApiRequest(data, baseUrl + APIENDPOINT.getstudenthomeworkbydate)
        .onError((error, stackTrace) {});

    print(response);
    return response;
  }

  //  ************************** home work Reply method ********************

  static Future<dynamic> gethomeworkComment(id) async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    final StudentHomeWorkController studentHomeWorkController =
        Get.find<StudentHomeWorkController>();

    Map<String, String> replyrequest = {
      "OUserId": uid.toString(),
      "Token": FcmTokenList.tokenlist.first.token.toString(),
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      "UserType":
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      "SchoolId":
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      "HomeworkId": studentHomeWorkController.homeworkbydate[id].id.toString(),
      "StudentId":
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString()
    };

    print("reply homework Request: $replyrequest");

    try {
      dynamic response = await apiServices
          .postApiRequest(replyrequest, baseUrl + APIENDPOINT.homeworkereply)
          .onError((error, stackTrace) {
        print(error);
      });

      print(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> addcommentsonHomeWork(id) async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
    final StudentHomeWorkController studentHomeWorkController =
        Get.find<StudentHomeWorkController>();
    var commentsListData = {
      'UserId': uid.toString(),
      'Token': FcmTokenList.tokenlist.first.token.toString(),
      'OrgId': UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      'SchoolId':
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      'StuEmpId':
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
      'UserType':
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      'Comment': studentHomeWorkController.commentcontroller.text.toString(),
      'HomeworkId': studentHomeWorkController.homeworkbydate[id].id.toString(),
      'CommentId': '',
      'ReplyTo': '',
    };

    try {
      dynamic response = await apiServices
          .postFileRequest(
              commentsListData,
              "Files",
              studentHomeWorkController.commentfile.toString(),
              baseUrl + APIENDPOINT.addhomeworkcomment)
          .onError((error, stackTrace) {});

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
