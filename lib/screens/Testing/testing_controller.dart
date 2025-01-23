// // lib/controllers/leave_balance_controller.dart
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:ms_ess_potal/screens/Testing/testing_model.dart';
//
// class LeaveBalanceController extends GetxController {
//   var isLoading = false.obs;  // This is reactive
//   var leaveBalance = Rxn<LeaveBalanceModel1>();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchLeaveBalance();
//   }
//   final box = GetStorage();
//
//   Future<void> fetchLeaveBalance() async {
//     isLoading.value = true;
//     final url = 'https://esstest.mscorpres.net/dashboard/leave/WFH';
//
//     try {
//       String? token = box.read('token');
//       if (token == null || token.isEmpty) {
//         throw Exception('Token not found. Please log in first.');
//       }
//       final response = await http.post(Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         // Decode the response body and print it in the terminal
//         var decodedResponse = json.decode(response.body);
//         debugPrint("WFH API Response: $decodedResponse");  // Print the entire response
//         leaveBalance.value = LeaveBalanceModel1.fromJson(decodedResponse);
//       } else {
//         // If the API request fails
//         print('Failed to load data. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Catch any errors and print the error message
//       print("Error: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
