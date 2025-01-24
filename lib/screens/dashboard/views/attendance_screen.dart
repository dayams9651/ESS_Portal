import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/common/const_api.dart';
import 'package:ms_ess_potal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_potal/screens/dashboard/contoller/attendance_controller.dart';
import 'package:ms_ess_potal/screens/dashboard/contoller/shift_controller.dart';
import 'package:ms_ess_potal/screens/dashboard/widget/custom_container.dart';
import 'package:ms_ess_potal/style/color.dart';
import 'package:ms_ess_potal/style/text_style.dart';
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
  int selectedMonth = 1;
  List<AttendanceStatus> attendance = [];
  final List<int> years = [2023, 2024, 2025]; // Define available years
  final List<String> months = [
    "January", "February", "March", "April", "May", "June", "July",
    "August", "September", "October", "November", "December"
  ];
  final List<String> daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  DateTime currentDate = DateTime.now(); // Current date for highlighting

  final ShiftController controller = Get.put(ShiftController());
  final AttendanceController attendController = Get.put(AttendanceController());

  List<Attendance> fetchedAttendanceData = [];

  @override
  void initState() {
    super.initState();
    attendController.fetchAttendanceData('2025-01-01', '2025-01-31');
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
      attendController.fetchAttendanceData(
        '$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-01',
        '$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-${getDaysInMonth(selectedYear, selectedMonth)}',
      );
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
      attendController.fetchAttendanceData(
        '$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-01',
        '$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-${getDaysInMonth(selectedYear, selectedMonth)}',
      );
    });
  }

  bool isToday(int day) {
    return selectedYear == currentDate.year &&
        selectedMonth == currentDate.month &&
        day == currentDate.day;
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchShiftData();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (attendController.isLoading.value) {
          return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
        } else if (attendController.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${attendController.errorMessage.value}'));
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
                              attendController.fetchAttendanceData(
                                '$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-01',
                                '$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-${getDaysInMonth(selectedYear, selectedMonth)}',
                              );
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${attendController.totalPresent}",
                          style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor),
                        ),
                        Text("Present", style: AppTextStyles.kSmall12RegularTextStyle),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "${attendController.totalMissPunch}",
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
                  height: 350,
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

                        // Find the attendance for the specific day
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
                            color: Colors.grey.shade300,
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
      }),
    );
  }

  Color _getAttendanceColor(Attendance attendance) {
    switch (attendance.title) {
      case "P":
        return AppColors.success60;
      case "WO":
        return AppColors.absentColor;
      case "HLD":
        return AppColors.warning60;
      case "A":
        return AppColors.error80;
      case "SRT":
        return AppColors.error20;
      case "MIS":
        return AppColors.error40;
      case "HD":
        return AppColors.success80;
      default:
        return AppColors.error80;
    }
  }
}
