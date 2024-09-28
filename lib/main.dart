// ignore_for_file: prefer_const_constructors
import 'package:campuspro/Screens/Wedgets/no_internet_widget.dart';
import 'package:campuspro/Screens/bus_tracker_screen.dart';
import 'package:campuspro/Screens/change_password_screen.dart';

import 'package:campuspro/Screens/create_password_screen.dart';
import 'package:campuspro/Screens/dashboard_screen.dart';
import 'package:campuspro/Screens/forgot_password_screen.dart';
import 'package:campuspro/Screens/getpass/dashboard.dart';
import 'package:campuspro/Screens/help_and_support_screen.dart';
import 'package:campuspro/Screens/login_screen.dart';
import 'package:campuspro/Screens/otp_screen.dart';
import 'package:campuspro/Screens/studenPortal/activity.dart';
import 'package:campuspro/Screens/studenPortal/circular.dart';
import 'package:campuspro/Screens/studenPortal/class_room.dart';
import 'package:campuspro/Screens/studenPortal/exam_test_result.dart';
import 'package:campuspro/Screens/studenPortal/holiday_list_screen.dart';

import 'package:campuspro/Screens/studenPortal/leave_details.dart';
import 'package:campuspro/Screens/studenPortal/profile.dart';
import 'package:campuspro/Screens/studenPortal/profile_edit.dart';
import 'package:campuspro/Screens/studenPortal/teacher_remark.dart';
import 'package:campuspro/Screens/studenPortal/transport_detail.dart';
import 'package:campuspro/Screens/studenPortal/student_calendar.dart';
import 'package:campuspro/Screens/studenPortal/timetable_screen.dart';

import 'package:campuspro/Screens/user_type_screen.dart';
import 'package:campuspro/Screens/web_view_page.dart';
import 'package:campuspro/Services/InternetConnection/internet_connectivity.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:campuspro/Services/notificationService/notification_service.dart';
import 'package:campuspro/Utilities/api_end_point.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:campuspro/firebase_options.dart';
import 'package:campuspro/localdatabase/db_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Dependency_injection/injection.dart';

import 'Screens/splash_screen.dart';
import 'Screens/studenPortal/datesheet.dart';
import 'Screens/studenPortal/exam_analysis.dart';
import 'Screens/studenPortal/feedback.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //const baseUrl = 'https://fmobiledev.campuspro.in/api/';
  const baseUrl = 'https://fmobile.campuspro.in/api/';
  APIENDPOINT.configure(baseUrl);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService notificationService = NotificationService();
  await notificationService.initialize();
  await initializeNotification();

  // **********************************  database initialize *****************************************************
  final databaseManager = DatabaseManager();
  databaseManager.initWinDB();
  //  *****************************************************************

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.latoTextTheme(textTheme),
          ),
          debugShowCheckedModeBanner: false,
          initialBinding: BindingsBuilder(() {
            DependencyInjection.init();
            Get.put(ConnectivityService());
          }),
          navigatorKey: navigatorKey,
          routes: {
            Routes.splash: (context) => const SplashScreen(),
            Routes.login: (context) => LoginScreen(),
            Routes.forgotpassword: (context) => ForgotPassword(),
            Routes.userType: (context) => UserTypeScreen(),
            Routes.CreatePassword: (context) => CreatePassword(),
            Routes.opt: (context) => OTPScreen(),
            Routes.Dashboardboard: (context) => MainDashboard(),
            Routes.noInternet: (context) => NoInternetScreen(),
            Routes.visitorHistory: (context) => GatePassDashboard(),
            Routes.busTrackerScreen: (context) => BusTrackerScreen(),
            Routes.helpAndSupportScreen: (context) => HelpAndSupportScreen(),
            Routes.changePasswordScreen: (context) {
              final args = Get.arguments as Map<String, dynamic>?;
              return ChangePasswordScreen(
                  isdefaultChangePass: args?['isdefaultChangePass'] ?? true);
            },
            Routes.webviewpage: (context) => WebViewDashboardPage(),
            Routes.studentProfileScreen: (context) => StudentProfileScreen(),
            Routes.studentClassRomm: (context) => StudentClassroom(),
            Routes.studentexamAnalysis: (context) =>
                StudentExamAnalysisScreen(),
            Routes.studentActivityScreen: (context) => StudentActivityScreen(),
            Routes.studentCircularScreen: (contex) => StudentCircularScreen(),
            Routes.studentLeaveDetailScreen: (contex) =>
                StudentLeaveDetailScreen(),
            Routes.studentexamTestResultScreen: (context) =>
                StudentExamTestResultScreen(),
            Routes.studentdatesheet: (context) => StudentDateSheetScreen(),
            Routes.holidayScreen: (context) => HolidayListScreen(),
            Routes.studenttimeTable: (context) => StudentTimetableScreen(),
            Routes.feedback: (context) => FeedbackScreen(),
            Routes.studentEditProfileScreen: (context) =>
                StudentEditProfileScreen(),
            Routes.transportScreen: (context) => TransportdetailScreen(),
            Routes.studentCalendarScreen: (context) => StudentCalendarScreen(),
            Routes.teacherRemarkScreen: (context) => StudentTeacherRemark(),
            // Routes.transportDashboad: (context) => TransportDashboard(),
          },
          home: SplashScreen(), // Show the SplashScreen initially
        );
      },
    );
  }
}
