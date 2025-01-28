import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_potal/const/api_url.dart';
import 'dart:convert';
import 'package:ms_ess_potal/screens/selfService/models/leave_req_model.dart';
class LeaveGrantController extends GetxController {
  var leaveRequestsData = <LeaveGrantModel>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;

  @override
  void onInit() {
    fetchLeaveGrant();
    super.onInit();
  }
  final box = GetStorage();
  Future<void> fetchLeaveGrant() async {
    isLoading(true);
    String? token = box.read('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token not found. Please log in first.');
    }
    try {
      final response = await http.get(Uri.parse(apiLeaveGrant),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint("Leave Request Api response : ${response.body}");
        final List<LeaveGrantModel> leaveData = (data['data'] as List)
            .map((leaveRequest) => LeaveGrantModel.fromJson(leaveRequest))
            .toList();
        leaveRequestsData.assignAll(leaveData);
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



//
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:ms_ess_potal/screens/selfService/models/leave_grant_model.dart';
//
//
// class LeaveGrantController extends GetxController {
//   var leaveStatusData = <LeaveGrantModel>[].obs;
//   var isLoading = true.obs;
//   final box = GetStorage();
//   Future<void> fetchLeaveGrant() async {
//     String? token = box.read('token');
//     if (token == null || token.isEmpty) {
//       throw Exception('Token not found. Please log in first.');
//     }
//     try {
//       isLoading(true);
//       var response = await http.get(
//         Uri.parse('https://esstest.mscorpres.net/audit'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         debugPrint("Leave Grant Api Response ${response.body}");
//         final List<LeaveGrantModel> leaveGrant = (data['data'] as List)
//             .map((leaveRequest) => LeaveGrantModel.fromJson(leaveRequest))
//             .toList();
//         leaveStatusData.assignAll(leaveGrant);
//       } else {
//         throw Exception('Failed to load leave data');
//       }
//     } catch (e) {
//       debugPrint('Error fetching leave requests: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
//
// }
