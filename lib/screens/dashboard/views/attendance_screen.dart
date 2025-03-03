import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ms_ess_portal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_portal/const/image_strings.dart';
import 'package:ms_ess_portal/screens/dashboard/contoller/attendance_controller.dart';
import 'package:ms_ess_portal/screens/dashboard/contoller/shift_controller.dart';
import 'package:ms_ess_portal/screens/dashboard/widget/custom_container.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:ms_ess_portal/style/text_style.dart';
import 'package:shimmer/shimmer.dart';
import '../model/attendance_model.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});
  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

enum AttendanceStatus { P, HLD, A, SRT, WO, HD, MIS }

class _AttendanceScreenState extends State<AttendanceScreen> {
  int selectedYear = 2025;
  int selectedMonth = 3;

  List<AttendanceStatus> attendance = [];
  final List<int> years = [2023, 2024, 2025];
  final List<String> months = [
    "January", "February", "March", "April", "May", "June", "July",
    "August", "September", "October", "November", "December"
  ];
  final List<String> daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  DateTime currentDate = DateTime.now();
  final ShiftController controller = Get.put(ShiftController());
  final ShiftController controllerShift = Get.put(ShiftController());
  final AttendanceController attendController = Get.put(AttendanceController());

  List<Attendance> fetchedAttendanceData = [];

  @override
  void initState() {
    super.initState();
    // Initial fetching of data for the current month
    _fetchAttendanceDataForMonth();
  }

  void _fetchAttendanceDataForMonth() {
    attendController.fetchAttendanceData(
      '$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-01',
      '$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-${getDaysInMonth(selectedYear, selectedMonth)}',
    );
  }

