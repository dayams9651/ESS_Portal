import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/screens/signUp/signUp_screen.dart';
import 'package:ms_ess_potal/style/color.dart';
import '../../common/widget/round_button.dart';
import '../../const/image_strings.dart';
import '../../style/text_style.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}
final _formKey1 = GlobalKey<FormState>();
final TextEditingController employeeCodeController = TextEditingController();
class _ForgetPasswordState extends State<ForgetPassword> {
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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80,),
                  Image.asset(
                    logo,
                    height: 110,
                  ),
                  Text("ESS", style: AppTextStyles.kBody24SemiBoldTextStyle),
                  const SizedBox(height: 20,),
                  Text("Recovery my password", style: AppTextStyles.kBody18SemiBoldTextStyle),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Text("Please enter your employee code below to receive instruction for resetting password on mail.", style: AppTextStyles.kSmall12RegularTextStyle),
                  ),
                ],
              ),
              Form(
                key: _formKey1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: employeeCodeController,
                      // obscureText: !_isConfirmPasswordVisible, // Toggle visibility
                      decoration:  const InputDecoration(
                        hintText: 'Employee Code',
                        border: OutlineInputBorder(
                        ),
                      ),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please confirm your password';
                      //   }
                      //   if (value != newPasswordController.text) {
                      //     return 'Passwords do not match';
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(height:40,),
                    SizedBox(
                        height: 50,
                        child: RoundButton(title: 'Send Instruction', onTap: (){
                          // Get.to(()=>SignupScreen());
                        },)),
                SizedBox(height: 10,),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 18, color: Colors.black), // Default text style
                      children: [
                        TextSpan(
                            text: 'Know your password ',
                            style: AppTextStyles.kSmall12RegularTextStyle
                        ),
                        TextSpan(text: 'Login',
                            style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor),
                            recognizer: TapGestureRecognizer()..onTap=(){
                          Get.to(()=>SignupScreen());
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
