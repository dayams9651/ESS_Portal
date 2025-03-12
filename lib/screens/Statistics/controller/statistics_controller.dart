import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/const/api_url.dart';
import 'dart:convert';
import 'package:ms_ess_portal/screens/Statistics/model/attendance_statistics_model.dart';

class AttendanceStaticsController extends GetxController {
  var attendanceData = Rxn<AttendanceStatistics>();
  var selectedMonthIndex = 0.obs; // Current selected month index (0-indexed)
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  // Fetch data from API
  Future<void> fetchData() async {
    try {
      String? token = box.read('token');
      debugPrint('Token: $token');

      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }

      final response = await http.get(
        Uri.parse(apiAttendanceStatistics),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Check response status code
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        attendanceData.value = AttendanceStatistics.fromJson(jsonData);

        // After data is fetched, set the default selected month to the current month
        setDefaultMonth();
      } else {
        debugPrint('Failed to load data. Status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  // Set the default month index (current month)
  void setDefaultMonth() {
    if (attendanceData.value != null) {
      final DateTime now = DateTime.now();
      selectedMonthIndex.value = now.month - 1; // Set to current month, zero-indexed
    }
  }

  // Get data for the selected month
  List<int> getSelectedMonthData() {
    if (attendanceData.value != null) {
      return attendanceData.value!.data
          .map((e) => e.data[selectedMonthIndex.value])
          .toList();
    }
    return [];
  }

  // Update the selected month index
  void updateSelectedMonth(int index) {
    selectedMonthIndex.value = index;
  }
}

