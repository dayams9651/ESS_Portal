import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/const/api_url.dart';
import 'dart:convert';
import 'package:ms_ess_portal/screens/dashboard/model/apply_leave_balance_model.dart';

class LeaveApplyBalanceControllerEL extends GetxController {
  var leaveBalance = LeaveResponseModel().obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var leaveOptions = <Options>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeaveBalance;
  }

  final box = GetStorage();

  Future<void> fetchLeaveBalance(String key) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }

      debugPrint("Making API call to $apiLeave");
      final Map<String, String> body = {
        "type": key
      };

      final response = await http.post(
        Uri.parse(apiLeave),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      debugPrint("API call completed with status code: ${response.statusCode}");

      if (response.statusCode == 200) {

        debugPrint('------- Api Response From  $key : ${response.body}');
        var data = json.decode(response.body);
        leaveBalance.value = LeaveResponseModel.fromJson(data);

        if (leaveBalance.value.data?.leaveOptions?.options != null) {
          leaveOptions.value = leaveBalance.value.data!.leaveOptions!.options!;
        }
        debugPrint("fetchLeaveBalance $key ${leaveBalance.value}");
      } else {
        errorMessage.value = "Failed to load data! Status Code: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Error: $e";
      debugPrint("Error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
