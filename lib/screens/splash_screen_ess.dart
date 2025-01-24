import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/routes/routes.dart';
import 'package:ms_ess_potal/screens/signIn/welcome_screen.dart';
import '../const/const_height.dart';
import '../const/const_width.dart';
import '../const/image_strings.dart';
import '../service/logInApi.dart';

class SplashScreenEss extends StatefulWidget {
  const SplashScreenEss({super.key});

  @override
  State<SplashScreenEss> createState() => _SplashScreenEssState();
}

class _SplashScreenEssState extends State<SplashScreenEss> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      final loggedIn = await Get.find<UserLogInService>().isUserLoggedIn() != null;
      if (loggedIn) {
        Get.off(ApplicationPages.dashboardScreen);
      } else {
        Get.to(const WelcomeScreen());
      }
    } catch (e) {
      debugPrint("Error checking login status: $e");
      Get.offAllNamed(ApplicationPages.welcomeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        height: h25,
        width: w25,
        child: Image.asset(
          logo,
        ),
      ),
    );
  }
}
