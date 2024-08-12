// ignore_for_file: prefer_interpolation_to_compose_strings

class APIENDPOINT {
  static const baseUrl = 'https://fmobile.campuspro.in/api/';
  //-------LOGIN----------------------------------------------------------------
  static const getBaseUrl = baseUrl + 'GetBaseApiUrl';
  static const loginApi = baseUrl + "AutheticateLogin";
  static const changePasswordApi = baseUrl + "ChangeDefaultPasswordNew";
  // **********************************************
  static const sendOtpForgotPassword = baseUrl + "SendOtpForgetPassword";
  static const userTypeApi = "GetOurSchools";
  static const drawerApi = "Managemenu";
  static const gotoWebApp = "GotoWebApp4Flutter";
  static const saveFcmToken = "UpdateFcmToken";
  static const removeFcmToken = "RemoveFcmToken";

  // ************************ Gate Pass *************************
  static const searchRequest = "searchNoDetails_V1";
  static const gatePassMeetToApi = "getVisitorMeetTo_v1";
  static const gatePassPurposeApi = "getVisitorPurpose_v1";
  static const gatePassVerifyOtpApi = "verifyVisitorOtp_V1";
  static const saveVisitorGatePassApi = "updateVisitorDetailV1";
  static const getVisitorListApi = "getVisitorListToday_V1";
  static const markVisitorExitApi = "markVisitorExit_V1";
  static const markGatePassExitApi = "markGatePassExit";
  static const verifyIdGatePass = "updateVisitorIdProofV1";
  static const getGatePassHistoryApi = "getGatePasssListToday_V1";
  static const checkBusAllotApi = "CheckBusAllot";
  static const schoolBusRouteApi = "MapRealData";
  static const schoolBusLiveLocationApi = "VehicleDetails";
  static const schoolBusDetailApi = "Stutansportreport";
  static const transportStudentdDetailsApi = "FillTransportStudentDetail_V1";

  // ************************ Help & Support *************************
  static const helpAndSupportDetailApi = "GetHelpAndSupportDetails";
}
