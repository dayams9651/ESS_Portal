import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/screens/selfService/controller/leaveWFH_controller.dart';
import '../../../common/widget/const_button.dart';
import '../../../common/widget/custom_datePicker.dart';
import '../../../common/widget/round_button.dart';
import '../../../style/color.dart';
import '../../../style/text_style.dart';

class LeaveWFHScreen extends GetView<LeaveWFHController> {
  LeaveWFHScreen({super.key});

  TextEditingController _textController = TextEditingController();
  final List<String> _items = [
    'Earned Leave',
    'Sick/Casual Leave',
    'Work From Home',
    'On Duty',
    'Apply for Compensatory Leave'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        title: Center(
            child: Text("WFH Update", style: AppTextStyles.kPrimaryTextStyle,)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24,), // Change this to any icon you prefer
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Request ID",
                style: AppTextStyles.kPrimaryTextStyle,
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  _showBottomSheet(context); // Pass context here
                },
                child: AbsorbPointer(
                  child: SizedBox(
                    height: 48,
                    child: TextFormField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        // hintText: "Select Option",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 35,),
                        prefixIcon: Icon(Icons.person_2_outlined, size: 30,),
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
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("From Hours", style: AppTextStyles.kPrimaryTextStyle,),
                        const SizedBox(height: 5,),
                        SizedBox(
                          height: 48,
                          child: CustomTimePicker(onTimeSelected: (DateTime ) {  },)
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("To Hours", style: AppTextStyles.kPrimaryTextStyle,),
                        const SizedBox(height: 5,),
                        SizedBox(
                          height: 48,
                          child: CustomTimePicker(onTimeSelected: (DateTime ) {  },),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Text("Enter Work Details",style: AppTextStyles.kPrimaryTextStyle, ),
              const SizedBox(height: 5,),
              TextFormField(
                maxLines: 5, // Allows unlimited lines
                keyboardType: TextInputType.multiline, // Enables multiline input
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(16),
                ),
                textInputAction: TextInputAction.newline,
              ),
              const SizedBox(height: 20,),
              Padding(
                padding:  const EdgeInsets.all(2.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                      color: AppColors.warning11,
                    border: Border.all(color: AppColors.white70)
                  ),
                  child: ListTile(
                    title: Text("Request on : 2024-12-14 / Time : 10:29:54", style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                    subtitle: Text("From : 2024-12-14 to 2024-12-15 for 1 days", style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                    leading:   const Icon(Icons.info_outline, color: AppColors.error60, size: 27,),
                  ),
                )
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 180,
                        child: RoundButton(title: 'Submit', onTap:(){} )),
                    SizedBox(
                        width: 180,
                        height: 40,
                        child: ConstButton(title: 'Postpond', onTap: (){}))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) { // Add BuildContext parameter
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300, // Set the height of the BottomSheet
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Center(child: Text(_items[index])),
                onTap: () {
                  // When an item is tapped, set it in the text field
                  _textController.text = _items[index];
                  // Close the bottom sheet
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
