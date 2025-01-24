import 'package:get/get.dart';
import 'package:ms_ess_potal/screens/Statistics/bindings/statistics_bindings.dart';
import 'package:ms_ess_potal/screens/Testing/testing_screen.dart';
import 'package:ms_ess_potal/screens/dashboard/dashboard_screen.dart';
import 'package:ms_ess_potal/screens/documents/views/documents_page_screen.dart';
import 'package:ms_ess_potal/screens/holiday&event/bindings/holidays_bindings.dart';
import 'package:ms_ess_potal/screens/holiday&event/views/holiday_screen.dart';
import 'package:ms_ess_potal/screens/home/view/announdement_screen.dart';
import 'package:ms_ess_potal/screens/notification/binding/notification_bindings.dart';
import 'package:ms_ess_potal/screens/notification/view/notification_screen.dart';
import 'package:ms_ess_potal/screens/peripheral/bindings/peripheral_bindings.dart';
import 'package:ms_ess_potal/screens/peripheral/view/peripheral_screen.dart';
import 'package:ms_ess_potal/screens/selfService/bindings/leaveStatus_bindings.dart';
import 'package:ms_ess_potal/screens/selfService/views/leaveWFH_screen.dart';
import 'package:ms_ess_potal/screens/selfService/views/leave_grant_screen.dart';
import 'package:ms_ess_potal/screens/selfService/views/paySlip_screen.dart';
import 'package:ms_ess_potal/screens/signIn/welcome_screen.dart';
import 'package:ms_ess_potal/screens/signUp/signUp_screen.dart';
import 'package:ms_ess_potal/screens/splash_screen_ess.dart';
import '../screens/Statistics/view/statistics_screen.dart';
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
        binding: LeaveStatusBindings()
    ),

    GetPage(
        name: leaveWFHScreen,
        page: ()=>  LeaveWFHScreen(),
        binding: LeaveStatusBindings()
    ),

    GetPage(
        name: paySlipScreen,
        page: ()=> PayslipScreen(),
        binding: PayslipBindings()
    ),

    GetPage(
        name: holidayScreen,
        page: ()=> const HolidayScreen(),
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
        binding: NotificationBindings()
    ),


    GetPage(
        name: announcementScreen,
        page: ()=>  AnnouncementScreen(),
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

    // GetPage(
    //     name: testingScreen,
    //     page: ()=>  AttendancePage(),
    //     // binding: StatisticsBindings()
    // ),


      ];
}
