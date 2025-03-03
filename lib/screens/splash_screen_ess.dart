import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/routes/routes.dart';
import 'package:ms_ess_portal/screens/signIn/welcome_screen.dart';
import '../const/image_strings.dart';
import '../service/logInApi.dart';
import 'signUp/signUp_screen.dart';

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
      final token = box.read('token');
      final tokenExpiry = box.read('tokenExpiry');
      final currentTime = DateTime.now().millisecondsSinceEpoch;

      if (token == null) {
        Get.to(const WelcomeScreen());
      } else if (tokenExpiry != null && currentTime > tokenExpiry) {
        debugPrint("Token has expired, redirecting to SignupScreen");
        Get.to(const SignupScreen());
      } else {
        debugPrint("Token is valid, navigating to lock screen");
        Get.offNamed(ApplicationPages.lockScreenScreen);
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
        child: Image.asset(
          logo,
          // fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}

