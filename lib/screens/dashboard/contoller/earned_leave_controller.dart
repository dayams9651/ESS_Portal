import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../const/api_url.dart';
import '../model/earned_leave_model.dart';
class EarnedLeaveController extends GetxController {
  var earnedLeave = <LeaveBalanceModel>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchEarnedLeave();
  }
  final box = GetStorage();
  Future<void> fetchEarnedLeave() async {
    if (earnedLeave.isNotEmpty) {
      return; // Skip the API call if data is already fetched
    }

    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      isLoading(true);
      final response = await http.post(
        Uri.parse(earnedLeaveApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        debugPrint('Earned Leave Response : $data');
        var fetchEarnedLeave = (data['data'] as List)
            .map((item) => LeaveBalanceModel.fromJson(item))
            .toList();
        earnedLeave.assignAll(fetchEarnedLeave);
      } else {
        debugPrint('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}