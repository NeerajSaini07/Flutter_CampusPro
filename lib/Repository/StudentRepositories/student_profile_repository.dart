import 'dart:developer';

import 'package:campuspro/Controllers/StudentControllers/edit_profile_controller.dart';
import 'package:campuspro/Controllers/notificationController.dart';
import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/student_module/student_profile_model.dart';
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

  //Get DropDown For Request Profile
  static Future<dynamic> getProfileDropDownRepo(
      {required String paramType}) async {
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
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
        "EmpStuId": UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? ""
      };

      if (paramType != "BloodGroup") {
        requestData["ParamType"] = paramType;
      }

      log(requestData.toString());
      String url;
      if (paramType != "BloodGroup") {
        url = baseUrl + APIENDPOINT.reqProfileDropDownApi;
      } else {
        url = baseUrl + APIENDPOINT.getBloodGroupDropDownApi;
      }

      dynamic response = await apiServices
          .postApiRequest(requestData, url)
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

  //Send Request for Profile Update
  static Future<dynamic> sendRequestForProfileUpdateRepo() async {
    final StudentEditProfileController editProfileController =
        Get.find<StudentEditProfileController>();
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    try {
      Map<String, dynamic> requestData = {
        "UserId": uid,
        "Token": FcmTokenList.tokenlist.first.token,
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
        "StudentId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "OrgId":
            UserTypeslist.userTypesDetails[usertypeIndex].organizationId ?? "",
        "SchoolId":
            UserTypeslist.userTypesDetails[usertypeIndex].schoolId ?? "",
        "Name": editProfileController.nameC.text,
        "Dob": editProfileController.dobC.text,
        "Gender": editProfileController.selectedGender.value,
        "Nationality": editProfileController.selectedNationality.value,
        "BloodGroup": editProfileController.selectedBloodGroup.value,
        "StudentAadharNo": editProfileController.studentAadharC.text,
        "FatherName": editProfileController.fatherNameC.text,
        "MotherName": editProfileController.montherNameC.text,
        "Religion": editProfileController.selectedReligion.value,
        "Category": editProfileController.selectedCategory.value,
        "Address": editProfileController.presentAddressC.text,
        "PermanentAddress": editProfileController.permanentAddressC.text,
        "State": StudentProfileList.studentProfileList.first.pState ?? "",
        "City": StudentProfileList.studentProfileList.first.pCity ?? "",
        "PinNo": editProfileController.presentPinCodeC.text,
        "PermanentPinNo": editProfileController.permanentPinCodeC.text,
        "EmailId": editProfileController.emailC.text,
        "MobileNo": editProfileController.mobileNoC.text,
        "Village": StudentProfileList.studentProfileList.first.village ?? "",
        "Po": StudentProfileList.studentProfileList.first.pO ?? "",
        "Caste": editProfileController.selectedCaste.value,
        "FatherAadharNo": editProfileController.fatherAadharC.text,
        "MotherAadharNo": editProfileController.montherAadharC.text,
        "GuardianMobileNo": editProfileController.guardianMobileNoC.text,
        "StudentImagePath":
            StudentProfileList.studentProfileList.first.studentImagePath,
        "FatherImagePath":
            StudentProfileList.studentProfileList.first.fatherImagePath,
        "MotherImagePath":
            StudentProfileList.studentProfileList.first.motherImagePath,
        "CPersonImagePath":
            StudentProfileList.studentProfileList.first.conPersonImagePath,
        "FamilyID": editProfileController.familyIdC.text
      };

      log(requestData.toString());

      dynamic response = await apiServices
          .postApiRequest(
              requestData, baseUrl + APIENDPOINT.requestToEditStudentProfileApi)
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

  //Upload Image
  static Future<dynamic> uploadProfileImageRepo(
      {required String imagePath, required String imageFor}) async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    int usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    Map<String, String> requestdata = {
      "OUserId": uid,
      "OrgId":
          UserTypeslist.userTypesDetails[usertypeIndex].organizationId ?? "",
      "SchoolId": UserTypeslist.userTypesDetails[usertypeIndex].schoolId ?? "",
      "Token": FcmTokenList.tokenlist.first.token ?? "",
      "UserType": UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
      "EmpStuId": UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
      "ImageFor": imageFor
    };
    log(requestdata.toString());
    log(baseUrl + APIENDPOINT.uploadStudentRequestImageApi);

    BaseApiServices apiServices = NetworkApiServices();
    try {
      final response = apiServices.postFileRequest(requestdata, "Files",
          imagePath, baseUrl + APIENDPOINT.uploadStudentRequestImageApi);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
