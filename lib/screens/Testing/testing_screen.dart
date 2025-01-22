// lib/screens/leave_balance_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'testing_controller.dart';

class LeaveBalanceScreen extends StatelessWidget {
  final LeaveBalanceController controller = Get.put(LeaveBalanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leave Balance')),
      body: Obx(() {
        // Check if loading
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Check for errors
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        // Display leave balance data
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Year Balance: ${controller.leaveBalance.value.data.totalYrBal} days'),
              Text('Leave Open Balance: ${controller.leaveBalance.value.data.lOpBal} days'),
              Text('Leave Closed Balance: ${controller.leaveBalance.value.data.lClBal} days'),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.fetchLeaveBalance,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
