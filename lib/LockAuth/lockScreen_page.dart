
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/LockAuth/auth_controller.dart';
import 'package:ms_ess_portal/screens/dashboard/dashboard_screen.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:ms_ess_portal/style/text_style.dart';

class LockScreenPage extends StatelessWidget {
  final CustomAuthController authController = Get.put(CustomAuthController());

  LockScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Obx(() {
          if (authController.isAuthenticated.value) {
            return DashboardScreen(); // Navigate to your DashboardScreen on success
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.lock_outline_sharp,
                      size: 70,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'ESS Locked',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: () => authController.authenticate(),
                      child: Text("Unlock", style: AppTextStyles.kCaption13SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                    ),
                    if (authController.errorMessage.value.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          authController.errorMessage.value,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                )
              ],
            );
          }
        }),
      ),
    );
  }
}