import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ms_ess_portal/noInternet/no_internet_screen.dart';
import 'package:ms_ess_portal/routes/routes.dart';
import 'package:ms_ess_portal/screens/notification/view/notification_screen.dart';
import 'package:ms_ess_portal/service/logInApi.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  await GetStorage.init();
  await Upgrader.clearSavedSettings();
  Get.put(ConnectivityService());
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("77d4afee-a29f-4dfd-8b18-11e0384bffc1");
  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String? result;
    OneSignal.Notifications.addClickListener((event){
      final data = event.notification.additionalData;
      result = data?['result'];
      box.write("Daya", result);
      debugPrint("daya12 : ${data?["msg_title"]}");
      if (result != null && data != null) {
        String msgTitle = data["msg_title"];
        String msgDescription = data["msg_dis"];
        box.write('msg_title', msgTitle);
        box.write('msg_timestamp', DateTime.now().toIso8601String());
        box.write('msg_dis', msgDescription);
        debugPrint("Message Description: $msgDescription");
      }
      if (result != null) {
        Get.to(
          NotificationScreen(),
          arguments: {
            "msg_title": data?["msg_title"],
            "msg_dis": data?["msg_dis"],
          },
        );
      }
    });

    return UpgradeAlert(
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(300, 800),
        child: GetMaterialApp(
          enableLog: true,
          defaultTransition: Transition.fade,
          opaqueRoute: Get.isPlatformDarkMode,
          popGesture: Get.isLogEnable,
          transitionDuration: Get.defaultDialogTransitionDuration,
          defaultGlobalState: Get.isLogEnable,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(),
          ),
          initialRoute: ApplicationPages.splashScreen,
          getPages: ApplicationPages.getApplicationPages(),
        ),
      ),
    );
  }
}


