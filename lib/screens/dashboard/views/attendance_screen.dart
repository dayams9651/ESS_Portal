import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/screens/dashboard/widget/custom_container.dart';
import 'package:ms_ess_potal/style/color.dart';
import 'package:ms_ess_potal/style/text_style.dart';
import 'package:shimmer/shimmer.dart';
import '../../../common/widget/const_shimmer_effects.dart';
import '../contoller/attendance_controller.dart';
import '../contoller/shift_controller.dart';
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

enum AttendanceStatus { P,HLD, A, SRT, WO, HD, MIS }

class _AttendanceScreenState extends State<AttendanceScreen> {
  int selectedYear = 2025;
  int selectedMonth = 1; // January
  List<AttendanceStatus> attendance = [];
  final List<int> years = [2023, 2024, 2025, 2026, 2027];
  final List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  final List<String> daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  DateTime currentDate = DateTime.now(); // Current date for highlighting

  @override
  void initState() {
    super.initState();
    initializeAttendance(selectedYear, selectedMonth);
  }
  int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day; // Last day of the month
  }

  // Get the first day of the month (used to align the grid)
  int getFirstDayOfMonth(int year, int month) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    return firstDayOfMonth.weekday;
  }

  int getDaysInPreviousMonth(int year, int month) {
    if (month == 1) {
      return DateTime(year - 1, 12 + 1, 0).day; // December of the previous year
    } else {
      return DateTime(year, month, 0).day;
    }
  }

  // Initialize the attendance data based on the year and month
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

  // Navigate to the previous month
  void goToPreviousMonth() {
    setState(() {
      if (selectedMonth == 1) {
        selectedMonth = 12;
        selectedYear--;
      } else {
        selectedMonth--;
      }
      initializeAttendance(selectedYear, selectedMonth);
    });
  }

  // Navigate to the next month
  void goToNextMonth() {
    setState(() {
      if (selectedMonth == 12) {
        selectedMonth = 1;
        selectedYear++;
      } else {
        selectedMonth++;
      }
      initializeAttendance(selectedYear, selectedMonth);
    });
  }

   bool isToday(int day) {
    return selectedYear == currentDate.year &&
        selectedMonth == currentDate.month &&
        day == currentDate.day;
  }
  final ShiftController controller = Get.put(ShiftController());
  final AttendanceController attendController = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    controller.fetchShiftData();
    int daysInMonth = getDaysInMonth(selectedYear, selectedMonth);
    int firstDayOfMonth = getFirstDayOfMonth(selectedYear, selectedMonth);
    int previousMonthDays = getDaysInPreviousMonth(selectedYear, selectedMonth);
    int totalCells = (firstDayOfMonth + daysInMonth + 6) ~/ 7 * 7;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx((){
        if (controller.shiftModel.value == null) {
          return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
        } else {
          var shift = controller.shiftModel.value!;
          return SingleChildScrollView(
            padding: EdgeInsets.zero, // Ensure there's no extra padding here
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: AppColors.white30,
                      width: 200,
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
                      width: 150,
                      height: 39,
                      color: AppColors.primaryColor,
                      child: Center(
                        child: DropdownButton<int>(
                          value: selectedYear,
                          onChanged: (newYear) {
                            setState(() {
                              selectedYear = newYear!;
                              initializeAttendance(selectedYear, selectedMonth);
                            });
                          },
                          items: years.map((year) {
                            return DropdownMenuItem<int>(
                              value: year,
                              child: Text(
                                year.toString(),
                                style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.white90),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Adjust the space between sections
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "11",
                          style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor),
                        ),
                        Text("Present", style: AppTextStyles.kSmall12RegularTextStyle),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "01",
                          style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.misPunch1Color),
                        ),
                        Text("MisPunch", style: AppTextStyles.kSmall12RegularTextStyle),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "03",
                          style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.short1Color),
                        ),
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
                const SizedBox(height: 10), // Adjust spacing for the grid
                SizedBox(
                  height: 300,
                  child: GridView.builder(
                    shrinkWrap: false,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                    ),
                    itemCount: totalCells,
                    itemBuilder: (context, index) {
                      if (index < firstDayOfMonth) {
                        int prevMonthDay = previousMonthDays - (firstDayOfMonth - index - 1);
                        return Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              prevMonthDay.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      } else if (index < firstDayOfMonth + daysInMonth) {
                        int day = index - firstDayOfMonth + 1;
                        bool today = isToday(day);
                        Color dayColor = _getAttendanceColor(attendance[day - 1]);
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
                                style: TextStyle(
                                  color: today ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        int nextMonthDay = index - firstDayOfMonth - daysInMonth + 1;
                        return Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300, // Grey for next month days
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              nextMonthDay.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomContainer(icon: Icons.watch_later_outlined, text: 'Shift In', subTitle: '${shift.startTime??'Null'}'),
                          const SizedBox(width: 10),
                          CustomContainer(icon: Icons.watch_later_outlined, text: 'Shift Out', subTitle: '${shift.endTime??"Null"}')
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomContainer(icon: Icons.watch_later_outlined, text: 'Worked Hours', subTitle: shift.endTime??'Null'),
                          const SizedBox(width: 10),
                          CustomContainer(icon: Icons.calendar_month, text: 'Date', subTitle: shift.division)
                        ],
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            ),
          );
          }
        }
      ),
    );
  }

  Color _getAttendanceColor(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.P:
        return AppColors.presentColor;
      case AttendanceStatus.MIS:
        return AppColors.misPunchColor;
      case AttendanceStatus.SRT:
        return AppColors.shortColor;
      case AttendanceStatus.HD:
        return AppColors.info20;
      case AttendanceStatus.HLD:
        return AppColors.warning60;
      case AttendanceStatus.A:
      default:
        return AppColors.absentColor;
    }
  }
}



