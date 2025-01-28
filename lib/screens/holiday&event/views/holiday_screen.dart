import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_potal/screens/holiday&event/controller/holiday_controller.dart';
import 'package:ms_ess_potal/screens/holiday&event/models/holiday_model.dart';
import 'package:ms_ess_potal/style/color.dart';
import 'package:ms_ess_potal/style/text_style.dart';
import 'package:shimmer/shimmer.dart';
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

  final EventController controller = Get.put(EventController());

  @override
  void initState() {
    super.initState();
    controller.fetchEvents(selectedYear, monthNames[selectedMonth]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text("Holiday & Event", style: AppTextStyles.kPrimaryTextStyle,)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx((){
        if(controller.isLoading.value){
          return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
        }
        else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150,
                      height: 40,
                      color: AppColors.primaryColor,
                      child: Center(
                        child: DropdownButton<int>(
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
                            controller.fetchEvents(
                                selectedYear, monthNames[selectedMonth]!);
                          },
                        ),
                      ),
                    ),
                    Container(
                      color: AppColors.white40,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.keyboard_arrow_left_sharp),
                            onPressed: () {
                              setState(() {
                                int currentMonthIndex = monthNames[selectedMonth]! -
                                    1;
                                if (currentMonthIndex == 0) {
                                  selectedMonth = 'December';
                                } else {
                                  selectedMonth = monthNames.keys.elementAt(
                                      currentMonthIndex - 1);
                                }
                              });
                              controller.fetchEvents(
                                  selectedYear, monthNames[selectedMonth]!);
                            },
                          ),
                          Text(
                            selectedMonth,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.keyboard_arrow_right_sharp),
                            onPressed: () {
                              setState(() {
                                int currentMonthIndex = monthNames[selectedMonth]! -
                                    1;
                                if (currentMonthIndex == 11) {
                                  selectedMonth = 'January';
                                } else {
                                  selectedMonth = monthNames.keys.elementAt(
                                      currentMonthIndex + 1);
                                }
                              });
                              controller.fetchEvents(
                                  selectedYear, monthNames[selectedMonth]!);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (controller.events.isEmpty) {
                      return Center(child: Text(
                          "No events found for $selectedMonth $selectedYear"));
                    }

                    return ListView.builder(
                      itemCount: controller.events.length,
                      itemBuilder: (context, index) {
                        EventModel event = controller.events[index];
                        DateTime eventDate = DateTime.parse(event.start);
                        bool showDescription = false;
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                title: Text(event.title, style: AppTextStyles
                                    .kSmall12SemiBoldTextStyle),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('${eventDate.day}-${eventDate
                                            .month}-${eventDate.year}',
                                            style: AppTextStyles
                                                .kSmall10SemiBoldTextStyle),
                                        const SizedBox(width: 15),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showDescription =
                                              !showDescription;
                                            });
                                          },
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.green,
                                            child: Icon(
                                              showDescription
                                                  ? Icons.remove
                                                  : Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (showDescription)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0),
                                        child: Text(event.description,
                                            style: AppTextStyles
                                                .kSmall10RegularTextStyle),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          );
        }}),
    );
  }
}
