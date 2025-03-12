import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/const/api_url.dart';
import 'dart:convert';

import 'package:ms_ess_portal/screens/selfService/models/leave_grant_model.dart';
import 'package:ms_ess_portal/style/color.dart';
class LeaveStatusController extends GetxController {
  var leaveStatus = <LeaveStatusModel>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var selectedLeaveType = Rx<String?>(null);

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
      final response = await http.post(Uri.parse(apiLeaveStatus),
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
        debugPrint("else Condition");
        isError(true);
      }
    } catch (e) {
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  List<LeaveStatusModel> get filteredLeaveStatus {
    if (selectedLeaveType.value == null) {
      return leaveStatus;
    }
    return leaveStatus.where((leave) {
      return leave.leavetype == selectedLeaveType.value;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'PEN':
        return AppColors.warning40;
      case 'RTN':
        return AppColors.info20;
      case 'REJ':
        return AppColors.error40;
      case 'APR':
        return AppColors.success40;
      default:
        return AppColors.white70;
    }
  }
}

