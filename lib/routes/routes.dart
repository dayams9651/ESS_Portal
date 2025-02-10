import 'package:get/get.dart';
import 'package:ms_ess_portal/screens/Statistics/bindings/statistics_bindings.dart';
import 'package:ms_ess_portal/screens/Testing/testing_bindings.dart';
import 'package:ms_ess_portal/screens/dashboard/dashboard_screen.dart';
import 'package:ms_ess_portal/screens/documents/views/documents_page_screen.dart';
import 'package:ms_ess_portal/screens/holiday&event/bindings/holidays_bindings.dart';
import 'package:ms_ess_portal/screens/holiday&event/views/holiday_screen.dart';
import 'package:ms_ess_portal/screens/home/view/announdement_screen.dart';
import 'package:ms_ess_portal/screens/home/view/hierarchy_chart.dart';
import 'package:ms_ess_portal/screens/notification/view/notification_screen.dart';
import 'package:ms_ess_portal/screens/peripheral/bindings/peripheral_bindings.dart';
import 'package:ms_ess_portal/screens/peripheral/view/peripheral_screen.dart';
import 'package:ms_ess_portal/screens/selfService/bindings/leaveStatus_bindings.dart';
import 'package:ms_ess_portal/screens/selfService/bindings/leave_grant_bindings.dart';
import 'package:ms_ess_portal/screens/selfService/views/leaveWFH_screen.dart';
import 'package:ms_ess_portal/screens/selfService/views/leave_grant_screen.dart';
import 'package:ms_ess_portal/screens/selfService/views/paySlip_screen.dart';
import 'package:ms_ess_portal/screens/signIn/welcome_screen.dart';
import 'package:ms_ess_portal/screens/signUp/signUp_screen.dart';
import 'package:ms_ess_portal/screens/splash_screen_ess.dart';
import '../screens/Statistics/view/statistics_screen.dart';
import '../screens/Testing/testing_screen.dart';
import '../screens/documents/bindings/doucment_bindings.dart';
import '../screens/selfService/bindings/payslip_bindings.dart';
import '../screens/selfService/views/leaveStatus_screen.dart';

class ApplicationPages {
  static const splashScreen = '/';
  static const signUpScreen = '/signUpPage';
  static const welcomeScreen = '/welcomeScreen';
  static const dashboardScreen = '/signInPage';
  static const leaveStatusScreen = '/leaveStatusScreen';
  static const leaveGrantScreen = '/leaveGrantScreen';
  static const leaveWFHScreen = '/leaveWFHScreen';
  static const paySlipScreen = '/paySlipScreen';
  static const holidayScreen = '/holidayScreen';
  static const documentsScreen = '/documentsScreen';
  static const notificationScreen = '/notificationScreen';
  static const announcementScreen = '/announcementScreen';
  static const hierarchyScreen = '/hierarchyScreen';
  static const peripheralScreen = '/peripheralScreen';
  static const statisticsScreen = '/statisticsScreen';
  static const testingScreen = '/testingScreen';

  static List<GetPage>? getApplicationPages() => [

    GetPage(name: splashScreen,
      page: () => const SplashScreenEss()),

    GetPage(name: signUpScreen,
        page: ()=> const SignupScreen()),

    GetPage(name: welcomeScreen,
        page:()=> const WelcomeScreen()),

    GetPage(name: dashboardScreen,
        page: ()=>const DashboardScreen()),

    GetPage(
        name: leaveStatusScreen,
        page: ()=>LeaveStatusScreen(),
        binding: LeaveStatusBindings()
    ),

    GetPage(
        name: leaveGrantScreen,
        page: ()=> LeaveGrantScreen(),
        binding: LeaveGrantBindings()
    ),

    // GetPage(
    //     name: leaveWFHScreen,
    //     page: ()=>  LeaveWFHScreen(),
    //     // binding: LeaveStatusBindings()
    // ),

    GetPage(
        name: paySlipScreen,
        page: ()=> PayslipScreen(),
        binding: PayslipBindings()
    ),

    GetPage(
        name: holidayScreen,
        page: ()=> HolidayScreen(),
        binding: HolidaysBindings()
    ),

    GetPage(
        name: documentsScreen,
        page: ()=>  DocumentsPageScreen(),
        binding: DocumentsBindings()
    ),

    GetPage(
        name: notificationScreen,
        page: ()=>  NotificationScreen(),
        // binding: NotificationBindings()
    ),


    GetPage(
        name: announcementScreen,
        page: ()=>  AnnouncementScreen(),
        // binding: AnnouncementBindings()
    ),

    GetPage(
      name: hierarchyScreen,
      page: ()=>  EmployeeView(),
      // binding: AnnouncementBindings()
    ),

    GetPage(
        name: peripheralScreen,
        page: ()=>  PeripheralScreen(),
        binding: PeripheralBindings()
    ),

    GetPage(
        name: statisticsScreen,
        page: ()=>  StatisticsScreen(),
        binding: StatisticsBindings()
    ),

    GetPage(
        name: testingScreen,
        page: ()=>  ReportScreen(),
        // binding: TestingBindings()
    ),
  ];
}
