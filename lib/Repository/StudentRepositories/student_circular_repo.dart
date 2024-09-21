import 'package:campuspro/Controllers/StudentControllers/circular_controller.dart';
import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StudentCircularRepo {
  static Future<dynamic> getStudentCircular() async {
    CircularController circularController = Get.find<CircularController>();
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);

    // final apiToken = await Sharedprefdata.getStrigData(Sharedprefdata.apiToken);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    try {
      Map<String, dynamic> requestData = {
        "UserId": uid,
        "Token": FcmTokenList.tokenlist.first.token,
        "OrgId":
            UserTypeslist.userTypesDetails[usertypeIndex].organizationId ?? "",
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
        "SchoolId":
            UserTypeslist.userTypesDetails[usertypeIndex].schoolId ?? "",
        "StuEmpId":
            UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId ?? "",
        "SessionId":
            UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid ??
                "",
        "FromDate": circularController.fromDate.value != null
            ? DateFormat('dd-MMM-yyyy')
                .format(circularController.fromDate.value!)
            : "12-Sep-2024",
        "ToDate": circularController.toDate.value != null
            ? DateFormat('dd-MMM-yyyy').format(circularController.toDate.value!)
            : "12-Sep-2024",
        "Onload": circularController.filterCircular.value.toString(),
      };

      dynamic response = await apiServices
          .postApiRequest(requestData, baseUrl + APIENDPOINT.circularApi)
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
