import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ms_ess_potal/screens/Testing/testing_model.dart';
import 'package:http/http.dart' as http;

class LeaveApplyController extends GetxController {
  var leaveBalance = LeaveBalance(
    balance: 0,
    options: [],
    sessionValue: '',
    approvalLevel: '',
    totalLevel: '',
  ).obs;

  var isLoading = true.obs;
  final box = GetStorage();

  Future<void> fetchLeaveBalance() async {
    isLoading.value = true;
    String? token = box.read('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token not found. Please log in first.');
    }

    try {
      final response = await http.get(
        Uri.parse("https://esstest.mscorpres.net/apply/balance/EL"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        debugPrint("Apply Leave Balance Aoi Response : ${response.body}");
        if (data['success']) {
          leaveBalance.value = LeaveBalance.fromJson(data['data']);
        } else {
          Get.snackbar('Error', 'Failed to fetch leave balance');
        }
      } else {
        Get.snackbar('Error', 'Failed to load data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}



