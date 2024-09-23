import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/Data/Network/network_api_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:campuspro/Utilities/sharedpref.dart';



class TransportDetailRepo {
  static Future<dynamic> gettransportdetail() async {
    String baseUrl = await Sharedprefdata.getStrigData(Sharedprefdata.baseUrl);
    BaseApiServices apiServices = NetworkApiServices();
    final uid = await Sharedprefdata.getStrigData(Sharedprefdata.uid);
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
    
    };

  dynamic response =  await apiServices

          .postApiRequest(requestData, baseUrl + APIENDPOINT.transportdetail)
          .onError((error, stackTrace) {

    
     });
     return response;
 
      
    } catch (e) {
      rethrow;
    }
  }
}





