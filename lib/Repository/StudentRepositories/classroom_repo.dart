import 'package:campuspro/Controllers/StudentControllers/classroomcontroller.dart';
import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
// import 'package:campuspro/Screens/Wedgets/StdentWidget/classoom/class_room_list.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class StudentClassRoomRepo {
  static Future<dynamic> getClassRoomdata() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    final StudentClasssRoomController classsRoomController =
        Get.find<StudentClasssRoomController>();

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
      "EmpId": classsRoomController.empid.value.isNotEmpty
          ? classsRoomController.empid.value
          : "0",
      "SubjectId": classsRoomController.subjectid.value.isNotEmpty
          ? classsRoomController.subjectid.value
          : "0",
      "NoRows": "20",
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

  //  ******************************************** comment ****************

  static Future<dynamic> addcomments(index) async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    final StudentClasssRoomController studentClasssRoomController =
        Get.find<StudentClasssRoomController>();

    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    Map<String, String> commentdata = {
      "UserId": uid.toString(),
      "Token": FcmTokenList.tokenlist.first.token.toString(),
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      "SchoolId":
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      "StuEmpId":
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
      "UserType":
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      "Comment": studentClasssRoomController.comment.text.toString(),
      "CircularId": studentClasssRoomController
          .classRoomdatalist[index].circularId
          .toString(),
      "CommentId": "",
      "ReplyTo": "",
    };

    try {
      dynamic response = await apiServices.postFileRequest(
          commentdata,
          "Files",
          studentClasssRoomController.filesource.toString(),
          baseUrl + APIENDPOINT.classroomcomment);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //  ***********************  class room commets **********************************

  static Future<dynamic> getClassRoomCommentsdata(index) async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    final StudentClasssRoomController studentClasssRoomController =
        Get.find<StudentClasssRoomController>();

    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    Map<String, dynamic> getcommetrequest = {
      "OUserId": uid.toString(),
      "Token": FcmTokenList.tokenlist.first.token.toString(),
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      "Schoolid":
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      "StuEmpId":
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
      "UserType":
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      "CircularId": studentClasssRoomController
          .classRoomdatalist[index].circularId
          .toString(),
      "teacherId": "",
      "UserType1":
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      "StuEmpid":
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString()
    };

    print("get comment data: $getcommetrequest");

    try {
      dynamic response = await apiServices
          .postApiRequest(
              getcommetrequest, baseUrl + APIENDPOINT.getclassroomcomment)
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
