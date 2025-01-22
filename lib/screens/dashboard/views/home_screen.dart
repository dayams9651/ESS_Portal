import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ms_ess_potal/common/widget/const_text_with_styles.dart';
import 'package:ms_ess_potal/screens/dashboard/contoller/earned_leave_controller.dart';
import 'package:ms_ess_potal/screens/dashboard/contoller/home_controller.dart';
import 'package:ms_ess_potal/screens/dashboard/widget/custom_card_home.dart';
import 'package:ms_ess_potal/screens/notification/view/notification_screen.dart';
import 'package:ms_ess_potal/style/color.dart';
import '../../../style/text_style.dart';
import 'dart:async';
import '../contoller/leave_list_controller.dart';
import '../contoller/new_hireList_controller.dart';
import '../contoller/wA_controller.dart';
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
      lineColor = AppColors.success20;  // Color before 9 hours
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final BirthdayBashController controller = Get.put(BirthdayBashController());
  final NewHireListController controllerNewHire = Get.put(NewHireListController());
  final WorkAnniversaryController controllerWA = Get.put(WorkAnniversaryController());
  final EarnedLeaveController controllerEL = Get.put(EarnedLeaveController());
  final LeaveController leaveController = Get.put(LeaveController());

  @override
  Widget build(BuildContext context) {
    leaveController.fetchLeaveList();
    controllerEL.fetchEarnedLeave();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Obx((){
      if(controller.isLoading.value){
        return const Center(child: CircularProgressIndicator(),);
      }
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
                title: const Text("Good Morning, Mukul",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
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
                  const12TextBold("Overview"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomHomeCard(iconButton: IconButton(onPressed: (){
                      }, icon: Icon(Icons.medical_information_outlined)), text: 'Sick Leave', text1: '${controllerEL.earnedLeave.value}', subTitle: '0.5'),
                      CustomHomeCard(icon: Icons.currency_exchange, text: 'Earned Leave', text1: '${controllerEL.earnedLeave}', subTitle: '0.5')
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomHomeCard(icon: Icons.done_outline, text: 'Compensatory\nLeave', text1: 'contr', subTitle: '0.5'),
                      CustomHomeCard(icon: Icons.home_outlined, text: 'Work From\nHome', text1: '0.5 / 6', subTitle: '0.5')
                    ],
                  ),
                  const SizedBox(height: 5),
                  const12TextBold("New Hires"),
                  const SizedBox(height: 5,),
                  SizedBox(
                    height: 210,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // Scroll horizontally
                      itemCount: controllerNewHire.newHireList.length,
                      itemBuilder: (context, index) {
                        final newHires = controllerNewHire.newHireList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: ClipRRect(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.white70, width: 2)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 45,
                                          backgroundImage: NetworkImage(newHires.photo!),
                                          // child: Image.network(newHires.photo!),
                                        ),
                                        Text(newHires.date??'', style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                                        const SizedBox(height: 2,),
                                        Text(newHires.name??"", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor),),
                                        const SizedBox(height: 2,),
                                         Text("${newHires.day} (${newHires.timeago})")
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
                    height: 210,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.birthdayList.length,
                      itemBuilder: (context, index) {
                        final item = controller.birthdayList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: ClipRRect(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.white70, width: 2)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 45,
                                          backgroundImage: NetworkImage(item.photo!),
                                          // child: Image.network(item.photo!),
                                        ),
                                        const SizedBox(height: 2,),
                                        Text(item.date??"", style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                                        Text(item.name??"", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor),),
                                        const SizedBox(height: 2,),
                                        Center(child: Text(item.department??""))
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
                      itemCount: controllerWA.wAList.length,
                      itemBuilder: (context, index) {
                        final workAList = controllerWA.wAList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: ClipRRect(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.white70, width: 2)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 45,
                                          backgroundImage: NetworkImage(workAList.photo!),
                                        ),
                                        const SizedBox(height: 7,),
                                        Text(workAList.date??'', style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                                        const SizedBox(height: 2,),
                                        Text(workAList.name??"", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor),),
                                        const SizedBox(height: 2,),
                                        Text(workAList.department??'')
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
                    itemCount:  leaveController.leaveRequests.length,
                    itemBuilder: (context, index) {
                      final leave = leaveController.leaveRequests[index];
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Card(
                          color: AppColors.white,
                          elevation: 8.0,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(leave.empPhoto),
                            ),
                            title: Text('${leave.empName} (${leave.department})',style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                            subtitle: Text('${leave.leaveType} :  ${leave.dateFrom} To ${leave.dateTo}', style: AppTextStyles.kSmall10RegularTextStyle,),
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
    );
  }
}