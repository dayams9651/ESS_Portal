import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_portal/common/widget/const_text_with_styles.dart';
import 'package:ms_ess_portal/const/image_strings.dart';
import 'package:ms_ess_portal/screens/selfService/controller/leaveStatus_controller.dart';
import 'package:ms_ess_portal/screens/selfService/controller/leave_withdraw_controller.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:shimmer/shimmer.dart';
import '../../../common/widget/round_button.dart';
import '../../../style/text_style.dart';

class LeaveStatusScreen extends GetView<LeaveStatusController> {
  LeaveStatusScreen({super.key});
  @override
  final LeaveStatusController controller = Get.put(LeaveStatusController());
  final LeaveWithdrawController controllerwithdraw = Get.put(LeaveWithdrawController());
  String? _selectedLeaveType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Center(child: Text("Leave Status", style: AppTextStyles.kPrimaryTextStyle)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
        } else if (controller.leaveStatus.isEmpty) {
          return Center(child: Image.asset(noData1));
        } else {
          final filteredLeaveStatus = _selectedLeaveType == null
              ? controller.leaveStatus
              : controller.leaveStatus.where((leave) {
            return leave.leavetype == _selectedLeaveType;
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: filteredLeaveStatus.length,
                  itemBuilder: (context, index) {
                    final leaveRequest = filteredLeaveStatus[index];
                    final statusColor = controller.getStatusColor(leaveRequest.status.toString());
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.white70),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      border: Border.all(color: AppColors.white70),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Center(
                                      child: Text(
                                        leaveRequest.status.toString(),
                                        style: AppTextStyles.kSmall10SemiBoldTextStyle.copyWith(color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Text("${leaveRequest.todt} - ${leaveRequest.fromdt}", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                  const SizedBox(height: 3),
                                  Text(leaveRequest.trackid.toString(), style: AppTextStyles.kSmall12RegularTextStyle),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showBottomSheet(context, index);
                                },
                                child: AbsorbPointer(
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.white, size: 35),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  void _showBottomSheet(BuildContext context, int index) {
    final leaveRequest = controller.leaveStatus[index];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "${leaveRequest.leavetype}",
                      style: AppTextStyles.kCaption14SemiBoldTextStyle,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const12TextBold("Start Date"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  size: 28,
                                  color: AppColors.white50,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  leaveRequest.todt.toString(),
                                  style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const12TextBold("End Date"),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  size: 28,
                                  color: AppColors.white50,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  leaveRequest.fromdt.toString(),
                                  style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppColors.error60,
                          size: 27,
                        ),
                        const SizedBox(width: 5),
                        const10TextBold("Reporting to ${leaveRequest.reportto} for ${leaveRequest.totalday}"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("Reason", style: AppTextStyles.kPrimaryTextStyle),
                  const SizedBox(height: 5),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white40),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        leaveRequest.remark ?? "",
                        style: TextStyle(fontSize: 16, color: AppColors.white60),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (leaveRequest.status.toString() == 'PEN')
                    Obx(() {
                      if (controllerwithdraw.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (!controllerwithdraw.isLoading.value)
                                SizedBox(
                                  width: 100,
                                  child: RoundButton(
                                    title: " Close ",
                                    onTap: () {
                                      Get.back();
                                    },
                                    color: AppColors.error40,
                                  ),
                                ),
                              SizedBox(
                                child: RoundButton(
                                  color: AppColors.success40,
                                  title: '  Withdraw  ',
                                  onTap: () {
                                    controllerwithdraw.rejectLeaveRequest(leaveRequest.trackid.toString());
                                    Get.back();
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


