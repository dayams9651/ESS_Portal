import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/screens/dashboard/model/leave_balance_update_model.dart';
import 'package:ms_ess_portal/screens/dashboard/model/sick_leave_model.dart';
import '../../../const/api_url.dart';

class SickLeaveBalanceController extends GetxController {
  var isLoading = false.obs;
  var sickLeaveBalance = Rxn<SickLeaveModel>(); // Used for initial sick leave data
  var leaveUpdateBalance = Rxn<LeaveUpdateModel>(); // Used for updated sick leave data

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchSickLeaveBalance();
  }

  Future<void> fetchSickLeaveBalance() async {
    isLoading.value = true;
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }

      final response = await http.post(Uri.parse(sickLeaveApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        debugPrint("Sick Leave API Response: $decodedResponse");
        sickLeaveBalance.value = SickLeaveModel.fromJson(decodedResponse); // Store the initial data
        await fetchSickLeaveBalanceUpdate(); // Call the update API to get the latest balance
      } else {
        debugPrint('Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch updated sick leave balance data (this will be called inside fetchSickLeaveBalance)
  Future<void> fetchSickLeaveBalanceUpdate() async {
    isLoading.value = true;
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }

      final response = await http.post(Uri.parse(apiLeaveUpdateSL),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        debugPrint("Sick Leave Update API Response: $decodedResponse");

        // Store the updated leave data in leaveUpdateBalance
        leaveUpdateBalance.value = LeaveUpdateModel.fromJson(decodedResponse);

        // Now update the sickLeaveBalance with the new data from fetchSickLeaveBalanceUpdate
        sickLeaveBalance.value = SickLeaveModel.fromJson(decodedResponse); // Update sickLeaveBalance with the new data

        // Print updated values to the terminal
        if (leaveUpdateBalance.value != null) {
          debugPrint('Updated Sick Leave Balance: ${leaveUpdateBalance.value!.data?.lClBal}');
          debugPrint('Updated Total Year Balance: ${leaveUpdateBalance.value!.data?.totalYrBal}');
        }
      } else {
        debugPrint('Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}


