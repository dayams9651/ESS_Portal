import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testing_controller.dart';

class LeaveBalanceScreen extends StatefulWidget {
  const LeaveBalanceScreen({super.key});


  @override
  State<LeaveBalanceScreen> createState() => _LeaveBalanceScreenState();
}
final LeaveApplyController leaveApplyController = Get.put(LeaveApplyController());
class _LeaveBalanceScreenState extends State<LeaveBalanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Balance'),
      ),
      body: Obx(() {
        if (leaveApplyController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Leave Balance: ${leaveApplyController.leaveBalance}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text('Session Value: ${leaveApplyController.leaveBalance.value.balance}'),
                SizedBox(height: 10),
                Text('Approval Level: ${leaveApplyController.leaveBalance.value.approvalLevel ?? 'N/A'}'),
                SizedBox(height: 10),
                Text('Total Level: ${leaveApplyController.leaveBalance.value.totalLevel ?? 'N/A'}'),
                SizedBox(height: 30),
                Text('Available Leave Options:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: leaveApplyController.leaveBalance.value.options.length,
                    itemBuilder: (context, index) {
                      var option = leaveApplyController.leaveBalance.value.options[index];
                      return ListTile(
                        title: Text(option.label),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
