import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ms_ess_portal/common/widget/snackbar_helper.dart';
import 'package:ms_ess_portal/const/api_url.dart';
import 'package:ms_ess_portal/style/color.dart';

class ApproveRequestController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var errorMessage = ''.obs;
  var responseMessage = ''.obs;
  final box = GetStorage();
  Future<void> acceptRequest(String trackId) async {
    isLoading(true);
    var body = json.encode({
      'trackid': trackId,
    });

    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.post(
        Uri.parse(apiLeaveApprove),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        if (responseJson['status'] == 'success') {
          responseMessage('Success: ${responseJson['message']}');
          showCustomSnackbar('Successfully', '${responseJson['message']}', backgroundColor: AppColors.success40);
        } else {
          responseMessage('Failed : ${responseJson['message']['msg']}');
          showCustomSnackbar('Failed', '${responseJson['message']['msg']}', backgroundColor: AppColors.error20);
        }
      } else {
        responseMessage('Error: ${response.statusCode}');
        showCustomSnackbar('Failed', 'An unexpected error occurred', backgroundColor: AppColors.error20);
        debugPrint("Error : ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception : $e");
      responseMessage('Exception: $e');
      showCustomSnackbar('Error1', 'An error occurred: $e', backgroundColor: AppColors.error20);
    } finally {
      isLoading(false);
    }
  }

  Future<void> rejectRequest(String trackId) async {
    isLoading(true);
    var body = json.encode({
      'trackid': trackId,
    });

    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.post(
        Uri.parse(apiLeaveReject),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        if (responseJson['status'] == 'success') {
          responseMessage('Success: ${responseJson['message']}');
          showCustomSnackbar('Successfully', '${responseJson['message']}', backgroundColor: AppColors.success40);
        } else {
          responseMessage('Failed : ${responseJson['message']['msg']}');
          debugPrint(response.body);
          showCustomSnackbar('Failed', '${responseJson['message']['msg']}', backgroundColor: AppColors.error20);
        }
      } else {
        responseMessage('Error: ${response.statusCode}');
        showCustomSnackbar('Failed', 'An unexpected error occurred', backgroundColor: AppColors.error20);
        debugPrint("Error : ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception : $e");
      responseMessage('Exception: $e');
      showCustomSnackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
