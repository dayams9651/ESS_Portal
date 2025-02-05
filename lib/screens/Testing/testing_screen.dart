import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/screens/Testing/testing_controller.dart';


class AttendancStaticeScreen extends StatelessWidget {
  final AttendanceStaticsController _controller = Get.put(AttendanceStaticsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Statistics'),
      ),
      body: Obx(() {
        if (_controller.attendanceData.value == null) {
          return Center(child: CircularProgressIndicator());
        }
        var months = _controller.attendanceData.value!.months;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<int>(
                value: _controller.selectedMonthIndex.value,
                onChanged: (int? newIndex) {
                  if (newIndex != null) {
                    _controller.updateSelectedMonth(newIndex);
                  }
                },
                items: List.generate(
                  months.length,
                      (index) => DropdownMenuItem<int>(
                    value: index,
                    child: Text(months[index]),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _controller.attendanceData.value!.data.length,
                itemBuilder: (context, index) {
                  var item = _controller.attendanceData.value!.data[index];
                  var monthData = item.data[_controller.selectedMonthIndex.value];
                  return ListTile(
                    title: Text(item.name),
                    trailing: Text(monthData.toString()),
                  );
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _controller.fetchData,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
