import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:ms_ess_portal/common/widget/const_text_with_styles.dart';
import 'package:ms_ess_portal/const/image_strings.dart';
import 'package:ms_ess_portal/noInternet/no_internet_controller.dart';
import 'package:ms_ess_portal/noInternet/no_internet_screen.dart';
import 'package:ms_ess_portal/screens/dashboard/contoller/attendance_controller.dart';
import 'package:ms_ess_portal/screens/dashboard/contoller/earned_leave_controller.dart';
import 'package:ms_ess_portal/screens/dashboard/contoller/home_controller.dart';
import 'package:ms_ess_portal/screens/dashboard/contoller/sick_leave_controller.dart';
import 'package:ms_ess_portal/screens/dashboard/contoller/wfh_leave_controller.dart';
import 'package:ms_ess_portal/screens/notification/view/notification_screen.dart';
import 'package:ms_ess_portal/service/logInApi.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:shimmer/shimmer.dart';
import '../../../common/widget/const_shimmer_effects.dart';
import '../../../style/text_style.dart';
import 'dart:async';
import '../contoller/leave_list_controller.dart';
import '../contoller/new_hireList_controller.dart';
import '../contoller/shift_controller.dart';
import '../contoller/wA_controller.dart';
import '../widget/custom_card_home.dart';

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
    lineColor = AppColors.primaryColor;
    _startTimeUpdates();
    controllerSL.fetchSickLeaveBalance;
    controllerShift.fetchShiftData;
    attendController.fetchAttendanceData('2025-02-01', '2026-05-28');
    // attendController.fetchAttendanceData('2025-02-01', '2026-05-28');
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
  final NetworkController networkController = Get.put(NetworkController());
  final AttendanceController attendController = Get.put(AttendanceController());
  final BirthdayBashController controller = Get.put(BirthdayBashController());
  final NewHireListController controllerNewHire = Get.put(NewHireListController());
  final WorkAnniversaryController controllerWA = Get.put(WorkAnniversaryController());
  final EarnedLeaveController controllerEL = Get.put(EarnedLeaveController());
  final LeaveController leaveController = Get.put(LeaveController());
  final LeaveBalanceController controllerWFH = Get.put(LeaveBalanceController());
  final SickLeaveBalanceController controllerSL = Get.put(SickLeaveBalanceController());
  final UserLogInService controllerLogIn = Get.put(UserLogInService());
  final ShiftController controllerShift = Get.put(ShiftController());
  // final AttendanceController attendController = Get.put(AttendanceController());
  final LeaveBalanceController leaveBalanceController = Get.put(LeaveBalanceController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Obx(() {
      if (!networkController.isConnected.value) {
        NoInternetScreen();
      }
      if (controller.isLoading.value) {
        return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
      }
      else {
        final leaveBalance = controllerWFH.leaveBalance.value;
        final leaveELBalance = controllerEL.earnedLeave.value;
        final sickLeave = controllerSL.sickLeaveBalance.value;
        final logInResponse = controllerLogIn.logInData.value;
        final shiftIn = controllerShift.shiftModel.value;

        DateTime shiftInTime;
        if (shiftIn?.todayIn != null ) {
          try {
            shiftInTime = DateFormat('dd-MM-yyyy HH:mm:ss').parse(shiftIn!.todayIn);
          } catch (e) {
            shiftInTime = DateTime.now();
          }
        } else {
          shiftInTime = DateFormat('dd-MM-yyyy HH:mm:ss').parse("01-01-0000 00:00:00");
        }

        Duration elapsedTime = currentTime.difference(shiftInTime);
        Duration maxDuration = Duration(hours: 9);

        if (elapsedTime > maxDuration) {
          elapsedTime = maxDuration;
        }

        String getGreetingMessage() {
          int hour = currentTime.hour;

          if (hour >= 5 && hour < 12) {
            return "Good Morning";
          } else if (hour >= 12 && hour < 17) {
            return "Good Afternoon";
          } else if (hour >= 17 && hour < 21) {
            return "Good Evening";
          } else {
            return "Good Night";
          }
        }
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
          child: SingleChildScrollView(
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
                    title: Text(
                      "${getGreetingMessage()}, ${logInResponse?.data?.userName.toString()}",
                      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
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
                                Text("Start your shift at: ${shiftIn?.todayIn??00-00-00}", style: AppTextStyles.kSmall12RegularTextStyle),
                                const SizedBox(height: 3),
                                Text(
                                  "${elapsedTime.inHours.toString().padLeft(2, '0')}:${(elapsedTime.inMinutes % 60).toString().padLeft(2, '0')}:${(elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}",
                                  style: AppTextStyles.kBody16SemiBoldTextStyle,
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: width / 1.5,
                                  height: 7.5,
                                  child: LinearProgressIndicator(
                                    value: elapsedTime.inSeconds / maxDuration.inSeconds,
                                    color: AppColors.success40,
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
                          CustomHomeCard(icon: Icons.medical_information_outlined, text: 'Sick Leave', text1: '${sickLeave?.data?.lClBal ??0} / ${sickLeave?.data?.totalYrBal??0}', subTitle: '0.666', iconButton: IconButton(onPressed: (){
                            controllerSL.leaveUpdateBalance;
                          }, icon: Icon(Icons.refresh_outlined)),
                            ),
                          CustomHomeCard(icon: Icons.currency_exchange, text: 'Earned Leave', text1: '${leaveELBalance?.data?.lClBal??0} / ${leaveELBalance?.data?.totalYrBal??0}', subTitle: '0.5', iconButton: IconButton(onPressed: (){
                            controllerEL.fetchEarnedLeaveUpdate;
                          }, icon: Icon(Icons.refresh_outlined)),)
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomHomeCard(icon: Icons.done_outline, text: 'Compensatory\nLeave', text1: '', subTitle: '0.5'),
                          CustomHomeCard(icon: Icons.home_outlined, text: 'Work From\nHome', text1: '${leaveBalance?.data?.lOpBal ?? 0} / ${leaveBalance?.data?.lClBal ?? 0}', subTitle: '0.5', iconButton: IconButton(onPressed: (){
                            leaveBalanceController.fetchLeaveBalanceUpdate;
                          }, icon: Icon(Icons.refresh_outlined)),)
                        ],
                      ),
                      const SizedBox(height: 5),
                      const12TextBold("New Hires"),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 210,
                        child: controllerNewHire.newHireList.isEmpty ? Center(child: Image.asset(noData1),) : ListView.builder(
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
                                            ),
                                            Text(newHires.date ?? '', style: AppTextStyles.kSmall10SemiBoldTextStyle),
                                            const SizedBox(height: 2),
                                            Text(newHires.name ?? "", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                                            const SizedBox(height: 2),
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
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 210,
                        child: controller.birthdayList.isEmpty ? Center(child: Image.asset(noData1),) : ListView.builder(
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
                                            ),
                                            const SizedBox(height: 2),
                                            Text(item.date ?? "", style: AppTextStyles.kSmall10SemiBoldTextStyle),
                                            Text(item.name ?? "", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                                            const SizedBox(height: 2),
                                            Center(child: Text(item.department ?? ""))
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
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 200,
                        child: controllerWA.wAList.isEmpty ? Center(child: Image.asset(noData1),) : ListView.builder(
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
                                            const SizedBox(height: 7),
                                            Text(workAList.date ?? '', style: AppTextStyles.kSmall10SemiBoldTextStyle),
                                            const SizedBox(height: 2),
                                            Text(workAList.name ?? "", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                                            const SizedBox(height: 2),
                                            Text(workAList.department ?? '')
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
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 250,
                        child:leaveController.leaveRequests.isEmpty  ? Center(child: Image.asset(noData1, )) :ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: leaveController.leaveRequests.length,
                          itemBuilder: (context, index) {
                            final leave = leaveController.leaveRequests[index] ;
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
                                  title: Text('${leave.empName} (${leave.department})',style: AppTextStyles.kSmall10SemiBoldTextStyle),
                                  subtitle: Text('${leave.leaveType} :  ${leave.dateFrom} To ${leave.dateTo}', style: AppTextStyles.kSmall10RegularTextStyle),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
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
}
