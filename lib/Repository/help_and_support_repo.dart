import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/login_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';

class HelpAndSupportRepository {
  static Future<dynamic> getHelpAndSupportDetailsRepo() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    int usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
    var request = {
      "OUserId": UserLogin.loginDetails[0].oUserid,
      "Token": FcmTokenList.tokenlist[0].token,
      "OrgId": UserTypeslist.userTypesDetails[usertypeIndex].organizationId,
      "Schoolid": UserTypeslist.userTypesDetails[usertypeIndex].schoolId,
      "StuEmpId": UserTypeslist.userTypesDetails[usertypeIndex].stuEmpId,
      "UserType": UserTypeslist.userTypesDetails[usertypeIndex].ouserType,
    };

    BaseApiServices apiServices = NetworkApiServices();

    try {
      dynamic response = await apiServices.postApiRequest(
          request, baseUrl + APIENDPOINT.helpAndSupportDetailApi);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
