import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';  // Import GetStorage
import 'package:ms_ess_potal/screens/dashboard/dashboard_screen.dart';
import '../common/widget/snackbar_helper.dart';
import '../const/api_url.dart';
import '../screens/signUp/model/loginIn_response_model.dart';

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
          'password': password
        }),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseData['success']) {
          String token = responseData['data']['token'];
          box.write('token', token);  // Save token here
          debugPrint("Saved Token: $token");

          showCustomSnackbar('LogIn', '${responseData['message']}');
          debugPrint("LogIn Data: ${responseData['message']}");
          Get.to(const DashboardScreen());
          var decodedResponse = json.decode(response.body);
          logInData.value = LoginResponse.fromJson(decodedResponse);
        } else {
          showCustomSnackbar('Error', responseData['message'] ?? 'Your Employee ID or Password is wrong');
          debugPrint("Error ${responseData['message']}");
        }
      } else {
        showCustomSnackbar('Alert', 'Your Employee ID or Password is wrong');
      }
    } catch (error) {
      showCustomSnackbar('Error', 'An error occurred. Please try again later.');
    }
  }

  // To retrieve the saved token
  String getToken() {
    return box.read('token') ?? ''; // Returns token or empty string if not found
  }

  bool isUserLoggedIn() {
    return box.read('token') != null;  // Returns true if token exists
  }
}

