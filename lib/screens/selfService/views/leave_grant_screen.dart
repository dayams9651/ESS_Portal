import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/common/widget/const_text_with_styles.dart';
import 'package:ms_ess_potal/screens/selfService/controller/leave_grant_controller.dart';
import '../../../common/widget/round_button.dart';
import '../../../style/color.dart';
import '../../../style/text_style.dart';
class LeaveGrantScreen extends GetView<LeaveGrantController> {
  LeaveGrantScreen({super.key});
  final List<String> items = List.generate(20, (index) => 'Item $index');

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length, // Number of items in the list
              itemBuilder: (context, index) {
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
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 7),
                                  Text("Daya Kumar ( T0020 )", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                  const SizedBox(height: 3),
                                  Text("IT as Flutter Developer", style: AppTextStyles.kSmall10RegularTextStyle),
                                ],
                              ),
                              const SizedBox(height: 7),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const SizedBox(height: 7),
                                  Text("On Duty for 9h & 0 min", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                                  const SizedBox(height: 3),
                                  Text("Request date : 16-12-2024", style: AppTextStyles.kSmall10RegularTextStyle),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              _showPopUp(context); // Trigger the pop-up on icon tap
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
      ),
    );
  }

  // Method to show the pop-up
  void _showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                Text("Mukul Taneja ( T0019 )", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                const SizedBox(height: 3), // Reduced space to minimize height
                const10Text("Information Technology as UI-UX Design"),
                const SizedBox(height: 7,),
                Text("On Duty For 9h & 0 min", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                const10Text("Request date : 16-12-2024"),
                const SizedBox(height: 7,),
                const10Text("Due to punch machine not setup in B-88 branch"),
                const SizedBox(height: 10), // Reduced space to minimize height
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const12TextBold('Date'),
                        Text('16-12-2024', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const12TextBold('Session'),
                        Text('9:00 AM - 11:30 AM', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const12TextBold('Days'),
                        Text('16', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
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
