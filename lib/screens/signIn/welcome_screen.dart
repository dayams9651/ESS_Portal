import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/common/widget/round_button.dart';
import 'package:ms_ess_portal/const/image_strings.dart';
import 'package:ms_ess_portal/screens/signUp/signUp_screen.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:ms_ess_portal/style/text_style.dart';
import 'package:upgrader/upgrader.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 100),
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
      ),
    );
  }
}

