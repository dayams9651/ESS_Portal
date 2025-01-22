import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../style/color.dart';
import '../../../style/text_style.dart';

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({super.key});

  @override
  _HolidayEventPageState createState() => _HolidayEventPageState();
}

class _HolidayEventPageState extends State<HolidayScreen> {
  String selectedMonth = 'January';
  int selectedYear = 2025;
  Map<String, int> monthNames = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'October': 10,
    'November': 11,
    'December': 12,
  };
  List<Map<String, dynamic>> events = [
    {
      "date": "2025-01-01",
      "event": "New Year's Day",
      "description": "A day to celebrate the start of the new year."
    },
    {
      "date": "2025-01-26",
      "event": "Republic Day",
      "description": "A national holiday to celebrate the republic."
    },
    {
      "date": "2025-12-25",
      "event": "Christmas",
      "description": "A holiday to celebrate the birth of Jesus Christ."
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredEvents = events.where((event) {
      DateTime eventDate = DateTime.parse(event['date']);
      return eventDate.month == monthNames[selectedMonth] && eventDate.year == selectedYear;
    }).toList();

    void goToPreviousMonth() {
      setState(() {
        int currentMonthIndex = monthNames[selectedMonth]! - 1;
        if (currentMonthIndex == 0) {
          selectedMonth = 'December';
        } else {
          selectedMonth = monthNames.keys.elementAt(currentMonthIndex - 1);
        }
      });
    }

    void goToNextMonth() {
      setState(() {
        int currentMonthIndex = monthNames[selectedMonth]! - 1;
        if (currentMonthIndex == 11) {
          selectedMonth = 'January';
        } else {
          selectedMonth = monthNames.keys.elementAt(currentMonthIndex + 1);
        }
      });
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Center(child: Text("Holiday & Event", style: AppTextStyles.kPrimaryTextStyle)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 39,
                  color: AppColors.primaryColor,
                  child: Center(
                    child:   DropdownButton<int>(
                      value: selectedYear,
                      items: List.generate(10, (index) {
                        return DropdownMenuItem<int>(
                          value: 2025 + index,
                          child: Text('${2025 + index}'),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value!;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  color: AppColors.white30,
                  width: 200,
                  height: 40,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_left_sharp),
                        onPressed: goToPreviousMonth,
                      ),
                      Text(
                        selectedMonth,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_right_sharp),
                        onPressed: goToNextMonth,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) {
                  var event = filteredEvents[index];
                  DateTime eventDate = DateTime.parse(event['date']);
                  bool showDescription = false;
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Card(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: AppColors.white50
                          )
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(event['event'], style: AppTextStyles.kSmall12SemiBoldTextStyle,),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('${eventDate.day}-${eventDate.month}-${eventDate.year}', style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                                  const SizedBox(width: 15),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showDescription = !showDescription;
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: AppColors.success20,
                                      child: Icon(
                                        showDescription ? Icons.remove : Icons.add,
                                        color: AppColors.white100,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (showDescription)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(event['description'], style: AppTextStyles.kSmall12RegularTextStyle,),
                                ),
                            ],
                          ),
                          trailing: const CircleAvatar(
                            backgroundColor: AppColors.primary1,
                            radius: 30,
                            child: Icon(Icons.person),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
