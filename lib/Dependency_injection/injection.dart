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
import 'package:get/get.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import '../Controllers/StudentControllers/transportdetail_controller.dart';
import '../Controllers/feedback_controller.dart';
import '../Controllers/menu_controller.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController(),
        fenix: true);

    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);

    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController(),
        fenix: true);

    Get.lazyPut<UserTypeController>(() => UserTypeController(), fenix: true);

    Get.lazyPut<LogoutController>(() => LogoutController(), fenix: true);

    Get.lazyPut<ExceptionController>(() => ExceptionController(), fenix: true);

    Get.lazyPut<WebController>(() => WebController(), fenix: true);

    Get.lazyPut<FcmTokenController>(() => FcmTokenController(), fenix: true);

    Get.lazyPut<BusTrackerController>(() => BusTrackerController(),
        fenix: true);

    Get.lazyPut<GetPassController>(() => GetPassController(), fenix: true);

    Get.lazyPut<TransportStudentListController>(
        () => TransportStudentListController());

    Get.lazyPut<AppbarController>(() => AppbarController(), fenix: true);

    Get.lazyPut<BottomBarController>(() => BottomBarController(), fenix: true);

    Get.lazyPut<HelpAndSupportController>(() => HelpAndSupportController(),
        fenix: true);

    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController(),
        fenix: true);

    Get.lazyPut<UserMenuController>(() => UserMenuController(), fenix: true);
    Get.lazyPut<AllEmployeeProfileController>(
        () => AllEmployeeProfileController(),
        fenix: true);

    Get.lazyPut<StudentProfileController>(() => StudentProfileController(),
        fenix: true);
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
