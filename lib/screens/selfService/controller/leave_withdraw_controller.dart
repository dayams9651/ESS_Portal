
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/style/color.dart';
import 'package:ms_ess_portal/style/text_style.dart';
import 'dart:convert';
import '../../../const/api_url.dart';

class LeaveWithdrawController extends GetxController {
  var isLoading = false.obs;
  var responseMessage = ''.obs;
  final box = GetStorage();

  Future<void> rejectLeaveRequest(String trackId) async {
    isLoading.value = true;
    var body = json.encode({
      'trackid': trackId,
    });

    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.post(
        Uri.parse(apiWithdraw),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      isLoading.value = false;

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        if (responseJson['code'] == 200) {
          debugPrint("Success : ${response.body}");
          responseMessage('Success: ${response.body}');
          AwesomeDialog(
            titleTextStyle: AppTextStyles.kCaption14SemiBoldTextStyle,
            context: Get.context!,
            dialogType: DialogType.success,
            buttonsTextStyle: AppTextStyles.kSmall12SemiBoldTextStyle,
            btnOkColor: AppColors.success20,
            title: 'Successfully',
            desc: 'Withdraw your applied leave',
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
          // showCustomSnackbar('Successfully', 'Withdraw your applied leave', backgroundColor: AppColors.success20);
        } else if (responseJson['status'] == 'error' && responseJson['message']['msg'] == 'leave has already withdrawn, no further action required') {
          AwesomeDialog(
            titleTextStyle: AppTextStyles.kCaption14SemiBoldTextStyle,
            context: Get.context!,
            dialogType: DialogType.error,
            buttonsTextStyle: AppTextStyles.kSmall12SemiBoldTextStyle,
            btnOkColor: AppColors.error20,
            title: 'Failed',
            desc: 'Leave has already withdrawn, no further action required.',
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
          // showCustomSnackbar("Failed", "Leave has already withdrawn, no further action required.", backgroundColor: AppColors.error20,);
        } else {
          AwesomeDialog(
            titleTextStyle: AppTextStyles.kCaption14SemiBoldTextStyle,
            context: Get.context!,
            dialogType: DialogType.error,
            buttonsTextStyle: AppTextStyles.kSmall12SemiBoldTextStyle,
            btnOkColor: AppColors.error20,
            title: 'Failed',
            desc: "Leave has already been approved, so you can't reject it.",
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
          // showCustomSnackbar("Failed", "Leave has already been approved, so you can't reject it.", backgroundColor: AppColors.error20);
          debugPrint("Error : ${response.body}");
        }
      } else {
        AwesomeDialog(
          titleTextStyle: AppTextStyles.kCaption14SemiBoldTextStyle,
          context: Get.context!,
          dialogType: DialogType.error,
          buttonsTextStyle: AppTextStyles.kSmall12SemiBoldTextStyle,
          btnOkColor: AppColors.error20,
          title: 'Failed',
          desc: 'Failed to reject leave request. Status Code: ${response.statusCode}',
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
        // showCustomSnackbar("Failed", "Failed to reject leave request. Status Code: ${response.statusCode}");
        debugPrint("Error : ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception : $e");
      responseMessage('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

}
