import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';

class StudentActivityRepo {
  static Future<dynamic> getStudentActivity() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    try {
      Map<String, dynamic> requestData = {
        "OUserId": uid,
        "Token": FcmTokenList.tokenlist.first.token,
        "StudentId":
            (StudentDetaillist.studentdetails.first.studentId ?? "").toString(),
        "OrgId":
            UserTypeslist.userTypesDetails[usertypeIndex].organizationId ?? "",
        "Schoolid":
            UserTypeslist.userTypesDetails[usertypeIndex].schoolId ?? "",
        "UserType":
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType ?? "",
        "SectionId":
            (StudentDetaillist.studentdetails.first.classSectionId ?? "")
                .toString(),
        "SessionId":
            UserTypeslist.userTypesDetails[usertypeIndex].currentSessionid ??
                "",
        "Classid":
            (StudentDetaillist.studentdetails.first.classId ?? "").toString(),
        "Filter": "2", //1--> My School , 2--> My Class , 3--> Me Only
      };

      dynamic response = await apiServices
          .postApiRequest(requestData, baseUrl + APIENDPOINT.studentActivityApi)
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
