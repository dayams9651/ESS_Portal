import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
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

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});
  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}
class _LeaveScreenState extends State<LeaveScreen> {
  final LeaveApplyBalanceControllerEL controller = Get.put(LeaveApplyBalanceControllerEL());
  final LeaveApplyBalanceControllerController leaveApplyCalculateController = Get.put(LeaveApplyBalanceControllerController());
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _copyMailController = TextEditingController();
  final LeaveApplyController leaveApplyController = Get.put(LeaveApplyController());
  final _formKey = GlobalKey<FormState>();
  String? _selectedSessionStart;
  String? _selectedSessionEnd;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final box = GetStorage();
        box.erase();
        String? token = box.read('token');
        if (token == null) {
          debugPrint('Token has been deleted');
        } else {
          debugPrint('Token still exists: $token');
        }
        return await showExitConfirmationDialog(context) ?? false;
      },
      // backgroundColor: Colors.white,
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
                          height: 50,
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
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Start Date and Session
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
                                    height: 48,
                                    child: TextFormField(
                                      controller: _startDateController,
                                      decoration: const InputDecoration(
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
                        const SizedBox(width: 7),
                        // Start Session Dropdown
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Session", style: AppTextStyles.kPrimaryTextStyle),
                              const SizedBox(height: 2),
                              SizedBox(
                                height: 48,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.white40),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Obx(() {
                                    return DropdownButtonFormField<String>(
                                      value: _selectedSessionStart,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedSessionStart = newValue;
                                        });
                                      },
                                      items: controller.leaveOptions.map<DropdownMenuItem<String>>((Options option) {
                                        return DropdownMenuItem<String>(
                                          value: option.label,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 2.0, right: 1),
                                            child: Text(option.label ?? ''),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
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
                                    height: 48,
                                    child: TextFormField(
                                      controller: _endDateController,
                                      decoration: const InputDecoration(
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
                        const SizedBox(width: 7),
                        // End Session Dropdown
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Session", style: AppTextStyles.kPrimaryTextStyle),
                                const SizedBox(height: 2),
                                SizedBox(
                                  height: 48,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.white40),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Obx(() {
                                      return DropdownButtonFormField<String>(
                                        value: _selectedSessionEnd,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedSessionEnd = newValue;
                                          });
                                        },
                                        items: controller.leaveOptions.map<DropdownMenuItem<String>>((Options option) {
                                          return DropdownMenuItem<String>(
                                            value: option.label,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 1.0, right: 1),
                                              child: Text(option.label ?? ''),
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }),
                                  ),
                                ),
                              ]),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text("Reason", style: AppTextStyles.kPrimaryTextStyle),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _reasonController,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                      validator: (value){
                          if (value!.isEmpty) {
                            return 'Reason should not be in less than 15 character';
                          }
                          return null;
                      },
                      textInputAction: TextInputAction.newline,
                    ),
                    const SizedBox(height: 7),
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
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Please Enter Employee ID / Name';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                    const SizedBox(height: 7),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Apply button
                    SizedBox(
                        width: 180,
                        child: RoundButton(
                          title: 'Request',
                          onTap: _applyLeave,
                        )),
                    // Cancel button
                    SizedBox(
                        width: 180,
                        height: 40,
                        child: ConstButton(
                          title: 'Cancel',
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
    if (_formKey.currentState!.validate()) {
      final body = {
        "type": _textController.text,
        "startDate": _startDateController.text,
        "startSession": _selectedSessionStart,
        "endDate": _endDateController.text,
        "endSession": _selectedSessionEnd,
        "reason": _reasonController.text,
        "email_cc": [],
        "comp_date": null,
      };
      await leaveApplyController.applyLeave(body, );
    }
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
                  controller.fetchLeaveBalance(items[index]['title'] ?? "");
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
      String formattedDate = DateFormat("dd/MM/yyyy").format(picked);
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
      _selectedSessionStart = null;
      _selectedSessionEnd = null;
    });
  }
}