import 'package:campuspro/Controllers/EmployeeController/ProfileController.dart';
import 'package:campuspro/Controllers/GetPassController/getpassController.dart';
import 'package:campuspro/Controllers/StudentControllers/activity_controller.dart';
import 'package:campuspro/Controllers/StudentControllers/calendar_controller.dart';
import 'package:campuspro/Controllers/StudentControllers/circular_controller.dart';
import 'package:campuspro/Controllers/StudentControllers/classroomcontroller.dart';
import 'package:campuspro/Controllers/StudentControllers/edit_profile_controller.dart';
import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:campuspro/Controllers/StudentControllers/exam_test_result_controller.dart';
import 'package:campuspro/Controllers/StudentControllers/holiday_calender_controller.dart';
import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';
import 'package:campuspro/Controllers/StudentControllers/leave_controller.dart';
import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/bus_tracker_controller.dart';
import 'package:campuspro/Controllers/change_password_controller.dart';
import 'package:campuspro/Controllers/datesheet_controller.dart';
import 'package:campuspro/Controllers/exception_controller.dart';
import 'package:campuspro/Controllers/fcm_token_controller.dart';
import 'package:campuspro/Controllers/forgotpassword_controller.dart';
import 'package:campuspro/Controllers/help_and_support_controller.dart';
import 'package:campuspro/Controllers/logout_controller.dart';
import 'package:campuspro/Controllers/StudentControllers/profileController.dart';
import 'package:campuspro/Controllers/notificationController.dart';
import 'package:campuspro/Controllers/transport_studentlist_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Controllers/login_controller.dart';
import 'package:campuspro/Controllers/splash_controller.dart';
import 'package:campuspro/Controllers/StudentControllers/student_timetable_controller.dart';
import 'package:campuspro/Services/downloadService/download_service.dart';
import 'package:campuspro/Services/fileDownloadSerrvice/download.dart';
import 'package:get/get.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import '../Controllers/StudentControllers/transportdetail_controller.dart';
import '../Controllers/feedback_controller.dart';
import '../Controllers/menu_controller.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());

    Get.lazyPut<LoginController>(() => LoginController());

    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());

    Get.lazyPut<UserTypeController>(() => UserTypeController());

    Get.lazyPut<LogoutController>(() => LogoutController());

    Get.lazyPut<ExceptionController>(() => ExceptionController());

    Get.lazyPut<WebController>(() => WebController());

    Get.lazyPut<FcmTokenController>(() => FcmTokenController());

    Get.lazyPut<BusTrackerController>(() => BusTrackerController());

    Get.lazyPut<GetPassController>(() => GetPassController());

    Get.lazyPut<TransportStudentListController>(
        () => TransportStudentListController());

    Get.lazyPut<AppbarController>(() => AppbarController());

    Get.lazyPut<BottomBarController>(() => BottomBarController());

    Get.lazyPut<HelpAndSupportController>(() => HelpAndSupportController());

    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());

    Get.lazyPut<UserMenuController>(() => UserMenuController());
    Get.lazyPut<AllEmployeeProfileController>(
        () => AllEmployeeProfileController());

    Get.lazyPut<StudentProfileController>(() => StudentProfileController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    // ***************  Student Controller  ***********************
    Get.lazyPut<StudentHomeWorkController>(() => StudentHomeWorkController(),
        fenix: true);
    Get.lazyPut<CircularController>(() => CircularController(), fenix: true);

    Get.lazyPut<StudentClasssRoomController>(
        () => StudentClasssRoomController(),
        fenix: true);
    Get.lazyPut<StudentActivityController>(() => StudentActivityController(),
        fenix: true);

    Get.put(DownloadService());

    // Get.lazyPut<FileDownloadService>(() => FileDownloadService(), fenix: true);

    Get.lazyPut<ExameAnalysisController>(() => ExameAnalysisController(),
        fenix: true);

    Get.lazyPut<ExamTestExamResultController>(
        () => ExamTestExamResultController(),
        fenix: true);

    Get.lazyPut<StudentFeedbackController>(() => StudentFeedbackController(),
        fenix: true);
    Get.lazyPut<StudenttimetableController>(() => StudenttimetableController(),
        fenix: true);
    Get.lazyPut<TransportdetailController>(() => TransportdetailController(),
        fenix: true);

    Get.lazyPut<StudentDatesheetController>(() => StudentDatesheetController(),
        fenix: true);
    Get.lazyPut<StudentLeaveController>(() => StudentLeaveController(),
        fenix: true);
    Get.lazyPut<StudentEditProfileController>(
        () => StudentEditProfileController(),
        fenix: true);
    Get.lazyPut<StudentHolidayAndCalendarController>(
        () => StudentHolidayAndCalendarController(),
        fenix: true);
    Get.lazyPut<StudentCalendarController>(() => StudentCalendarController(),
        fenix: true);
  }
}
