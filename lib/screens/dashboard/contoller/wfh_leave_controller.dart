import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../const/api_url.dart';
import '../model/wfh_leave_balance_model.dart';

class LeaveBalanceController extends GetxController {
  var isLoading = false.obs;
  var leaveBalance = Rxn<LeaveBalanceModel1>();

  @override
  void onInit() {
    super.onInit();
    fetchLeaveBalance();
  }
  final box = GetStorage();

  Future<void> fetchLeaveBalance() async {
    isLoading.value = true;
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.post(Uri.parse(wfhLeaveApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        debugPrint("WFH API Response: $decodedResponse");  // Print the entire response
        leaveBalance.value = LeaveBalanceModel1.fromJson(decodedResponse);
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
