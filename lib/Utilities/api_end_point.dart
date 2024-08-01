// ignore_for_file: prefer_interpolation_to_compose_strings

class APIENDPOINT {
  static const baseUrl = 'https://fmobile.campuspro.in/api/';
  //-------LOGIN----------------------------------------------------------------
  static const loginApi = baseUrl + "AutheticateLogin";

  // **********************************************
  static const userTypeApi = baseUrl + "GetOurSchools";
  static const sendOtpForgotPassword = baseUrl + "SendOtpForgetPassword";
  static const drawerApi = baseUrl + "Managemenu";
  static const gotoWebApp = baseUrl + "GotoWebApp4Flutter";
  static const saveFcmToken = baseUrl + "UpdateFcmToken";
  static const removeFcmToken = baseUrl + "RemoveFcmToken";

  // ************************ Gate Pass *************************
  static const searchRequest = baseUrl + "searchNoDetails_V1";
  static const gatePassMeetToApi = baseUrl + "getVisitorMeetTo_v1";
  static const gatePassPurposeApi = baseUrl + "getVisitorPurpose_v1";
  static const gatePassVerifyOtpApi = baseUrl + "verifyVisitorOtp_V1";
  static const saveVisitorGatePassApi = baseUrl + "updateVisitorDetailV1";
  static const getVisitorListApi = baseUrl + "getVisitorListToday_V1";
  static const markVisitorExitApi = baseUrl + "markVisitorExit_V1";
  static const markGatePassExitApi = baseUrl + "markGatePassExit";
  static const verifyIdGatePass = baseUrl + "updateVisitorIdProofV1";
  static const getGatePassHistoryApi = baseUrl + "getGatePasssListToday_V1";
  static const checkBusAllotApi = baseUrl + "CheckBusAllot";
  static const schoolBusRouteApi = baseUrl + "MapRealData";
  static const schoolBusLiveLocationApi = baseUrl + "VehicleDetails";
  static const schoolBusDetailApi = baseUrl + "Stutansportreport";
  static const transportStudentdDetailsApi =
      baseUrl + "FillTransportStudentDetail_V1";
}
