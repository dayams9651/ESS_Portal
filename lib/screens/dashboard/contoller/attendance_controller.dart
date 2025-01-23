import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../model/attendance_model.dart';

class AttendanceController extends GetxController {
  var attendanceData = Rx<List<Punch>>([]);
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final box = GetStorage();
  Future<void> fetchAttendanceData(String startDate, String endDate) async {
    isLoading(true);
    errorMessage('');
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.post(
        Uri.parse('https://esstest.mscorpres.net/attendance/view/punch'),
        body: {
          'start': startDate,
          'end': endDate
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['code'] == 200) {
          List<dynamic> punchData = data['result']['data'];
          attendanceData.value = punchData.map((e) => Punch.fromJson(e)).toList();
        } else {
          errorMessage('Failed to load data: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        errorMessage('Failed to load data');
      }
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
