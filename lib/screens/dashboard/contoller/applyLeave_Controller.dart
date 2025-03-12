import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/style/color.dart';
import 'package:ms_ess_portal/style/text_style.dart';
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
      debugPrint('Response Status Code : ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == "success") {
          String msg = jsonResponse['message'];
          AwesomeDialog(
            titleTextStyle: AppTextStyles.kCaption14SemiBoldTextStyle,
            context: Get.context!,
            dialogType: DialogType.success,
            buttonsTextStyle: AppTextStyles.kSmall12SemiBoldTextStyle,
            btnOkColor: AppColors.success20,
            title: 'Successfully',
            desc: '$msg',
            btnOkOnPress: () {
              // Optional: You can do something when the "OK" button is pressed.
            },
            headerAnimationLoop: false,
            customHeader: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success40,
              ),
              child: Icon(
                Icons.check_circle_outline, // Error icon
                color: Colors.white, // Icon color
                size: 80, // Icon size
              ),
            ),
          ).show();
          // Get.snackbar('Success', msg, backgroundColor: AppColors.success20);
        } else {
          String errorMsg = jsonResponse['message']['msg'];
          AwesomeDialog(
            titleTextStyle: AppTextStyles.kCaption14SemiBoldTextStyle,
            context: Get.context!,
            dialogType: DialogType.error,
            buttonsTextStyle: AppTextStyles.kSmall12SemiBoldTextStyle,
            btnOkColor: AppColors.error20,
            title: 'Failed',
            desc: '$errorMsg',
            btnOkOnPress: () {
              // Optional: You can do something when the "OK" button is pressed.
            },
            headerAnimationLoop: false,
            customHeader: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Icon(
                Icons.error, // Error icon
                color: Colors.white, // Icon color
                size: 80, // Icon size
              ),
            ),
          ).show();
          // Get.snackbar('Failed', errorMsg, backgroundColor: AppColors.error20);
        }
      } else if (response.statusCode == 400) {
        Get.snackbar('Bad Request', 'The request is invalid or malformed.', backgroundColor: AppColors.error20);
      } else if (response.statusCode == 500) {
        AwesomeDialog(
          titleTextStyle: AppTextStyles.kCaption14SemiBoldTextStyle,
          context: Get.context!,
          dialogType: DialogType.error,
          buttonsTextStyle: AppTextStyles.kSmall12SemiBoldTextStyle,
          btnOkColor: AppColors.error20,
          title: 'Server Error',
          desc: 'Something went wrong on the server. Please try again later.',
          btnOkOnPress: () {
            // Optional: You can do something when the "OK" button is pressed.
          },
          headerAnimationLoop: false,
          customHeader: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: Icon(
              Icons.error, // Error icon
              color: Colors.white, // Icon color
              size: 80, // Icon size
            ),
          ),
        ).show();

        // Get.snackbar('Server Error', 'Something went wrong on the server. Please try again later.', backgroundColor: AppColors.error20);
      } else {
        Get.snackbar('Error', 'Unexpected error occurred: ${response.statusCode}', backgroundColor: AppColors.error20);
      }

    } catch (e) {
      errorMessage('An error occurred: $e');
      // Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}