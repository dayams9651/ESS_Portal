import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/screens/dashboard/model/sick_leave_model.dart';
import '../../../const/api_url.dart';

class SickLeaveBalanceController extends GetxController {
  var isLoading = false.obs;
  var sickLeaveBalance = Rxn<SickLeaveModel>();

  @override
  void onInit() {
    super.onInit();
    fetchSickLeaveBalance();
  }
  final box = GetStorage();

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
        sickLeaveBalance.value = SickLeaveModel.fromJson(decodedResponse);
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