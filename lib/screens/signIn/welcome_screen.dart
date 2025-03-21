import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/common/widget/round_button.dart';
import 'package:ms_ess_potal/const/image_strings.dart';
import 'package:ms_ess_potal/screens/signUp/signUp_screen.dart';
import 'package:ms_ess_potal/style/color.dart';
import 'package:ms_ess_potal/style/text_style.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Change this to start to avoid spacing between widgets
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100), // Add some space if needed
                Center(
                  child: Image.asset(
                    logo,
                    height: 130,
                  ),
                ),
                Text("ESS", style: AppTextStyles.kBody24SemiBoldTextStyle)
              ],
            ),
            // SizedBox(height: 400,),
            Column(
              children: [
                SizedBox(
                  height: 50,
                  child: RoundButton(
                    title: 'Login',
                    onTap: () {
                      Get.to(() => SignupScreen());
                    },
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Manage your work profile and access all features',
                  style: AppTextStyles.kSmall12RegularTextStyle,
                ),
                SizedBox(height: 40)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

