import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/style/color.dart';
import 'dart:convert';
import '../../../const/api_url.dart';

class LeaveApplyController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  @override
  void onInit() {
    super.onInit();
    applyLeave;
  }
  final box = GetStorage();
  Future<void> applyLeave(Map<String, dynamic> body, ) async {
    isLoading(true);
    errorMessage('');
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      debugPrint('Token: $token');
      debugPrint('Request Body: ${jsonEncode(body)}');
      final response = await   http.post(
        Uri.parse(apiApplyLeave),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == "success") {
          String msg = jsonResponse['message'];
          Get.snackbar('Success', msg, backgroundColor: AppColors.success40);
        } else {
          String errorMsg = jsonResponse['message']['msg'];
          Get.snackbar('Failed', errorMsg, backgroundColor: AppColors.error20, );
        }
      }
      else {
        errorMessage('Failed to apply leave. Status Code: ${response.statusCode}');
        Get.snackbar('Error', 'Failed to apply leave. Status Code: ');
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}