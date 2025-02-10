import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/routes/routes.dart';
import 'package:ms_ess_portal/screens/signIn/welcome_screen.dart';
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
      final loggedIn =  box.read('token') != null;
      debugPrint("box.read('token') loggedIn==$loggedIn ${ await box.read('token')}");
      if (loggedIn) {
        debugPrint("loggedIn $loggedIn");
        Get.offNamed(ApplicationPages.dashboardScreen);
      } else {
        debugPrint("loggedIn $loggedIn");
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
        child: Image.asset(
          splashGif,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
