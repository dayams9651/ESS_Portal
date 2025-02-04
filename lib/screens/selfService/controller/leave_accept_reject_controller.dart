import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RejectRequestController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var errorMessage = ''.obs;
  final box = GetStorage();

  Future<void> rejectRequest() async {
    isLoading.value = true;
    isSuccess.value = false;
    errorMessage.value = '';

    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.post(
        Uri.parse('https://esstest.mscorpres.net/request/reject'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "trackid" : "REQ24120520084786809"
        }),
      );
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        isSuccess.value = true;
      } else {
        errorMessage.value = 'Failed to reject the request. Response: ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> acceptRequest() async {
    isLoading.value = true;
    isSuccess.value = false;
    errorMessage.value = '';
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.post(
        Uri.parse('https://esstest.mscorpres.net/request/approve'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "trackid" : "REQ24120520084786809"
        }),
      );
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        isSuccess.value = true;
      } else {
        errorMessage.value = 'Failed to accept the request. Response: ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}


