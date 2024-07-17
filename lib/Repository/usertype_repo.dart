import 'dart:developer';

import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';

class UserTypeRepository {
  static Future<dynamic> getuserstypeInRepo() async {
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
    final loginToken = await Sharedprefdata.getStrigData(Sharedprefdata.token);
    final number = await Sharedprefdata.getStrigData(Sharedprefdata.mobile);
    final pass = await Sharedprefdata.getStrigData(Sharedprefdata.password);

    final data = {
      "OUserId": uid!,
      "Token": loginToken!,
      "MobileNo": number,
      "Pwd": pass
    };

    BaseApiServices apiServices = NetworkApiServices();
    try {
      dynamic response =
          apiServices.postApiRequest(data, APIENDPOINT.userTypeApi);
      // dynamic response = await safeApiCall(
      //     () => apiServices.postApiRequest(data, APIENDPOINT.userTypeApi));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> getDrawerData(index) async {
    var url = APIENDPOINT.drawerApi;
    BaseApiServices apiServices = NetworkApiServices();
    try {
      final drawerData = {
        "OrgId": UserTypeslist.userTypesDetails[index].organizationId,
        "SchoolId": UserTypeslist.userTypesDetails[index].schoolId,
        "ID": '0',
        "UserType": UserTypeslist.userTypesDetails[index].ouserType,
      };

      log(drawerData.toString());

      dynamic response = apiServices
          .postApiRequest(drawerData, url)
          .onError((error, stackTrace) {});

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
