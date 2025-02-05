import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'testing_model.dart';

class AttendanceStaticsController extends GetxController {
  var attendanceData = Rxn<AttendanceStatistics>();
  var selectedMonthIndex = 0.obs; // To track selected month index
  final box = GetStorage();
  Future<void> fetchData() async {
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.get(Uri.parse('https://esstest.mscorpres.net/dashboard/attendance-statistics'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        attendanceData.value = AttendanceStatistics.fromJson(jsonData);
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Get the data for the selected month
  List<int> getSelectedMonthData() {
    if (attendanceData.value != null) {
      return attendanceData.value!.data
          .map((e) => e.data[selectedMonthIndex.value])
          .toList();
    }
    return [];
  }

  // Update selected month
  void updateSelectedMonth(int index) {
    selectedMonthIndex.value = index;
  }
}
