// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:campuspro/Controllers/getpassController.dart';
import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Modal/visitor_history_model.dart';
import 'package:campuspro/Modal/visitordata_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:get/get.dart';
import '../Modal/login_model.dart';

class GetPassRepository {
  // ******************************************************* history *******************
  static Future<dynamic> getvisitorHistory() async {
    int usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
    var visitorlistRequest = {
      "OUserId": UserLogin.loginDetails[0].oUserid,
      "Token": FcmTokenList.tokenlist[0].token,
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId,
      "Schoolid": UserTypeslist.userTypesDetails[usertypeIndex].schoolId,
      "StuEmpId": UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId,
      "UserType": UserTypeslist.userTypesDetails[usertypeIndex].ouserType,
      "MeetToId": "0"
    };

    print(visitorlistRequest);
    print(APIENDPOINT.getVisitorListApi);

    BaseApiServices apiServices = NetworkApiServices();

    try {
      dynamic response = await apiServices.postApiRequest(
          visitorlistRequest, APIENDPOINT.getVisitorListApi);
      return response;
    } catch (e) {
      rethrow;
    }
  }

// ************************************************************  sending otp **************************

  static Future<dynamic> sendingOtpForGatePass({String? number}) async {
    // final sendingData = {
    //   "OUserId": uid,
    //   "Token": token,
    //   "OrgId": userData!.organizationId,
    //   "Schoolid": userData.schoolId,
    //   "EmpId": userData.stuEmpId,
    //   "UserType": userData.ouserType,
    //   "No": number,
    // };

    //print("sending data for send otp $sendingData");
  }

  // ***************************************verify Opt method**************************************

  static Future<dynamic> verifyOtpGatePass(
      {String? otp, String? visitorid}) async {
    final GetPassController getPassController = Get.find<GetPassController>();

    int usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
    final verifyOtpRequest = {
      "OUserId": UserLogin.loginDetails.first.oUserid,
      "Token": FcmTokenList.tokenlist.first.token,
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId,
      "Schoolid": UserTypeslist.userTypesDetails[usertypeIndex].schoolId,
      "StuEmpId": UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId,
      "UserType": UserTypeslist.userTypesDetails[usertypeIndex].ouserType,
      "VisitorId": VisitorData.visitorListDetails.first.visitorId,
      "OtpCode": getPassController.otpValue.value,
      "SessionId":
          UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid,
    };

    BaseApiServices apiServices = NetworkApiServices();

    try {
      dynamic response = await apiServices
          .postApiRequest(verifyOtpRequest, APIENDPOINT.gatePassVerifyOtpApi)
          .onError((error, stackTrace) {
        throw stackTrace;
      });

      return response;
    } catch (e) {
      rethrow;
    }

    //print("sending data for send otp $sendingData");
  }

  // ******************************************************  save visitor information *************************

// ***************************************search visitory ********************

