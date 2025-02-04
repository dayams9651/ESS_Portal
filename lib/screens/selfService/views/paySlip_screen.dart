import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';  // For date formatting
import 'package:ms_ess_portal/common/widget/const_text_with_styles.dart';
import 'package:ms_ess_portal/common/widget/round_button.dart';
import 'package:ms_ess_portal/screens/selfService/controller/paylip_controller.dart';
import '../../../style/color.dart';
import '../../../style/text_style.dart';

class PayslipScreen extends GetView<PayslipController> {
  PayslipScreen({super.key});

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
                    child: Text(DateFormat.yMMM().format(controller.selectedDate.value), style: AppTextStyles.kSmall12SemiBoldTextStyle),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: RoundButton(title: 'Generate', onTap: controller.generateDate),
                ),
                IconButton(
                  onPressed: controller.downloadPdf,  // Trigger PDF download here
                  icon: Icon(Icons.file_download_outlined, size: 35, color: AppColors.primaryColor),
                ),
              ],
            ),
            Obx(() {
              if (controller.formattedDate.isNotEmpty) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    if (controller.isFileSaved.value)
                      Text("PDF has been saved!"),
                    Text("Generated Date : ${controller.formattedDate.value}"),
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
  }

  Widget _buildSalaryLabels() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const12Text("Basic"),
        const12Text("Dearness Allowance"),
        const12Text("House Rent Allowance"),
        const12Text("Conveyance Allowance"),
        const12Text("Education Allowance"),
        const12Text("Books & Periodicals"),
        const12Text("Mobile Reimbursement"),
        const12Text("Medical Allowance"),
        const12Text("LTA"),
        SizedBox(height: 10),
        Text("Total", style: AppTextStyles.kCaption14SemiBoldTextStyle.copyWith(color: AppColors.success60)),
      ],
    );
  }

  Widget _buildSalaryValues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const12TextBold("₹ 565"),
        const12TextBold("₹ 1255"),
        const12TextBold("₹ 56"),
        const12TextBold("₹ 56"),
        const12TextBold("₹ 56"),
        const12TextBold("₹ 5668"),
        const12TextBold("₹ 56"),
        const12TextBold("₹ 56"),
        SizedBox(height: 10),
        Text("₹ 5600", style: AppTextStyles.kCaption14SemiBoldTextStyle.copyWith(color: AppColors.success60)),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const12Text("EPF"),
        const12Text("ESI"),
        const12Text("Advance"),
        SizedBox(height: 10),
        Text("Total", style: AppTextStyles.kCaption14SemiBoldTextStyle.copyWith(color: AppColors.error40)),
      ],
    );
  }

  Widget _buildDeductionsValues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const12TextBold("₹ 565"),
        const12TextBold("₹ 56"),
        const12TextBold("₹ 56"),
        SizedBox(height: 10),
        Text("₹ 5600", style: AppTextStyles.kCaption14SemiBoldTextStyle.copyWith(color: AppColors.error40)),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != controller.selectedDate.value) {
      controller.updateDate(DateTime(picked.year, picked.month, 1));
    }
  }
}
