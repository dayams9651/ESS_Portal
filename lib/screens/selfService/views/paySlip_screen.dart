import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';  // For date formatting
import 'package:ms_ess_portal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_portal/common/widget/const_text_with_styles.dart';
import 'package:ms_ess_portal/common/widget/round_button.dart';
import 'package:ms_ess_portal/screens/selfService/controller/paylip_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../style/color.dart';
import '../../../style/text_style.dart';

class PayslipScreen extends StatefulWidget {
  const PayslipScreen({super.key});

  @override
  _PayslipScreenState createState() => _PayslipScreenState();
}

class _PayslipScreenState extends State<PayslipScreen> {
  String selectedMonth = 'February';
  int selectedYear = 2025;
  Map<String, int> monthNames = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'October': 10,
    'November': 11,
    'December': 12,
  };


  final PayslipController payslipController = Get.put(PayslipController());
  @override
  void initState() {
    super.initState();
    payslipController.fetchPayslip(selectedYear, monthNames[selectedMonth]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Center(child: Text("Pay-Slip", style: AppTextStyles.kPrimaryTextStyle)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(  // Make the entire body scrollable
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(DateFormat.yMMM().format(payslipController.selectedDate.value), style: AppTextStyles.kSmall12SemiBoldTextStyle),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: RoundButton(title: 'Generate', onTap: payslipController.generateDate),
                ),
                IconButton(
                  onPressed: payslipController.downloadPdf,  // Trigger PDF download here
                  icon: Icon(Icons.file_download_outlined, size: 35, color: AppColors.primaryColor),
                ),
              ],
            ),
            Obx(() {
              if (payslipController.formattedDate.isNotEmpty) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    if (payslipController.isFileSaved.value)
                      Text("PDF has been saved!"),
                    Text("Generated Date : ${payslipController.formattedDate.value}"),
                    SizedBox(height: 20),
                    _buildSalaryDetailsSection(),
                    SizedBox(height: 20),
                    _buildDeductionsSection(),
                  ],
                );
              } else {
                return SizedBox.shrink();  // Hide this section if no date has been generated yet
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSalaryDetailsSection() {
    return Obx(() {
      if(payslipController.isLoading.value){
        return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
      }
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.white70),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                width: 140,
                decoration: BoxDecoration(
                  color: AppColors.success10,
                  border: Border.all(color: AppColors.success80, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: const12TextBold("Total Salary")),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSalaryLabels(),
                  _buildSalaryValues(),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSalaryLabels() {
    return Obx(() {
      if(payslipController.isLoading.value){
        return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
      }
      final payslipData = payslipController.payslip.value.data;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const12Text(payslipData.earing[0].label),
          const12Text(payslipData.earing[1].label),
          const12Text(payslipData.earing[2].label),
          const12Text(payslipData.earing[3].label),
          const12Text(payslipData.earing[4].label),
          const12Text(payslipData.earing[5].label),
          const12Text(payslipData.earing[6].label),
          const12Text(payslipData.earing[7].label),
          const12Text(payslipData.earing[8].label),
          SizedBox(height: 10),
          Text("Total",
              style: AppTextStyles.kCaption14SemiBoldTextStyle.copyWith(
                  color: AppColors.success60)),
        ],
      );
    });
  }

  Widget _buildSalaryValues() {
    final payslipData = payslipController.payslip.value.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const12TextBold(payslipData.earing[0].value??''),
        const12TextBold(payslipData.earing[1].value??''),
        const12TextBold(payslipData.earing[2].value??''),
        const12TextBold(payslipData.earing[3].value??''),
        const12TextBold(payslipData.earing[4].value??''),
        const12TextBold(payslipData.earing[5].value??''),
        const12TextBold(payslipData.earing[6].value??''),
        const12TextBold(payslipData.earing[7].value??''),
        const12TextBold(payslipData.earing[8].value??''),
        SizedBox(height: 10),
        Text(payslipData.total[0].earnings.toString(), style: AppTextStyles.kCaption14SemiBoldTextStyle.copyWith(color: AppColors.success60)),
      ],
    );
  }

  Widget _buildDeductionsSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.white70),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              width: 140,
              decoration: BoxDecoration(
                color: AppColors.error10,
                border: Border.all(color: AppColors.error100, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: const12TextBold("Deductions")),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDeductionsLabels(),
                _buildDeductionsValues(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeductionsLabels() {
    final payslipData = payslipController.payslip.value.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const12Text(payslipData.deduction[0].label),
        const12Text(payslipData.deduction[1].label),
        const12Text(payslipData.deduction[2].label),
        SizedBox(height: 10),
        Text("Total", style: AppTextStyles.kCaption14SemiBoldTextStyle.copyWith(color: AppColors.error40)),
      ],
    );
  }

  Widget _buildDeductionsValues() {
    final payslipData = payslipController.payslip.value.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const12TextBold(payslipData.deduction[0].value??''),
        const12TextBold(payslipData.deduction[1].value??''),
        const12TextBold(payslipData.deduction[2].value??''),
        SizedBox(height: 10),
        Text(payslipData.total[0].deductions.toString(), style: AppTextStyles.kCaption14SemiBoldTextStyle.copyWith(color: AppColors.error40)),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: payslipController.selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != payslipController.selectedDate.value) {
      payslipController.updateDate(DateTime(picked.year, picked.month, 1));
    }
  }
}