  static Future<dynamic> searchvistor() async {
    int usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
    final GetPassController getPassController = Get.find<GetPassController>();

    var visitorSearchRequest = {
      'OUserId': UserLogin.loginDetails[0].oUserid,
      'Token': FcmTokenList.tokenlist[0].token,
      'Schoolid': UserTypeslist.userTypesDetails[usertypeIndex].schoolId,
      'SessionId':
          UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid,
      'OrgId': UserTypeslist.userTypesDetails[usertypeIndex].organizationId,
      'StuEmpId': UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId,
      'MobileNo': getPassController.mobileNo.value,
      'VisitorType': getPassController.visitorTyep.value,
      'UserType': UserTypeslist.userTypesDetails[usertypeIndex].ouserType,
    };

    BaseApiServices apiServices = NetworkApiServices();

    try {
      dynamic response = await apiServices
          .postApiRequest(visitorSearchRequest, APIENDPOINT.searchRequest)
          .onError((error, stackTrace) {
        throw stackTrace;
      });

      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> getDataForToMeet() async {
    int usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    final getToMeetApiRequest = {
      'OUserId': UserLogin.loginDetails[0].oUserid,
      'Token': FcmTokenList.tokenlist[0].token,
      'Schoolid': UserTypeslist.userTypesDetails[usertypeIndex].schoolId,
      'OrgId': UserTypeslist.userTypesDetails[usertypeIndex].organizationId,
      'StuEmpId': UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId,
      'UserType': UserTypeslist.userTypesDetails[usertypeIndex].ouserType,
    };

    BaseApiServices apiServices = NetworkApiServices();

    try {
      dynamic response = await apiServices
          .postApiRequest(getToMeetApiRequest, APIENDPOINT.gatePassMeetToApi)
          .onError((error, stackTrace) {
        throw stackTrace;
      });

      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> getPurpose() async {
    int usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
    BaseApiServices apiServices = NetworkApiServices();

    var sendingrequestdatapurpose = {
      'OUserId': UserLogin.loginDetails[0].oUserid,
      'Token': FcmTokenList.tokenlist[0].token,
      'Schoolid': UserTypeslist.userTypesDetails[usertypeIndex].schoolId,
      'OrgId': UserTypeslist.userTypesDetails[usertypeIndex].organizationId,
      'StuEmpId': UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId,
      'UserType': UserTypeslist.userTypesDetails[usertypeIndex].ouserType,
    };

    try {
      dynamic response = await apiServices
          .postApiRequest(
              sendingrequestdatapurpose, APIENDPOINT.gatePassPurposeApi)
          .onError((error, stackTrace) {
        throw stackTrace;
      });

      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> updateIdProof() async {
    final GetPassController getPassController = Get.find<GetPassController>();
    int usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
    final filePaths = getPassController.imagePathForIdProof.value;

    BaseApiServices apiServices = NetworkApiServices();

    Map<String, String> updateProofid = {
      'UserId': UserLogin.loginDetails[0].oUserid.toString(),
      'Token': FcmTokenList.tokenlist[0].token.toString(),
      'Schoolid':
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      'OrgId': UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      'VisitorType': getPassController.visitorTyep.value,
      'UserType':
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      'VisitorId': VisitorData.visitorListDetails.first.visitorId.toString(),
      'EmpId':
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
      'UserTpe':
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      'Flag': 'F',
    };
    final request = apiServices.postFileRequest(
        updateProofid, "fileBase64", filePaths, APIENDPOINT.verifyIdGatePass);

    return request;
  }

  static Future<dynamic> saveVisitordata() async {
    final GetPassController getPassController = Get.find<GetPassController>();
    int usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    final name = getPassController.FullName.value.isNotEmpty
        ? getPassController.FullName.value
        : VisitorData.visitorListDetails.isNotEmpty
            ? VisitorData.visitorListDetails.last.name
            : '';

    final address = getPassController.adress.value.isNotEmpty
        ? getPassController.adress.value
        : VisitorData.visitorListDetails.isNotEmpty
            ? VisitorData.visitorListDetails.last.address
            : '';

    final imagepath = getPassController.visitorImage.value.isNotEmpty
        ? getPassController.visitorImage.value
        : VisitorData.visitorListDetails.isNotEmpty
            ? VisitorData.visitorListDetails.last.name
            : '';

    Map<String, String> requestdata = {
      "UserId": UserLogin.loginDetails[0].oUserid.toString(),
      "Token": FcmTokenList.tokenlist[0].token.toString(),
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      "SchoolId":
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      "EmpId":
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
      "UserType":
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      "SessionId": UserTypeslist
          .userTypesDetails[usertypeIndex].currentSessionid
          .toString(),
      "Name": name.toString(),
      "No": getPassController.mobileNo.value,
      "Address": address.toString(),
      "OtherDet": "null",
      "MeetToId": getPassController.selectedOption.value,
      "PurposeId": getPassController.selectedPurpose.value,
      "OtherPurpose": 'yyyy',
      "VisitorId": VisitorData.visitorListDetails.last.visitorId.toString(),
      "Flag": "F",
    };
    log(requestdata.toString());

    BaseApiServices apiServices = NetworkApiServices();
    try {
      final request = apiServices.postFileRequest(requestdata, "fileBase64",
          imagepath.toString(), APIENDPOINT.saveVisitorGatePassApi);

      return request;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> exitVisitor(index) async {
    int usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
    final sendingData = {
      'OUserId': UserLogin.loginDetails[0].oUserid.toString(),
      'Token': FcmTokenList.tokenlist[0].token.toString(),
      'Schoolid':
          UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
      'OrgId': UserTypeslist.userTypesDetails[usertypeIndex].organizationId
          .toString(),
      'StuEmpId':
          UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
      'UserType':
          UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
      "ID": VisitorHistory.visitorHistoryListDetails[index].id.toString()
    };

    log(sendingData.toString());
    log(APIENDPOINT.markVisitorExitApi);
    BaseApiServices apiServices = NetworkApiServices();

    dynamic response = await apiServices
        .postApiRequest(sendingData, APIENDPOINT.markVisitorExitApi)
        .onError((error, stackTrace) {
      throw stackTrace;
    });
    return response;
  }
}