import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_portal/common/widget/round_button.dart';
import 'package:ms_ess_portal/screens/selfService/controller/paylip_controller.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:ms_ess_portal/style/text_style.dart';
import 'package:shimmer/shimmer.dart';

class PayslipScreen extends StatefulWidget {
  @override
  State<PayslipScreen> createState() => _PayslipScreenState();
}

class _PayslipScreenState extends State<PayslipScreen> {
  int selectedMonth = 2; // Default to February (2)
  int selectedYear = 2025;
  List<String> monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PayslipController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Center(child: Text("Payslip", style: AppTextStyles.kPrimaryTextStyle)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  height: 40,
                  color: AppColors.primaryColor,
                  child: Center(
                    child: DropdownButton<int>(
                      value: selectedYear,
                      items: List.generate(10, (index) {
                        return DropdownMenuItem<int>(
                          value: 2023 + index,
                          child: Text('${2023 + index}'),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value!;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  color: AppColors.white40,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_left_sharp),
                        onPressed: () {
                          setState(() {
                            if (selectedMonth == 1) {
                              selectedMonth = 12;
                              selectedYear--; // Decrease year if moving from January to December
                            } else {
                              selectedMonth--;
                            }
                          });
                        },
                      ),
                      Text(
                        monthNames[selectedMonth - 1], // Display month name
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_right_sharp),
                        onPressed: () {
                          setState(() {
                            if (selectedMonth == 12) {
                              selectedMonth = 1;
                              selectedYear++; // Increase year if moving from December to January
                            } else {
                              selectedMonth++;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: RoundButton(
                    title: "Generate",
                    onTap: () {
                      String formattedDate = '$selectedYear-${selectedMonth.toString().padLeft(2, '0')}';
                      controller.fetchPayslipData(formattedDate);
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highLightColor,
                    child: loadSke(),
                  );
                }
                if (controller.payslip.value == null) {
                  return Text('No data available');
                }
                final payslip = controller.payslip.value!;
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.success10,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Text('Earnings:', style: AppTextStyles.kCaption14SemiBoldTextStyle)),
                            ...payslip.earnings.map((earning) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(earning.label, style: AppTextStyles.kSmall12SemiBoldTextStyle)),
                                    Text(earning.value, style: AppTextStyles.kCaption13SemiBoldTextStyle),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.error10,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Text('Deductions:', style: AppTextStyles.kCaption14SemiBoldTextStyle)),
                            ...payslip.deductions.map((deduction) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(deduction.label, style: AppTextStyles.kSmall12SemiBoldTextStyle)),
                                    Text(deduction.value, style: AppTextStyles.kCaption13SemiBoldTextStyle),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Earnings', style: AppTextStyles.kBody16SemiBoldTextStyle.copyWith(color: AppColors.success40)),
                          Text('${payslip.total.earnings}', style: AppTextStyles.kBody16SemiBoldTextStyle.copyWith(color: AppColors.success40)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Deductions:', style: AppTextStyles.kBody16SemiBoldTextStyle.copyWith(color: AppColors.error40)),
                          Text('${payslip.total.deductions}', style: AppTextStyles.kBody16SemiBoldTextStyle.copyWith(color: AppColors.error20)),
                        ],
                      ),
                      SizedBox(height: 25),
                      RoundButton(title: "Download", onTap: () {})
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}



