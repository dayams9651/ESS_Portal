import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/screens/Statistics/controller/statistics_controller.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../style/color.dart';
import '../../../style/text_style.dart';

class StatisticsScreen extends GetView<StatisticsController> {
  StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "WO": 30,
      "P": 40,
      "A": 20,
      "SRT": 10,
      "MIS": 10,
      "HLD": 10,
    };
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        // title: Center(child: Text("Attendance Statistics", style: AppTextStyles.kPrimaryTextStyle)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Attendance Statistics",
              style: AppTextStyles.kBody16SemiBoldTextStyle
            ),
            const SizedBox(height: 10),
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
        ),
      ),
    );
  }

}