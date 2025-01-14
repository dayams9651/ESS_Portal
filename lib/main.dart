import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/routes/routes.dart';
import 'package:ms_ess_potal/style/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(300, 800),
        child:GetMaterialApp(
          enableLog: true,
          defaultTransition: Transition.fade,
          opaqueRoute: Get.isPlatformDarkMode,
          popGesture: Get.isLogEnable,
          transitionDuration: Get.defaultDialogTransitionDuration,
          defaultGlobalState: Get.isLogEnable,
          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            // brightness: Brightnessspp.dark,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
            ),
          ),
          initialRoute: ApplicationPages.splashScreen,
          // home: SimpleDataTable(),
          // home: MobileEstimateViewPdfScreen(),
          getPages: ApplicationPages.getApplicationPages(),
        )
    );
  }
}
