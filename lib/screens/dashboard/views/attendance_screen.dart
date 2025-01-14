import 'package:flutter/material.dart';
import 'package:ms_ess_potal/screens/dashboard/widget/custom_container.dart';
import 'package:ms_ess_potal/style/color.dart';
import 'package:ms_ess_potal/style/text_style.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

enum AttendanceStatus { absent, present, mispunch, short }

class _AttendanceScreenState extends State<AttendanceScreen> {
  int selectedYear = 2025;
  int selectedMonth = 1; // January
  List<AttendanceStatus> attendance = []; // Attendance status
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

  // This function calculates the number of days in a month
  int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day; // Last day of the month
  }

  // Get the first day of the month (used to align the grid)
  int getFirstDayOfMonth(int year, int month) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    return firstDayOfMonth.weekday; // 1 = Monday, 7 = Sunday
  }

  // Get the number of days in the previous month
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
      attendance = List.generate(daysInMonth, (index) => AttendanceStatus.absent);
    });
  }

  // Function to change attendance status for a particular day
  void toggleAttendance(int day) {
    setState(() {
      // Cycle through the attendance states
      switch (attendance[day]) {
        case AttendanceStatus.absent:
          attendance[day] = AttendanceStatus.present;
          break;
        case AttendanceStatus.present:
          attendance[day] = AttendanceStatus.mispunch;
          break;
        case AttendanceStatus.mispunch:
          attendance[day] = AttendanceStatus.short;
          break;
        case AttendanceStatus.short:
          attendance[day] = AttendanceStatus.absent;
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

  // Check if the day is today
  bool isToday(int day) {
    return selectedYear == currentDate.year &&
        selectedMonth == currentDate.month &&
        day == currentDate.day;
  }

  @override
  @override
  Widget build(BuildContext context) {
    int daysInMonth = getDaysInMonth(selectedYear, selectedMonth);
    int firstDayOfMonth = getFirstDayOfMonth(selectedYear, selectedMonth);
    int previousMonthDays = getDaysInPreviousMonth(selectedYear, selectedMonth);
    int totalCells = (firstDayOfMonth + daysInMonth + 6) ~/ 7 * 7;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.zero, // Ensure there's no extra padding here
        child: Column(
          children: [
            const SizedBox(height: 10,),
            // Year and Month Dropdowns
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

            // Attendance status summary Row
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

            // Days of the Week Header Row
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

            // Calendar Grid
            SizedBox(
              height: 320, // Adjust grid height for a more controlled layout
              child: GridView.builder(
                shrinkWrap: false, // Do not shrinkWrap for better control
                physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
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
                        color: Colors.grey.shade300, // Grey for past month days
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
                    // Render days from the next month
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

            // Padding and CustomContainer Widgets
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer(icon: Icons.watch_later_outlined, text: 'Shift In', subTitle: '09:12 AM'),
                      const SizedBox(width: 10),
                      CustomContainer(icon: Icons.watch_later_outlined, text: 'Shift Out', subTitle: '09:12 AM')
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer(icon: Icons.watch_later_outlined, text: 'Worked Hours', subTitle: '09:12 AM'),
                      const SizedBox(width: 10),
                      CustomContainer(icon: Icons.calendar_month, text: 'Date', subTitle: '09:12 AM')
                    ],
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Method to get color based on attendance status
  Color _getAttendanceColor(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return AppColors.presentColor;
      case AttendanceStatus.mispunch:
        return AppColors.misPunchColor;
      case AttendanceStatus.short:
        return AppColors.shortColor;
      case AttendanceStatus.absent:
      default:
        return AppColors.absentColor;
    }
  }
}
