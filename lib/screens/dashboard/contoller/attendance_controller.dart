import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/common/const_api.dart';
import '../model/attendance_model.dart';

class AttendanceController extends GetxController {
  var attendanceList = <Attendance>[].obs;
  var totalPresent = 0.obs;
  var totalMissPunch = 0.obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  final ApiServices _apiService = ApiServices();
  void fetchAttendanceData(String startDate, String endDate) async {
    isLoading(true);
    try {
      AttendanceResponse response = await _apiService.fetchAttendanceData(startDate, endDate);
      debugPrint("Punch In API Response: ${response.toString()}");
      response.data.forEach((attendance) {
        debugPrint("Attendance Title: ${attendance.title}, Date: ${attendance.start}, Total Time: ${attendance.totalTime}");
      });
      attendanceList.assignAll(response.data);
      totalPresent.value = response.totalPresent;
      totalMissPunch.value = response.totalMissPunch;
      debugPrint('${response.totalPresent}');
      debugPrint('${response.totalMissPunch}');
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
