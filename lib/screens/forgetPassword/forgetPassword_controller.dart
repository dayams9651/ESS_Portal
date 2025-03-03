import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../const/api_url.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  Future<void> resetPassword(String username) async {
    isLoading(true);
    errorMessage('');
    final resetPassword = Uri.parse(apiResetPassword);
    final empId = json.encode({"username": username});

    try {
      final response = await http.post(
        resetPassword,
        body: empId,
        headers: {'Content-Type': 'application/json'},
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        debugPrint("Forget Password Api Response : ${response.body}");
        if (responseData['success'] == true) {
          final errorMsg = responseData['message']['msg'];
          Get.snackbar("Successfully", errorMsg);
        } else {
          final errorMsg = responseData['message']['msg'] ?? 'An unknown error occurred';
          Get.snackbar('Error', errorMsg);
          errorMessage('Failed to reset password: $errorMsg');
        }
      } else {
        debugPrint("Unexpected status code: ${response.statusCode}");
        errorMessage('Failed to reset password: Unexpected status code');
        Get.snackbar('Error', 'Failed to reset password: Unexpected status code');
      }
    } catch (e) {
      debugPrint("Error: $e");
      errorMessage('An error occurred: $e');
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

}