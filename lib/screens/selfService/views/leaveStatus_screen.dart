import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_portal/common/widget/const_text_with_styles.dart';
import 'package:ms_ess_portal/const/image_strings.dart';
import 'package:ms_ess_portal/screens/selfService/controller/leaveStatus_controller.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:shimmer/shimmer.dart';
import '../../../common/widget/const_button.dart';
import '../../../common/widget/round_button.dart';
import '../../../style/text_style.dart';

class LeaveStatusScreen extends GetView<LeaveStatusController> {
  LeaveStatusScreen({super.key});
  final TextEditingController _filterController = TextEditingController();
  @override
  final LeaveStatusController controller = Get.put(LeaveStatusController());
  final List<String> _items = [
    'EL',
    'SL',
    'On Duty',
    'WFH'
  ];
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
      } else if(controller.leaveStatus.isEmpty) {
        return Center(child: Image.asset(noData1),);
      }
      else {
        final filteredLeaveStatus = _selectedLeaveType == null
            ? controller.leaveStatus
            : controller.leaveStatus.where((leave) {
          return leave.leavetype == _selectedLeaveType;  // Assuming leaveType is a property of leaveRequest
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: GestureDetector(
                onTap: () {
                  _showBottomFilter(context); // Pass context here
                },
                child: AbsorbPointer(
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      controller: _filterController,
                      decoration: const InputDecoration(
                        hintText: "Select Leave",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredLeaveStatus.length, // Use the filtered list here
                itemBuilder: (context, index) {
                  final leaveRequest = filteredLeaveStatus[index];
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
                                    color: AppColors.warning11,
                                    border: Border.all(color: AppColors.white70),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Center(child: const10TextBold(leaveRequest.status)),
                                ),
                                const SizedBox(height: 7),
                                Text("${leaveRequest.todt} - ${leaveRequest.fromdt}", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                const SizedBox(height: 3),
                                Text(leaveRequest.trackid, style: AppTextStyles.kSmall12RegularTextStyle),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, index); // Pass context here
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
    })

    );
  }

  void _showBottomSheet(BuildContext context, index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final leaveRequest = controller.leaveStatus[index];
        return Container(
          // height: 700,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                // Center(child: Text("Leave Without Payment", style: AppTextStyles.kCaption14SemiBoldTextStyle,)),
                const SizedBox(height: 20,),
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
                              const Icon(Icons.calendar_month, size: 28, color: AppColors.white50,),
                              const SizedBox(width: 7,),
                              Text(leaveRequest.todt, style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color:AppColors.white50),)
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
                              const Icon(Icons.calendar_month, size: 28, color: AppColors.white50,),
                              const SizedBox(width: 7,),
                              Text(leaveRequest.fromdt, style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color:AppColors.white50),)
                            ],
                          )

                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: AppColors.error60, size: 27,),
                      const SizedBox(width: 5,),
                      const10TextBold("Reporting to ${leaveRequest.reportto}", )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Text("Reason",style: AppTextStyles.kPrimaryTextStyle, ),
                const SizedBox(height: 5,),
                Container(
                  height: 150,
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white40),
                    borderRadius: BorderRadius.circular(15),

                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Due to Fever I'm unable to come at office.....", style: TextStyle(fontSize: 16, color: AppColors.white60),),
                  ),
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 180,
                          child: RoundButton(title: 'Withdraw', onTap:(){} )),
                      SizedBox(
                          width: 180,
                          height: 42,
                          child: ConstButton(title: 'Cancel', onTap: (){}))
                    ],
                  ),
                )
              ]
            ),
          )
        );
      },
    );
  }

  void _showBottomFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Center(child: Text(_items[index])),
                onTap: () {
                  _filterController.text = _items[index];
                  _selectedLeaveType = _items[index];  // Set selected leave type
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

}
