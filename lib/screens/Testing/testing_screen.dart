import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/screens/dashboard/contoller/attendance_controller.dart';

class AttendancePage extends StatelessWidget {
  final AttendanceController controller = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance Tracker')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                controller.fetchAttendanceData('2025-01-01', '2025-01-31');
              },
              child: Text('Fetch Attendance Data'),
            ),
          ),

          // Display the totalPresent value
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return Text(
                'Total Present: ${controller.totalPresent.value}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              );
            }),
          ),

          // Display attendance data list
          Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.errorMessage.isNotEmpty) {
              return Center(child: Text('Error: ${controller.errorMessage.value}'));
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.attendanceList.length,
                  itemBuilder: (context, index) {
                    var attendance = controller.attendanceList[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(attendance.totalTime),
                        subtitle: Text('Date: ${attendance.start}'),  // Fixed from attendance.hashCode to display actual date
                        trailing: Text(attendance.totalTime.isEmpty ? 'No Time' : attendance.totalTime),
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
