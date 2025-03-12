import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/screens/Testing/testing_controller.dart';

class ReportUI extends StatelessWidget {
  final ReportController controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: controller.selectedPeriod.value,
              onChanged: (String? newValue) {
                controller.selectedPeriod.value = newValue!;
              },
              items: <String>['2025-01', '2025-02', '2025-03']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                controller.downloadReport();
              },
              child: Text('Download Report'),
            ),
          ],
        ),
      )
    );
  }
}