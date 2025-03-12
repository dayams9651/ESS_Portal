import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ms_ess_portal/common/widget/snackbar_helper.dart';
import 'package:ms_ess_portal/const/api_url.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:ms_ess_portal/style/text_style.dart';

class ApproveRequestController extends GetxController {
  var isAcceptLoading = false.obs;
  var isRejectLoading = false.obs;
  var isSuccess = false.obs;
  var errorMessage = ''.obs;
  var responseMessage = ''.obs;
  final box = GetStorage();

  // Accept Request
  Future<void> acceptRequest(String trackId) async {
    isAcceptLoading.value = true;
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
      isAcceptLoading.value = false;

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        if (responseJson['status'] == 'success') {
          responseMessage('Success: ${responseJson['message']}');
          debugPrint("Confirm response :  ${response.body}");
          AwesomeDialog(
            titleTextStyle: AppTextStyles.kCaption14SemiBoldTextStyle,
            context: Get.context!,
            dialogType: DialogType.success,
            buttonsTextStyle: AppTextStyles.kSmall12SemiBoldTextStyle,
            btnOkColor: AppColors.success20,
            title: 'Successfully',
            desc: '${responseJson['message']}',
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
                Icons.check_circle_outline,
                color: Colors.white,
                size: 80,
              ),
            ),
          ).show();
          // showCustomSnackbar('Successfully', '${responseJson['message']}', backgroundColor: AppColors.success40);
        } else {
          debugPrint("Confirm response1 :  ${response.body}");
          responseMessage('Failed : ${responseJson['message']['msg']}');
          showCustomSnackbar('Failed', '${responseJson['message']['msg']}', backgroundColor: AppColors.error20);
        }
      } else {
        responseMessage('Error: ${response.statusCode}');
        debugPrint("Confirm response 2:  ${response.body}");

        showCustomSnackbar('Failed', 'An unexpected error occurred', backgroundColor: AppColors.error20);
        debugPrint("Error : ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception : $e");
      responseMessage('Exception: $e');
      showCustomSnackbar('Error1', 'An error occurred: $e', backgroundColor: AppColors.error20);
    } finally {
      isAcceptLoading.value = false;
    }
  }

  // Reject Request
  Future<void> rejectRequest(String trackId) async {
    isRejectLoading.value = true;
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
          AwesomeDialog(
            titleTextStyle: AppTextStyles.kCaption14SemiBoldTextStyle,
            context: Get.context!,
            dialogType: DialogType.success,
            buttonsTextStyle: AppTextStyles.kSmall12SemiBoldTextStyle,
            btnOkColor: AppColors.success20,
            title: 'Successfully',
            desc: '${responseJson['message']}',
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
                Icons.check_circle_outline,
                color: Colors.white,
                size: 80,
              ),
            ),
          ).show();
          // showCustomSnackbar('Successfully', '${responseJson['message']}', backgroundColor: AppColors.success40);
        } else {
          responseMessage('Failed : ${responseJson['message']['msg']}');
          AwesomeDialog(
            titleTextStyle: AppTextStyles.kCaption14SemiBoldTextStyle,
            context: Get.context!,
            dialogType: DialogType.error,
            buttonsTextStyle: AppTextStyles.kSmall12SemiBoldTextStyle,
            btnOkColor: AppColors.error20,
            title: 'Failed',
            desc: "${responseJson['message']['msg']}",
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
          // showCustomSnackbar('Failed', '${responseJson['message']['msg']}', backgroundColor: AppColors.error20);
        }
      } else {
        responseMessage('Error: ${response.statusCode}');
        AwesomeDialog(
          titleTextStyle: AppTextStyles.kCaption14SemiBoldTextStyle,
          context: Get.context!,
          dialogType: DialogType.error,
          buttonsTextStyle: AppTextStyles.kSmall12SemiBoldTextStyle,
          btnOkColor: AppColors.error20,
          title: 'Failed',
          desc: "An unexpected error occurred",
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
        // showCustomSnackbar('Failed', 'An unexpected error occurred', backgroundColor: AppColors.error20);
        debugPrint("Error : ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception : $e");
      responseMessage('Exception: $e');
      showCustomSnackbar('Error', 'An error occurred: $e');
    } finally {
      isRejectLoading.value = false;
    }
  }
}

