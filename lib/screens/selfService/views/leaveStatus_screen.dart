import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_potal/common/widget/const_text_with_styles.dart';
import 'package:ms_ess_potal/screens/selfService/controller/leaveStatus_controller.dart';
import 'package:ms_ess_potal/style/color.dart';
import 'package:shimmer/shimmer.dart';
import '../../../common/widget/const_button.dart';
import '../../../common/widget/round_button.dart';
import '../../../style/text_style.dart';

class LeaveStatusScreen extends GetView<LeaveStatusController> {
  LeaveStatusScreen({super.key});
  TextEditingController _filterController = TextEditingController();
  final LeaveStatusController controller = Get.put(LeaveStatusController());
  final List<String> _items = [
    'Earned Leave',
    'Sick/Casual Leave',
    'Work From Home',
    'On Duty',
    'Apply for Compensatory Leave'
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
      body: Obx((){
        if(controller.isLoading.value) {
          return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
        }
        else {
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
                      // width: 1,
                      child: TextFormField(
                        controller: _filterController,
                        decoration: const InputDecoration(
                          hintText: "Select Leave",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 30,),
                          // prefixIcon: Icon(Icons.person_2_outlined, size: 30,),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a leave type';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.leaveStatus.length, // Number of items in the list
                  itemBuilder: (context, index) {
                    final leaveRequest = controller.leaveStatus[index];
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
                                    child: Center(child: const10TextBold("${leaveRequest.status}")),
                                    decoration: BoxDecoration(
                                      color: AppColors.warning11,
                                      border: Border.all(color: AppColors.white70),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Text("${leaveRequest.todt} - ${leaveRequest.fromdt}", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                  const SizedBox(height: 3),
                                  Text("${leaveRequest.trackid}", style: AppTextStyles.kSmall12RegularTextStyle),
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
                                    child: const Center(
                                      child: Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.white, size: 35),
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(7),
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
          // height: 300,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Center(child: Text("Leave Without Payment", style: AppTextStyles.kCaption14SemiBoldTextStyle,)),
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
                                Text('${leaveRequest.todt}', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color:AppColors.white50),)
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
                                Text('${leaveRequest.fromdt}', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color:AppColors.white50),)
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
                        const10TextBold("Reporting to ${leaveRequest.reportto}")
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text("Reason",style: AppTextStyles.kPrimaryTextStyle, ),
                  const SizedBox(height: 5,),
                  Container(
                    height: 200,
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
