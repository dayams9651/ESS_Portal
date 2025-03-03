import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:ms_ess_portal/screens/Terms&Condition/screen/term_and_condition_screen.dart';
import 'package:ms_ess_portal/screens/dashboard/dashboard_screen.dart';
import '../common/widget/snackbar_helper.dart';
import '../const/api_url.dart';
import '../screens/signUp/model/loginIn_response_model.dart';
import '../style/color.dart';
final box = GetStorage();
class UserLogInService extends GetxController {
  RxBool isLoading = false.obs;
  var responseMessage = ''.obs;
  var logInData = Rxn<LoginResponse>();
  final box = GetStorage();

  Future<void> logInUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(logInApi),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        debugPrint("$response.statusCode");
        debugPrint("LogIn Api Response : ${response.body}");

        if (responseData['success'] == true) {
          String token = responseData['data']['token'];
          box.write('token', token);
          debugPrint("Saved Token: $token");
          debugPrint("LogIn Api Response : ${response.body}");
          showCustomSnackbar('LogIn', '${responseData['message']}', backgroundColor: AppColors.success20);
          Get.to(TermAndConditionScreen());

          var decodedResponse = json.decode(response.body);
          logInData.value = LoginResponse.fromJson(decodedResponse);
        } else {
          showCustomSnackbar('Error', responseData['message'] ?? 'Your Employee ID or Password is wrong',
              backgroundColor: AppColors.error10);
          debugPrint("Error: ${responseData['message']}");
        }
      } else if (response.statusCode == 504) {
        showCustomSnackbar('Error', 'Your Employee ID or Password is wrong', backgroundColor: AppColors.error10);
      } else {
        showCustomSnackbar('Alert', 'Your Employee ID or Password is wrong', backgroundColor: AppColors.error10);
      }
    } catch (error) {
      debugPrint("$error");
      debugPrint("$responseMessage");
      showCustomSnackbar('Alert', 'Your Employee ID or Password is wrong', backgroundColor: AppColors.error10);
    }
  }

  // To retrieve the saved token
  String getToken() {
    return box.read('token') ?? '';
  }

  bool isUserLoggedIn() {
    return box.read('token') != null;
  }
}




