import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/const/image_strings.dart';
import 'package:ms_ess_portal/routes/routes.dart';
import 'package:ms_ess_portal/service/logInApi.dart';

import 'signIn/welcome_screen.dart';
import 'signUp/signUp_screen.dart';

class SplashScreenEss extends StatefulWidget {
  const SplashScreenEss({super.key});

  @override
  State<SplashScreenEss> createState() => _SplashScreenEssState();
}

class _SplashScreenEssState extends State<SplashScreenEss> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Register the observer
    navigateToNextScreen();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    checkTokenAndNavigate();
  }

  void checkTokenAndNavigate() async {
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // If the app is brought to the foreground, check the token again
    if (state == AppLifecycleState.resumed) {
      checkTokenAndNavigate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SizedBox(
          child: Image.asset(
            logo,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}
