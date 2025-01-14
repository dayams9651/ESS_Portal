import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/screens/signIn/welcome_screen.dart';

class SplashScreenEss extends StatefulWidget {
  const SplashScreenEss({super.key});

  @override
  State<SplashScreenEss> createState() => _SplashScreenEssState();
}

class _SplashScreenEssState extends State<SplashScreenEss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to MsCorprs Automation"),
      ),
      body: Column(
        children: [
        TextButton(onPressed: (){
          Get.to(()=>WelcomeScreen());
        },
        child: Center(child: Text("Click here")))
        ],
      ),
    );
  }
}
