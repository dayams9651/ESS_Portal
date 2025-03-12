
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../const/api_url.dart';
import '../model/leave_list_model.dart';
class LeaveController extends GetxController {
  var leaveRequests = <LeaveRequest>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeaveList();
  }
  final box = GetStorage();
  Future<void> fetchLeaveList() async {
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      isLoading(true);
      final response = await http.post(
        Uri.parse(leaveListApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        debugPrint("Leave List Response ${response.body}");
        var data = json.decode(response.body);
        debugPrint('Leave List Response : $data');
        var fetchLeaveList = (data['data'] as List)
            .map((item) => LeaveRequest.fromJson(item))
            .toList();
        leaveRequests.assignAll(fetchLeaveList);
      } else {
        debugPrint('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoading(false);
      // debugPrint('isLoading set to false');
    }
  }

}
