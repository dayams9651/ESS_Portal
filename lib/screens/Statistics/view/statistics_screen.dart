import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_portal/screens/Statistics/controller/statistics_controller.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shimmer/shimmer.dart';
import '../../../style/color.dart';
import '../../../style/text_style.dart';

class StatisticsScreen extends GetView<AttendanceStaticsController> {
  final AttendanceStaticsController _controller = Get.put(AttendanceStaticsController());

  StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
        title: Center(child: Text("Attendance Statistics", style: AppTextStyles.kPrimaryTextStyle)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Obx(() {
              if (_controller.attendanceData.value == null) {
                return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
              }
              var months = _controller.attendanceData.value!.months;
              Map<String, double> dataMap = {};
              var selectedMonthData = _controller.getSelectedMonthData();
              for (int i = 0; i < selectedMonthData.length; i++) {
                String label = _controller.attendanceData.value!.data[i].name;
                double value = selectedMonthData[i].toDouble();
                dataMap[label] = value;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 42,
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppColors.success20,
                      ),
                      child: Center(
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
                    ),
                  ),
                  PieChart(
                    dataMap: dataMap,
                    chartType: ChartType.disc,
                    ringStrokeWidth: 20,
                    centerText: "Attendance",
                    legendOptions: LegendOptions(
                      showLegendsInRow: true,
                      legendShape: BoxShape.rectangle,
                      legendTextStyle: AppTextStyles.kSmall12SemiBoldTextStyle,
                      legendPosition: LegendPosition.bottom,
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}


