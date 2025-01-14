import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ms_ess_potal/common/widget/const_text_with_styles.dart';
import 'package:ms_ess_potal/screens/dashboard/widget/custom_card_home.dart';
import 'package:ms_ess_potal/screens/notification/view/notification_screen.dart';
import 'package:ms_ess_potal/style/color.dart';
import '../../../style/text_style.dart';
import 'dart:async';
class HomeScreen extends StatefulWidget {
  final NotchBottomBarController? controller;
  static const double cardHeight = 250;
  static const double cardWidth = 190;
  static const double iconSize = 25;

  const HomeScreen({super.key, this.controller});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentTime = DateTime.now();
  late Color lineColor;
  late Timer _timer;
  late PageController _pageController;
  // List<String> images = [
  //   "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
  //   "https://wallpaperaccess.com/full/2637581.jpg",
  //   "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  // ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    lineColor = AppColors.primaryColor;  // Default color
    _startTimeUpdates();
  }

  void _startTimeUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
        updateLineColor();
      });
    });
  }

  void updateLineColor() {
    final elapsedSeconds = currentTime.hour * 3600 + currentTime.minute * 60 + currentTime.second;
    const nineHoursInSeconds = 1 * 3600;

    if (elapsedSeconds >= nineHoursInSeconds) {
      lineColor = AppColors.white10;  // Color after 9 hours
    } else {
      lineColor = AppColors.success10;  // Color before 9 hours
    }
  }

  @override
  void dispose() {
    _timer.cancel();  // Cancel timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height / 8.5,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor2,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: ListTile(
              title: Text("Good Morning, Mukul", style: AppTextStyles.kSmall12SemiBoldTextStyle),
              subtitle: Text("Let's be productive today!", style: AppTextStyles.kSmall12RegularTextStyle),
              trailing: IconButton(
                onPressed: () {
                  Get.to(NotificationScreen());
                },
                icon: const Icon(Icons.notifications_outlined, size: 35),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const12TextBold("OverView"),
                Card(
                  color: AppColors.primaryColor2,
                  child: SizedBox(
                    height: height / 8,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Start your shift at 09:11 AM", style: AppTextStyles.kSmall12RegularTextStyle),
                          const SizedBox(height: 3),
                          Text(
                            DateFormat('HH:mm:ss').format(currentTime),
                            style: AppTextStyles.kBody16SemiBoldTextStyle,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: width / 1.5,
                            height: 7.5,
                            child: LinearProgressIndicator(
                              value: currentTime.hour >= 9 ? 1.0 : (currentTime.hour + currentTime.minute / 60) / 9,
                              color: lineColor,
                              backgroundColor: Colors.grey[200],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const12TextBold("Leave Balance"),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomHomeCard(icon: Icons.medical_information_outlined, text: 'Sick Leave', text1: '0.5 / 6', subTitle: '0.5'),
                    CustomHomeCard(icon: Icons.currency_exchange, text: 'Earned Leave', text1: '0.5 / 6', subTitle: '0.5')
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomHomeCard(icon: Icons.done_outline, text: 'Compensatory\nLeave', text1: '1', subTitle: '0.5'),
                    CustomHomeCard(icon: Icons.home_outlined, text: 'Work From\nHome', text1: '0.5 / 6', subTitle: '0.5')
                  ],
                ),
                const SizedBox(height: 5),
                const12TextBold("New Hires"),
                const SizedBox(height: 5,),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // Scroll horizontally
                    itemCount: 4,
                    // itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: ClipRRect(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              width: 165,
                              decoration: BoxDecoration(
                                  // color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.white70, width: 2)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      radius: 45,
                                      backgroundColor: AppColors.info10,
                                      child: Icon(Icons.person, size: 45,),
                                    ),
                                    const Text('02-01-2025'),
                                    const SizedBox(height: 2,),
                                    const10TextBold("Vaibhav Kumar"),
                                    const SizedBox(height: 2,),
                                    const Text("Friday, (1 day ago)")
                                  ],
                                ),
                              )
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 5),
                const12TextBold("Birthday Bash"),
                const SizedBox(height: 5,),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // Scroll horizontally
                    itemCount: 4,
                    // itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: ClipRRect(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                                width: 165,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.white70, width: 2)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const CircleAvatar(
                                        radius: 45,
                                        backgroundColor: AppColors.info10,
                                        child: Icon(Icons.person, size: 45,),
                                      ),
                                      const Text('02-01-2025'),
                                      const SizedBox(height: 2,),
                                      const10TextBold("Tripti Yadav"),
                                      const SizedBox(height: 2,),
                                      const Text("Friday, (1 day ago)")
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 5),
                const12TextBold("Work Anniversary"),
                const SizedBox(height: 5,),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // Scroll horizontally
                    itemCount: 4,
                    // itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: ClipRRect(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                                width: 165,
                                decoration: BoxDecoration(
                                  // color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.white70, width: 2)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const CircleAvatar(
                                        radius: 45,
                                        backgroundColor: AppColors.info10,
                                        child: Icon(Icons.person, size: 45,),
                                      ),
                                      const SizedBox(height: 7,),
                                      const Text('02-01-2025'),
                                      const SizedBox(height: 2,),
                                      const10TextBold("Naveen Kumar"),
                                      const SizedBox(height: 2,),
                                      const Text("Friday, (1 day ago)")
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 5),
                const12TextBold("Today's Office Absence"),
                const SizedBox(height: 5,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Card(
                        color: AppColors.white,
                        elevation: 8.0,
                        child: ListTile(
                          leading: const CircleAvatar(
                            radius: 35,
                            backgroundColor: AppColors.info10,
                              child: Icon(Icons.person, size: 35,),
                          ),
                          title: Text('Rohan Kumar (Information Technology)',style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                          subtitle: Text('SL : 11-01-2025 to 13-01-2025 for 2 days', style: AppTextStyles.kSmall10RegularTextStyle,),
                        ),
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
