import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/common/widget/const_button.dart';
import 'package:ms_ess_portal/common/widget/round_button.dart';
import 'package:ms_ess_portal/const/literals.dart';
import 'package:ms_ess_portal/screens/dashboard/contoller/applyLeave_Controller.dart';
import 'package:ms_ess_portal/screens/dashboard/contoller/apply_leave_balance_controller.dart';
import 'package:ms_ess_portal/screens/dashboard/contoller/leave_balance_calculation_controller.dart';
import 'package:ms_ess_portal/screens/dashboard/model/apply_leave_balance_model.dart';
import 'package:ms_ess_portal/style/color.dart';
import '../../../style/text_style.dart';
import 'package:intl/intl.dart';
import '../contoller/emp_search_mail_controller.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});
  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}
class _LeaveScreenState extends State<LeaveScreen> {
  final LeaveApplyBalanceControllerEL controller = Get.put(LeaveApplyBalanceControllerEL());
  final TextEditingController _copyMailController = TextEditingController();
  final EmployeeCopyMailController employeeMailController = Get.put(EmployeeCopyMailController());
  final LeaveApplyBalanceControllerController leaveApplyCalculateController = Get.put(LeaveApplyBalanceControllerController());
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final LeaveApplyController leaveApplyController = Get.put(LeaveApplyController());
  final _formKey = GlobalKey<FormState>();
  String? _selectedLeaveType;
  String? _selectedSessionStartValue;
  String? _selectedSessionEndValue;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showExitConfirmationDialog(context) ?? false;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Leave Type", style: AppTextStyles.kPrimaryTextStyle),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: _showBottomSheet,
                      child: AbsorbPointer(
                        child: SizedBox(
                          height: 65,
                          child: TextFormField(
                            controller: _textController,
                            decoration: const InputDecoration(
                              hintText: "Select Option",
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.arrow_drop_down),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a leave type';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, isStartDate: true),
                            child: AbsorbPointer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Start Date", style: AppTextStyles.kPrimaryTextStyle),
                                  const SizedBox(height: 2),
                                  SizedBox(
                                    height: 70,
                                    child: TextFormField(
                                      controller: _startDateController,
                                      decoration: const InputDecoration(
                                        suffixIcon: Icon(Icons.calendar_month),
                                        hintText: 'Select Date',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Select Start Date';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Session", style: AppTextStyles.kPrimaryTextStyle),
                              const SizedBox(height: 2),
                              SizedBox(
                                height: 70,
                                  child: Obx(() {
                                    return DropdownButtonFormField<String>(
                                      value: _selectedSessionStartValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedSessionStartValue = newValue;
                                        });
                                      },
                                      items: controller.leaveOptions.map<DropdownMenuItem<String>>((Options option) {
                                        return DropdownMenuItem<String>(
                                          value: option.value.toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 2.0, right: 1),
                                            child: Text(option.label ?? ''),
                                          ),
                                        );
                                      }).toList(),
                                      hint: Text(" Select Session"),
                                      decoration: InputDecoration(
                                        hintText: "Select Session",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(3.0),
                                          borderSide: BorderSide(color: Colors.blue, width: 1.5),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Select Session';
                                        }
                                        return null;
                                      },
                                      icon: SizedBox.shrink(),
                                    );
                                  }),
                                ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, isStartDate: false),
                            child: AbsorbPointer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("End Date", style: AppTextStyles.kPrimaryTextStyle),
                                  const SizedBox(height: 2),
                                  SizedBox(
                                    height: 70,
                                    child: TextFormField(
                                      controller: _endDateController,
                                      decoration: const InputDecoration(
                                        hintText: " Select Date",
                                        suffixIcon: Icon(Icons.calendar_month_outlined),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Select end date';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        // End Session Dropdown
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Session", style: AppTextStyles.kPrimaryTextStyle),
                              const SizedBox(height: 2),
                              SizedBox(
                                height: 70,
                                  child: Obx(() {
                                    return DropdownButtonFormField<String>(
                                      value: _selectedSessionEndValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedSessionEndValue = newValue;
                                        });
                                      },
                                      items: controller.leaveOptions.map<DropdownMenuItem<String>>((Options option) {
                                        return DropdownMenuItem<String>(
                                          value: option.value.toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 1.0, right: 1),
                                            child: Text(option.label ?? ''),
                                          ),
                                        );
                                      }).toList(),
                                      hint: Text(" Select Session"),
                                      decoration: InputDecoration(
                                        hintText: "Select Session",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(3.0),
                                          borderSide: BorderSide(color: Colors.blue, width: 1.5),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Select Session';
                                        }
                                        return null;
                                      },
                                      icon: SizedBox.shrink(),
                                    );
                                  }),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text("Reason", style: AppTextStyles.kPrimaryTextStyle),
                    const SizedBox(height: 1),
                    TextFormField(
                      controller: _reasonController,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                      validator: (value){
                        if (value!.isEmpty || value.length < 15) {
                          return 'Reason should be at least 15 characters';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.newline,
                    ),
                    const SizedBox(height: 2),
                    Text("Copy Mail", style: AppTextStyles.kPrimaryTextStyle),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 48,
                      child: TextFormField(
                        controller: _copyMailController,
                        decoration: const InputDecoration(
                          hintText: 'Employee ID / Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          employeeMailController.fetchEmployeeSuggestions(value);
                        },
                      ),
                    ),
                    const SizedBox(height: 7),
                    Obx(
                          () {
                        if (employeeMailController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: employeeMailController.employeeList.length,
                          itemBuilder: (context, index) {
                            final employee = employeeMailController.employeeList[index];
                            return ListTile(
                              title: Text(employee),
                              onTap: () {
                                _copyMailController.text = employee;
                                employeeMailController.employeeList.clear();
                              },
                            );
                          },
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: AppColors.error60, size: 27),
                          Obx(() => Text(
                            'Available balance : ${controller.leaveBalance.value.data?.leaveBalance?.balance ?? '0'} / Current Booked : ${leaveApplyCalculateController.leaveBalanceCalculate.value.data?.currentBooking??"0"}',
                            style: AppTextStyles.kSmall10SemiBoldTextStyle,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        child: RoundButton(
                          title: '    Request    ',
                          onTap: _applyLeave,
                        )),
                    SizedBox(
                        height: 40,
                        child: ConstButton(
                          title: '    Cancel    ',
                          onTap: () {
                            _resetAllFields();
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> showExitConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  void _applyLeave() async {
    bool? confirm = await _showRequestConfirmationDialog(context);
    if (confirm == true) {
      setState(() {
        _isLoading = true;
      });
      if (_formKey.currentState!.validate()) {
        if (_selectedLeaveType == null || _selectedSessionStartValue == null || _selectedSessionEndValue == null) {
          return;
        }
        final body = {
          "type": _selectedLeaveType,
          "startDate": _startDateController.text,
          "startSession": _selectedSessionStartValue,
          "endDate": _endDateController.text,
          "endSession": _selectedSessionEndValue,
          "reason": _reasonController.text,
          "email_cc": [],
          "comp_date": null,
        };
        await leaveApplyController.applyLeave(body);
        _resetAllFields();
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<bool?> _showRequestConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title: const Text('Request'),
          content: Text('Are you sure you want to submit the leave request?', style: AppTextStyles.kSmall12SemiBoldTextStyle,),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: SizedBox(
                  width: 70,
                  child: RoundButton(title: "Yes", onTap: (){
                    Navigator.of(context).pop(true);
                  },)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: SizedBox(
                  width: 70,
                  child: RoundButton(title: "No", onTap: (){
                    Get.back();
                  }, color: AppColors.error40,)
              ),
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Center(child: Text(items[index]['name'] ?? "")),
                onTap: () {
                  _textController.text = items[index]['name'] ?? "";
                  _selectedLeaveType = items[index]['title'];
                  controller.fetchLeaveBalance(_selectedLeaveType ?? "");
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context, {required bool isStartDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      String formattedDate = DateFormat("dd-MM-yyyy").format(picked);
      if (isStartDate) {
        _startDateController.text = formattedDate;
      } else {
        _endDateController.text = formattedDate;
      }
    }
  }

  void _resetAllFields() {
    _textController.clear();
    _startDateController.clear();
    _endDateController.clear();
    _reasonController.clear();
    _copyMailController.clear();
    setState(() {
      _selectedSessionStartValue = null;
      _selectedSessionEndValue = null;
    });
  }
}