  int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  int getFirstDayOfMonth(int year, int month) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    return firstDayOfMonth.weekday;
  }

  int getDaysInPreviousMonth(int year, int month) {
    if (month == 1) {
      return DateTime(year - 1, 12 + 1, 0).day;
    } else {
      return DateTime(year, month, 0).day;
    }
  }

  void initializeAttendance(int year, int month) {
    int daysInMonth = getDaysInMonth(year, month);
    setState(() {
      attendance = List.generate(daysInMonth, (index) => AttendanceStatus.A);
    });
  }

  void toggleAttendance(int day) {
    setState(() {
      switch (attendance[day]) {
        case AttendanceStatus.A:
          attendance[day] = AttendanceStatus.P;
          break;
        case AttendanceStatus.P:
          attendance[day] = AttendanceStatus.MIS;
          break;
        case AttendanceStatus.MIS:
          attendance[day] = AttendanceStatus.SRT;
          break;
        case AttendanceStatus.SRT:
          attendance[day] = AttendanceStatus.A;
          break;
        case AttendanceStatus.HLD:
          attendance[day] = AttendanceStatus.HLD;
          break;
        case AttendanceStatus.WO:
          attendance[day] = AttendanceStatus.WO;
          break;
        case AttendanceStatus.HD:
          attendance[day] = AttendanceStatus.HD;
          break;
      }
    });
  }

  void goToPreviousMonth() {
    setState(() {
      if (selectedMonth == 1) {
        selectedMonth = 12;
        selectedYear--;
      } else {
        selectedMonth--;
      }
      _fetchAttendanceDataForMonth();
    });
  }

  void goToNextMonth() {
    setState(() {
      if (selectedMonth == 12) {
        selectedMonth = 1;
        selectedYear++;
      } else {
        selectedMonth++;
      }
      _fetchAttendanceDataForMonth();
    });
  }

  bool isToday(int day) {
    return selectedYear == currentDate.year &&
        selectedMonth == currentDate.month &&
        day == currentDate.day;
  }

  int getSRTCount(List<Attendance> attendanceList) {
    return attendanceList.where((attendance) => attendance.title == "SRT").length;
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchShiftData();
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
      child: Obx(() {
        if (attendController.isLoading.value) {
          return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
        } else {
          var shift = controller.shiftModel.value!;
          fetchedAttendanceData = attendController.attendanceList;
          List<Attendance> filteredAttendanceData = fetchedAttendanceData.where((attendance) {
            DateTime attendanceDate = DateTime.parse(attendance.start);
            return attendanceDate.year == selectedYear && attendanceDate.month == selectedMonth;
          }).toList();
          int daysInMonth = getDaysInMonth(selectedYear, selectedMonth);
          int firstDayOfMonth = getFirstDayOfMonth(selectedYear, selectedMonth);
          int previousMonthDays = getDaysInPreviousMonth(selectedYear, selectedMonth);
          int totalCells = (firstDayOfMonth + daysInMonth + 6) ~/ 7 * 7;

          return SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: AppColors.white30,
                      height: 40,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.keyboard_arrow_left_sharp),
                            onPressed: goToPreviousMonth,
                          ),
                          Text(
                            months[selectedMonth - 1],
                            style: AppTextStyles.kSmall12SemiBoldTextStyle,
                          ),
                          IconButton(
                            icon: const Icon(Icons.keyboard_arrow_right_sharp),
                            onPressed: goToNextMonth,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 39,
                      color: AppColors.primaryColor,
                      child: Center(
                        child: DropdownButton<int>(
                          value: selectedYear,
                          onChanged: (newYear) {
                            setState(() {
                              selectedYear = newYear!;
                              _fetchAttendanceDataForMonth();
                            });
                          },
                          items: years.map((year) {
                            return DropdownMenuItem<int>(value: year, child: Text(year.toString(), style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.white90)));
                          }).toList(),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.error20,
                      child: IconButton(onPressed: () {
                        showPunchInDetails(context);
                      }, icon: const Icon(Icons.info_outline)),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text("${attendController.totalPresent}", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                        Text("Present", style: AppTextStyles.kSmall12RegularTextStyle),
                      ],
                    ),
                    Column(
                      children: [
                        Text("${attendController.totalMissPunch}", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.misPunch1Color)),
                        Text("MisPunch", style: AppTextStyles.kSmall12RegularTextStyle),
                      ],
                    ),
                    Column(
                      children: [
                        Text("${getSRTCount(fetchedAttendanceData)}", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.short1Color)),
                        Text("Short", style: AppTextStyles.kSmall12RegularTextStyle),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: daysOfWeek.map((day) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 350,
                  child: GridView.builder(
                    shrinkWrap: false,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                    itemCount: totalCells,
                    itemBuilder: (context, index) {
                      if (index < firstDayOfMonth) {
                        int prevMonthDay = previousMonthDays - (firstDayOfMonth - index - 1);
                        return Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(5)),
                          child: Center(child: Text(prevMonthDay.toString(), style: const TextStyle(color: Colors.grey))),
                        );
                      } else if (index < firstDayOfMonth + daysInMonth) {
                        int day = index - firstDayOfMonth + 1;
                        bool today = isToday(day);
                        Attendance? attendanceForDay = filteredAttendanceData.firstWhere(
                              (attendance) => DateTime.parse(attendance.start).day == day,
                          orElse: () => Attendance(title: "A", start: "", totalTime: ""),
                        );
                        Color dayColor = _getAttendanceColor(attendanceForDay);
                        return GestureDetector(
                          onTap: () => toggleAttendance(day - 1),
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: today ? AppColors.primaryColor : dayColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                day.toString(),
                                style: TextStyle(color: today ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      } else {
                        int nextMonthDay = index - firstDayOfMonth - daysInMonth + 1;
                        return Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(nextMonthDay.toString(), style: const TextStyle(color: Colors.grey)),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Card(
                  color: AppColors.white,
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                          color: AppColors.white50)
                  ),
                  child: ListTile(
                    leading: Image.asset(hand_touch, height: 45,),
                    title: Text("Today's In", style: AppTextStyles.kSmall12SemiBoldTextStyle,),
                    subtitle: Text(shift.todayIn.isNotEmpty?shift.todayIn:"null", style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          shift.totalHour, style: AppTextStyles.kSmall12SemiBoldTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomContainer(icon: Icons.watch_later_outlined, text: 'Shift In', subTitle: shift.startTime),
                          const SizedBox(width: 10),
                          CustomContainer(icon: Icons.watch_later_outlined, text: 'Shift Out', subTitle: shift.endTime)
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomContainer(icon: Icons.watch_later_outlined, text: 'Worked Hours', subTitle: shift.totalHour.isEmpty ? "0"  : shift.totalHour.toString()),
                          const SizedBox(width: 10),
                          CustomContainer(icon: Icons.calendar_month, text: 'Shift Code ', subTitle: shift.division)
                        ],
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
                const SizedBox(height: 70,),
              ],
            ),
          );
        }
      }),
    );
  }

  Future<bool?> showExitConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(onPressed: () { SystemNavigator.pop(); }, child: const Text('Yes')),
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('No')),
        ],
      ),
    );
  }

  Color _getAttendanceColor(Attendance attendance) {
    switch (attendance.title) {
      case "P":
        return AppColors.success60;
      case "WO":
        return AppColors.info20;
      case "HLD":
        return AppColors.warning40;
      case "A":
        return AppColors.error80;
      case "SRT":
        return AppColors.error20;
      case "MIS":
        return AppColors.warning20;
      case "HD":
        return AppColors.info60;
      default:
        return AppColors.error20;
    }
  }
}

Future<bool?> showPunchInDetails(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        backgroundColor: Colors.white,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Colors Index", style: AppTextStyles.kCaption13SemiBoldTextStyle.copyWith(color: AppColors.primaryColor),),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the pop-up
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Short", style: AppTextStyles.kSmall12SemiBoldTextStyle,),
                          Text("MisPunch", style: AppTextStyles.kSmall12SemiBoldTextStyle,),
                          Text("WOH", style: AppTextStyles.kSmall12SemiBoldTextStyle,),
                          Text("Holiday", style: AppTextStyles.kSmall12SemiBoldTextStyle,),
                          Text("Present",style: AppTextStyles.kSmall12SemiBoldTextStyle,),
                          Text("WO", style: AppTextStyles.kSmall12SemiBoldTextStyle,),
                          Text("Absence", style: AppTextStyles.kSmall12SemiBoldTextStyle,),
                        ],
                      ),
                      Column(
                        spacing: 4,
                        children: [
                          const CircleAvatar(radius: 12, backgroundColor: AppColors.error20,),
                          const CircleAvatar(radius: 12,backgroundColor: AppColors.error40,),
                          const CircleAvatar(radius: 12, backgroundColor: AppColors.absentColor),
                          const CircleAvatar(radius: 12, backgroundColor: AppColors.warning60,),
                          const CircleAvatar(radius: 12, backgroundColor: AppColors.success60,),
                          const CircleAvatar(radius: 12, backgroundColor: AppColors.absentColor,),
                          const CircleAvatar(radius: 12, backgroundColor: AppColors.error80,)
                        ],
                      ),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      )
  );
}
