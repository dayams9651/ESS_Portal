import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/screens/dashboard/dashboard_screen.dart';
import 'package:ms_ess_potal/screens/forgetPassword/forget_password.dart';
import 'package:ms_ess_potal/style/color.dart';
import '../../common/widget/round_button.dart';
import '../../const/image_strings.dart';
import '../../style/text_style.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  final TextEditingController employeeCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    employeeCodeController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                  const SizedBox(height: 30,),
                  Text("Welcome Back", style: AppTextStyles.kCaption14RegularTextStyle.copyWith(color: AppColors.primaryColor)),
                  Text("Login to continue", style: AppTextStyles.kBody20SemiBoldTextStyle),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 30,),
                    TextFormField(
                      controller: employeeCodeController,
                      decoration: const InputDecoration(
                        hintText: 'Employee Code',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your employee code';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible, // Toggle visibility
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        // if (value.length < 8) {
                        //   return 'Password must be at least 8 characters';
                        // }
                        // if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
                        //   return 'Password must contain at least one uppercase letter';
                        // }
                        // if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
                        //   return 'Password must contain at least one lowercase letter';
                        // }
                        // if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
                        //   return 'Password must contain at least one digit';
                        // }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5,),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const ForgetPassword());
                      },
                      child: Text(
                        "Forget Password ?",
                        style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    SizedBox(
                      height: 50,
                      child: RoundButton(
                        title: 'Login',
                        onTap: () {
                             Get.to(()=>const DashboardScreen());
                        },
                      ),
                    ),
                    const SizedBox(height: 40,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
