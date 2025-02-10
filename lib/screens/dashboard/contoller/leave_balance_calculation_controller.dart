import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/const/api_url.dart';
import 'dart:convert';

import 'package:ms_ess_portal/screens/dashboard/model/apply_leave_balance_model.dart';
import 'package:ms_ess_portal/screens/dashboard/model/leave_balance_calculation_model.dart';
import 'package:ms_ess_portal/screens/dashboard/model/leave_balance_update_model.dart';

class LeaveApplyBalanceControllerController extends GetxController {
  var leaveBalanceCalculate = LeaveBalanceCalculationModel().obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeaveBalanceCalculate;
  }
  final box = GetStorage();
  Future<void> fetchLeaveBalanceCalculate(String key) async {
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.get(Uri.parse('$apiLeaveCalculation$key'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        debugPrint('------- Api Response From  $key : ${response.body}');
        leaveBalanceCalculate.value = LeaveBalanceCalculationModel.fromJson(data);
        debugPrint("fetchLeaveBalanceCalculate $key ${leaveBalanceCalculate.value}");
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