import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/screens/dashboard/model/leave_balance_update_model.dart';
import '../../../const/api_url.dart';
import '../model/earned_leave_model.dart';

class EarnedLeaveController extends GetxController {
  var isLoading = false.obs;
  var earnedLeave = Rxn<LeaveBalanceModel>();
  var leaveUpdateBalance = Rxn<LeaveUpdateModel>();

  @override
  void onInit() {
    super.onInit();
    fetchEarnedLeave();
  }
  final box = GetStorage();
  Future<void> fetchEarnedLeave() async {
    isLoading.value = true;
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.post(Uri.parse(earnedLeaveApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        debugPrint('Earned Leave Response : $decodedResponse');
        earnedLeave.value = LeaveBalanceModel.fromJson(decodedResponse);
      } else {
        debugPrint('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchEarnedLeaveUpdate() async {
    isLoading.value = true;
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.post(Uri.parse(apiLeaveUpdateEL),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        debugPrint('Earned Leave Balance Update Api Response : $decodedResponse');
        leaveUpdateBalance.value = LeaveUpdateModel.fromJson(decodedResponse);
      } else {
        debugPrint('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}