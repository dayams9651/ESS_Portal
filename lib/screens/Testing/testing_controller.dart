// lib/controllers/leave_balance_controller.dart

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'testing_model.dart';

class LeaveBalanceController extends GetxController {
  // Rx variable to store data
  var leaveBalance = LeaveBalanceModel(success: false, data: LeaveData(totalYrBal: 0, lOpBal: 0, lClBal: 0)).obs;
  var isLoading = true.obs;
  var errorMessage = "".obs;
  final box = GetStorage();
  // Method to fetch leave balance data
  Future<void> fetchLeaveBalance() async {
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      isLoading(true);
      final response = await http.post(
        Uri.parse('https://esstest.mscorpres.net/dashboard/leave/EL'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        leaveBalance.value = LeaveBalanceModel.fromJson(jsonResponse);
      } else {
        errorMessage.value = 'Failed to load data';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}
