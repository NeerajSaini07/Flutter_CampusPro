// ignore_for_file: prefer_interpolation_to_compose_strings

class APIENDPOINT {
  static const baseUrl = 'https://fmobile.campuspro.in/api/';
  //-------LOGIN----------------------------------------------------------------
  static const loginApi = baseUrl + "AutheticateLogin";
  static const userTypeApi = baseUrl + "GetOurSchools";
  static const sendOtpForgotPassword = baseUrl + "SendOtpForgetPassword";
  static const drawerApi = baseUrl + "Managemenu";
  static const gotoWebApp = baseUrl + "GotoWebApp4Flutter";
  static const saveFcmToken = baseUrl + "UpdateLastActive_fcmtokenwebnew";
  static const checkBusAllotApi = baseUrl + "CheckBusAllot";
  static const schoolBusRouteApi = baseUrl + "MapRealData";
  static const schoolBusLiveLocationApi = baseUrl + "VehicleDetails";
  static const schoolBusDetailApi = baseUrl + "Stutansportreport";
}
