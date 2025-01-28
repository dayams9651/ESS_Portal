import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_potal/const/api_url.dart';
import 'package:ms_ess_potal/screens/selfService/models/leave_grant_model.dart';
import 'dart:convert';
import 'package:ms_ess_potal/screens/selfService/models/leave_req_model.dart';
class LeaveStatusController extends GetxController {
  var leaveStatus = <LeaveStatusModel>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;

  @override
  void onInit() {
    fetchLeaveStatus();
    super.onInit();
  }
  final box = GetStorage();
  Future<void> fetchLeaveStatus() async {
    isLoading(true);
    String? token = box.read('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token not found. Please log in first.');
    }
    try {
      final response = await http.get(Uri.parse(apiLeaveStatus),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint("Leave Request Api response : ${response.body}");
        final List<LeaveStatusModel> leaveStatusData = (data['data'] as List)
            .map((leaveRequestStatus) => LeaveStatusModel.fromJson(leaveRequestStatus))
            .toList();
        leaveStatus.assignAll(leaveStatusData);
        isError(false);
      } else {
        isError(true);
      }
    } catch (e) {
      isError(true);
    } finally {
      isLoading(false);
    }
  }
}
