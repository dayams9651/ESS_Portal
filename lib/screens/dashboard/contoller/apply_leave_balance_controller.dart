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
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.get(Uri.parse('$apiLeave$key'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        debugPrint('------- Api Response From  $key : ${response.body}');
        leaveBalance.value = LeaveResponseModel.fromJson(data);

        if (leaveBalance.value.data?.leaveOptions?.options != null) {
          leaveOptions.value = leaveBalance.value.data!.leaveOptions!.options!;
        }
        debugPrint("fetchLeaveBalance $key ${leaveBalance.value}");
      } else {
        errorMessage.value = "Failed to load data!";
      }
    } catch (e) {
      errorMessage.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }
}