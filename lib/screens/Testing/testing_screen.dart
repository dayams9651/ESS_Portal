// // lib/screens/leave_balance_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ms_ess_potal/screens/Testing/testing_controller.dart';
//
// class LeaveBalanceScreen extends StatelessWidget {
//   final LeaveBalanceController controller = Get.put(LeaveBalanceController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Leave Balance")),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         // Access the reactive data here
//         final leaveBalance = controller.leaveBalance.value;
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Total Yearly Balance: ${leaveBalance?.data.totalYrBal}', style: TextStyle(fontSize: 18)),
//               SizedBox(height: 10),
//               Text('Leave Open Balance: ${leaveBalance?.data.lOpBal}', style: TextStyle(fontSize: 18)),
//               SizedBox(height: 10),
//               Text('Leave Closed Balance: ${leaveBalance?.data.lClBal??''}', style: TextStyle(fontSize: 18)),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

// Ensure shiftIn?.todayIn is not null and parse the time




