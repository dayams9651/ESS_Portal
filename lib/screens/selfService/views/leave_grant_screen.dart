import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_potal/common/widget/const_text_with_styles.dart';
import 'package:ms_ess_potal/screens/selfService/controller/leave_grant_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../common/widget/round_button.dart';
import '../../../style/color.dart';
import '../../../style/text_style.dart';
class LeaveGrantScreen extends GetView<LeaveGrantController> {
  LeaveGrantScreen({super.key});
  final LeaveGrantController controller1 = Get.put(LeaveGrantController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text("Leave Grant", style: AppTextStyles.kPrimaryTextStyle)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx((){
        if(controller1.isLoading.value){
          return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
        }
        else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller1.leaveRequestsData.length, // Number of items in the list
                  itemBuilder: (context, index) {
                    final leaveRequest = controller1.leaveRequestsData[index];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        // height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.white70),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 7),
                                      Text("${leaveRequest.empname} ( ${leaveRequest.empcode} )", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                      const SizedBox(height: 3),
                                      Text(leaveRequest.department, style: AppTextStyles.kSmall10RegularTextStyle),
                                    ],
                                  ),
                                  const SizedBox(height: 7),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${leaveRequest.leavetype} for ${leaveRequest.totalday}", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                                      const SizedBox(height: 3),
                                      Text("Request date : ${leaveRequest.regago}", style: AppTextStyles.kSmall10RegularTextStyle),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  showPopUp(context, index); // Trigger the pop-up on icon tap
                                },
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.white60),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child:  const Center(
                                    child: Icon(Icons.visibility_outlined, color: AppColors.primaryColor, size: 30),
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
      })
    );
  }

  // Method to show the pop-up
  void showPopUp(BuildContext context, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final leaveRequest = controller1.leaveRequestsData[index];
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Square corners
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(12),
            // width: MediaQuery.of(context).size.width * 1.0, // Adjust the width if needed
            child: Column(
              mainAxisSize: MainAxisSize.min, // Make dialog height flexible to content
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the pop-up
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Reduced space to minimize height
                Text("${leaveRequest.empname} ( ${leaveRequest.empcode} )", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                const SizedBox(height: 3), // Reduced space to minimize height
                const10Text(" as ${leaveRequest.designation}"),
                const SizedBox(height: 7,),
                Text("${leaveRequest.leavetype} For ${leaveRequest.totalday}", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                const10Text("Request date : ${leaveRequest.regago}"),
                const SizedBox(height: 7,),
                const10TextBold("Reason"),
                const10Text("Due to punch machine not setup in B-88 branch"),
                const SizedBox(height: 10), // Reduced space to minimize height
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const12TextBold('Date'),
                        Text(leaveRequest.regdate, style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                      ],
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     const12TextBold('Session'),
                    //     Text('9:00 AM - 11:30 AM', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                    //   ],
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const12TextBold('Days'),
                        Text(leaveRequest.totalday, style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: 100,
                        child: RoundButton(title: 'Accept', onTap:(){}, color: AppColors.error40, ),),
                    SizedBox(
                      width: 100,
                      child: RoundButton(title: 'Reject', onTap:(){}, color: AppColors.primaryColor, ),),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
