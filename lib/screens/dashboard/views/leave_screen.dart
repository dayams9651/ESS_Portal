import 'package:flutter/material.dart';
import 'package:ms_ess_potal/common/widget/const_button.dart';
import 'package:ms_ess_potal/common/widget/round_button.dart';
import 'package:ms_ess_potal/style/color.dart';
import '../../../style/text_style.dart';
class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  TextEditingController _textController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  final List<String> _items = [
    'Earned Leave', 'Sick/Casual Leave', 'Work From Home', 'On Duty', 'Apply for Compensatory Leave'
  ];

  final List<String> _session = [
    '09:00 AM - 01:30 PM',
    '01:30 PM - 06:00 PM',
  ];
  String? selectSession;
  String? _selectedSessionFrom;
  String? _selectedToFrom;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Leave Type",
                style: AppTextStyles.kPrimaryTextStyle,
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  _showBottomSheet();
                },
                child: AbsorbPointer(
                  child: SizedBox(
                    height: 48,
                    child: TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Select Option",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.arrow_drop_down),
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
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context, isStartDate: true);
                      },
                      child: AbsorbPointer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Start Date", style: AppTextStyles.kPrimaryTextStyle,),
                            SizedBox(height: 2,),
                            SizedBox(
                              height: 48,
                              child: TextFormField(
                                controller: _startDateController,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.calendar_month),
                                  hintText: 'Select Date',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Space between date pickers
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Session", style: AppTextStyles.kPrimaryTextStyle,),
                          SizedBox(height: 2,),
                          SizedBox(
                            height: 48,
                            width: 200,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.white40, ),  // Border color and width
                                borderRadius: BorderRadius.circular(8),  // Optional: Rounded corners
                              ),
                              child: DropdownButtonFormField<String>(
                                value: _selectedSessionFrom,  // The currently selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedSessionFrom= newValue;  // Update selected value
                                  });
                                },
                                items: _session.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 7.0, right: 3),
                                      child: Text(value),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),

                        ]),
                  )],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context, isStartDate: false);
                      },
                      child: AbsorbPointer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("End Date", style: AppTextStyles.kPrimaryTextStyle,),
                            SizedBox(height: 2,),
                            SizedBox(
                              height: 48,
                              child: TextFormField(
                                controller: _endDateController,
                                decoration: InputDecoration(
                                  hintText: "Select Date",
                                  suffixIcon: Icon(Icons.calendar_month_outlined),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Space between date pickers
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Session", style: AppTextStyles.kPrimaryTextStyle,),
                          SizedBox(height: 2,),
                          SizedBox(
                            height: 48,
                            width: 200,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.white40, ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: _selectedToFrom,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedToFrom= newValue;
                                  });
                                },
                                items: _session.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 7.0, right: 3),
                                      child: Text(value),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ]),
                  )
                ],
              ),
              SizedBox(height: 10),
              Text("Reason",style: AppTextStyles.kPrimaryTextStyle, ),
              SizedBox(height: 5,),
              TextFormField(
                controller: _reasonController,
                maxLines: 5, // Allows unlimited lines
                keyboardType: TextInputType.multiline, // Enables multiline input
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(16),
                ),
                textInputAction: TextInputAction.newline,
              ),
              SizedBox(height: 7,),
              Text("Copy Mail",style: AppTextStyles.kPrimaryTextStyle, ),
              SizedBox(height: 5,),
              SizedBox(
                height: 48,
                child: TextFormField(
                  // controller: fatherNameController,
                  decoration: const InputDecoration(
                    hintText: 'Employee ID / Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Employee ID / Name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 7,),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.error60, size: 27,),
                    Text(' Available balance : 1.5 / Current Booked : 1', style: AppTextStyles.kSmall10SemiBoldTextStyle,)
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 180,
                        child: RoundButton(title: 'Apply', onTap:(){} )),
                    SizedBox(
                        width: 180,
                        height: 40,
                        child: ConstButton(title: 'Cancel', onTap: (){}))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Show the bottom sheet with the list of options
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
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

  // Date picker function to select the date
  Future<void> _selectDate(BuildContext context, {required bool isStartDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      String formattedDate = "${picked.day}/${picked.month}/${picked.year}";

      // Update the respective date controller
      if (isStartDate) {
        _startDateController.text = formattedDate;
      } else {
        _endDateController.text = formattedDate;
      }
    }
  }
}