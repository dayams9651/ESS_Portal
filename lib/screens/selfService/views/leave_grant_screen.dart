import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_portal/common/widget/const_text_with_styles.dart';
import 'package:ms_ess_portal/const/image_strings.dart';
import 'package:ms_ess_portal/screens/selfService/controller/leave_accept_reject_controller.dart';
import 'package:ms_ess_portal/screens/selfService/controller/leave_grant_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../common/widget/round_button.dart';
import '../../../style/color.dart';
import '../../../style/text_style.dart';


class LeaveGrantScreen extends StatefulWidget {
  const LeaveGrantScreen({super.key});

  @override
  LeaveGrantScreenState createState() => LeaveGrantScreenState();
}

class LeaveGrantScreenState extends State<LeaveGrantScreen> {
  final LeaveGrantController controller1 = Get.put(LeaveGrantController());
  final ApproveRequestController rejectRequestController = Get.put(ApproveRequestController());
  final bool _isLoading = false;
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
      body: Obx(() {
        if(controller1.isLoading.value) {
          return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
        } else if(controller1.leaveRequestsData.isEmpty) {
          return Center(child: Image.asset(noContent),);
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller1.leaveRequestsData.length,
                  itemBuilder: (context, index) {
                    final leaveRequest = controller1.leaveRequestsData[index];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
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
                                  showBottomSheet(context, index);
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
      }),
    );
  }

  void showBottomSheet(BuildContext context, int index) {
    final leaveRequest = controller1.leaveRequestsData[index];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  leaveRequest.leavetype,
                  style: AppTextStyles.kCaption14SemiBoldTextStyle,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const12TextBold('Date'),
                      Row(
                        children: [
                          Icon(Icons.calendar_month, color: AppColors.white60,),
                          Text(leaveRequest.regdate, style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50)),
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const12TextBold('Days'),
                      Row(
                        children: [
                          Icon(Icons.watch_later_outlined , color: AppColors.white60, ),
                          Text(leaveRequest.totalday, style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("${leaveRequest.empname} ( ${leaveRequest.empcode} )", style: AppTextStyles.kSmall12SemiBoldTextStyle),
              const SizedBox(height: 7),
              Text("Reason", style: AppTextStyles.kCaption13SemiBoldTextStyle,),
              SizedBox(height: 5,),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.white40),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    leaveRequest.remark ,
                    style: TextStyle(fontSize: 16, color: AppColors.white60),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 100,
                    child: RoundButton(
                      color: AppColors.primaryColor,
                      title: 'Accept',
                      onTap: ()  {
                        rejectRequestController.acceptRequest(leaveRequest.trackid.toString());
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  // Reject Button
                  SizedBox(
                    width: 100,
                    child: RoundButton(
                      color: AppColors.error40,
                      title: 'Reject',
                      onTap: ()  {
                         rejectRequestController.rejectRequest(leaveRequest.trackid.toString());
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              _isLoading ? Center(child: CircularProgressIndicator()) : Container(),
            ],
          ),
        );
      },
    );
  }
}
