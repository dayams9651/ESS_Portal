import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/screens/forgetPassword/forgetPassword_controller.dart';
import 'package:ms_ess_portal/screens/signUp/signUp_screen.dart';
import 'package:ms_ess_portal/style/color.dart';
import '../../common/widget/round_button.dart';
import '../../const/image_strings.dart';
import '../../style/text_style.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}
final _formKey1 = GlobalKey<FormState>();
final TextEditingController userIdController = TextEditingController();
final AuthController authController = Get.put(AuthController());
class _ForgetPasswordState extends State<ForgetPassword> {
  // Move _formKey1 inside the State class
  final _formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24,), // Change this to any icon you prefer
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Image.asset(
                    logo,
                    height: 110,
                  ),
                  Text("ESS", style: AppTextStyles.kBody24SemiBoldTextStyle),
                  const SizedBox(height: 20),
                  Text("Recovery my password", style: AppTextStyles.kBody18SemiBoldTextStyle),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Text("Please enter your employee code below to receive instruction for resetting password on mail.", style: AppTextStyles.kSmall12RegularTextStyle),
                  ),
                ],
              ),
              Form(
                key: _formKey1,  // Use the formKey defined in the State class
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: userIdController,
                      decoration: const InputDecoration(
                        hintText: 'Employee Code',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value != userIdController.text) {
                          return 'Please Provide Your Employee Code';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    Obx(() {
                      return authController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                        height: 50,
                        child: RoundButton(
                          title: 'Send Instruction',
                          onTap: () {
                            authController.resetPassword(userIdController.text);
                          },
                        ),
                      );
                    }),
                    const SizedBox(height: 10),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          children: [
                            TextSpan(
                                text: 'Know your password ',
                                style: AppTextStyles.kSmall12RegularTextStyle),
                            TextSpan(
                                text: 'Login',
                                style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() => const SignupScreen());
                                  })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

