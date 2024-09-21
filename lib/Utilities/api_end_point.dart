// ignore_for_file: prefer_interpolation_to_compose_strings

class APIENDPOINT {
  // static const baseUrl = 'https://fmobile.campuspro.in/api/';
  static late String baseUrl;

  static void configure(String url) {
    baseUrl = url;
  }

  //-------LOGIN----------------------------------------------------------------
  static String get getBaseUrl => baseUrl + 'GetBaseApiUrl';
  static String get loginApi => baseUrl + "AutheticateLogin";
  static String get changePasswordApi => baseUrl + "ChangeDefaultPasswordNew";
  // **********************************************
  static String get sendOtpForgotPassword => baseUrl + "SendOtpForgetPassword";
  static const userTypeApi = "GetOurSchools";
  static const apiCallStatus = "ApiCallStatus";
  static const drawerApi = "GetAssignMenu_V1"; //"Managemenu"; // //
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

  // *******************  bus Location Tracking **************************
  static const checkBusAllotApi = "CheckBusAllot";
  static const schoolBusRouteApi = "MapRealData";
  static const schoolBusLiveLocationApi = "VehicleDetails";

  //  *************************** Transport Module *******************************
  static const schoolBusDetailApi = "Stutansportreport";
  static const transportStudentdDetailsApi = "FillTransportStudentDetail_V1";

  // ************************ Help & Support *************************
  static const helpAndSupportDetailApi = "GetHelpAndSupportDetails";

  // ******************************  Employee ****************************

  static const employeeProfile = "GetEmpProfilenew_V1";

  // ************************ Student Module *************************

  static const studentDetailApi = "GetStudentInfo_V1";
  static const notificationApi = "Getalertnotifications_V1";
  static const circularApi = "getCircular_V1";
  static const classroom = "getClassRoomSNew";
  static const subjectTecherlits = "GetClassTeracherWithSubject_V2";
  static const studentActivityApi = "getActivityHtmlContent_V1";
  static const studenthomeworkDate = "GetHomeworkDetailsForCal_V1";
  static const getstudenthomeworkbydate = "GetStudentHomeworkCurrentDate_V1";
  static const homeworkereply = "GetReplys";
  static const classroomcomment = "AddClassRoomComments";
  static const getclassroomcomment = "GetComments_V1";
  static const addhomeworkcomment = "AddHomeworkComments_V1";

  //  *************************  exam analysis  ***********************
  static const examanalysisSession = "getSession_V1";
  static const examanalysisExamName = "GetClassExams_V1";
  static const examanalysisreport = "GetSingleClassMarksData_V1";

  //  **************************  exam Test Result****************************************
  static const testexamresultsingleExam = "GetStuMarks4SingleExam_V1";
//
  //  ****************************
}
