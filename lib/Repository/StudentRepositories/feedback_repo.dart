import 'package:campuspro/Modal/fcmtoken_model.dart';

import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controllers/feedback_controller.dart';

class StudentfeedbackRepo {
  static Future<dynamic> getfeedback({required String flag}) async {
    final StudentFeedbackController feedbackController =
        Get.find<StudentFeedbackController>();
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    // final apiToken = await Sharedprefdata.getStrigData(Sharedprefdata.apiToken);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    try {
      Map<String, dynamic> requestData = {
        "OUserId": uid.toString(),
        "Token": FcmTokenList.tokenlist.first.token.toString(),
        "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId
            .toString(),
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString(),
        "Schoolid":
            UserTypeslist.userTypesDetails[usertypeIndex].schoolId.toString(),
        "StudentId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId.toString(),
        "SessionId": UserTypeslist
            .userTypesDetails[usertypeIndex].currentSessionid
            .toString(),
        "Comp_Sug": feedbackController.type.value,
        "C_STopic": feedbackController.topicController.text,
        "C_SSubject": feedbackController.subjectController.text,
        "C_SDetail": feedbackController.detailController.text,
        "TransDate": DateFormat('dd-MMM-yyyy')
            .format(DateTime.now())
            .toString(), // or pass any date
        "Flag": flag, // Adjust based on the API
      };

      dynamic response = await apiServices
          .postApiRequest(requestData, baseUrl + APIENDPOINT.feedbackApi)
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
