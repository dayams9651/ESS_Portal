import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/common/widget/snackbar_helper.dart';
import 'dart:convert';
import '../../../const/api_url.dart';

class LeaveWithdrawController extends GetxController {
  var isLoading = false.obs;
  var responseMessage = ''.obs;
  final box = GetStorage();

  Future<void> rejectLeaveRequest(String trackId) async {
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
        Uri.parse(apiWithdraw),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        if (responseJson['code'] == 200) {
          debugPrint("Success : ${response.body}");
          responseMessage('Success: ${response.body}');
          showCustomSnackbar('Successfully', '$responseMessage["message"]');
        } else if (responseJson['status'] == 'error' && responseJson['message']['msg'] == 'leave has already withdrawn, no further action required') {
          showCustomSnackbar("Failed", "Leave has already withdrawn, no further action required.");
        } else {
          showCustomSnackbar("Failed", "Leave has already been approved, so you can't reject it.");
          debugPrint("Error : ${response.body}");
        }
      } else {
        showCustomSnackbar("Failed", "Failed to reject leave request. Status Code: ${response.statusCode}");
        debugPrint("Error : ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception : $e");
      responseMessage('Exception: $e');
    } finally {
      isLoading(false);
    }
  }


// Future<void> withdrawLeaveRequest(String trackId) async {
  //   isLoading(true);
  //   var url = Uri.parse('http://192.168.68.107:3005/leave/LeaveWithdraw');
  //   var body = json.encode({
  //     'trackid': trackId,
  //   });
  //
  //   try {
  //     String? token = box.read('token');
  //     if (token == null || token.isEmpty) {
  //       throw Exception('Token not found. Please log in first.');
  //     }
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //       body: body,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       debugPrint("Withdraw success: ${response.body}");
  //       responseMessage('Withdrawn successfully: ${response.body}');
  //     } else {
  //       responseMessage('Error: ${response.statusCode}');
  //       debugPrint("Error: ${response.body}");
  //     }
  //   } catch (e) {
  //     debugPrint("Exception: $e");
  //     responseMessage('Exception: $e');
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}
