import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ms_ess_portal/common/widget/round_button.dart';
import 'package:ms_ess_portal/const/image_strings.dart';
import 'package:ms_ess_portal/screens/dashboard/views/attendance_screen.dart';
import 'package:ms_ess_portal/screens/dashboard/views/leave_screen.dart';
import 'package:ms_ess_portal/service/logInApi.dart';
import 'package:ms_ess_portal/style/text_style.dart';
import '../../const/const_height.dart';
import '../../const/const_width.dart';
import '../../routes/routes.dart';
import '../../style/color.dart';
import 'views/home_screen.dart';
import 'views/profile_screen.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen> {
  final _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);
  int maxCount = 5;
  int _selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final UserLogInService controllerLogIn = Get.put(UserLogInService());
  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      HomeScreen(controller: (_controller)),
       const AttendanceScreen(),
      LeaveScreen(),
      const ProfileScreen(),
    ];
    final List<String> pageTitles = [
      'Dashboard',
      'Track Attendance',
      'Apply Leave',
      'Profile',
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor2,
        title: Text(pageTitles[_selectedIndex], style: AppTextStyles.kBody16SemiBoldTextStyle,),
        actions: [
          Image.asset(logo, height: 35, width: 120)
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        children: List.generate(bottomBarPages.length, (index) {
          return bottomBarPages[index];
        }),
      ),
      drawer: Obx((){
        if(controllerLogIn.isLoading.value){
          return const Center(child: CircularProgressIndicator(),);
        } else {
          final logInResponse = controllerLogIn.logInData.value;
        return Drawer(
          backgroundColor: AppColors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      UserAccountsDrawerHeader(
                        currentAccountPictureSize: Size(78, 78),
                        decoration: const BoxDecoration(
                            color: AppColors.white
                        ),
                        accountName: Text('${logInResponse?.data.userName}',style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.white100),),
                        accountEmail: Text('${logInResponse?.data.designation ?? ""}', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white100),),
                        currentAccountPicture: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              logInResponse?.data.photo??"No Img"),
                        ),
                      ),
                      _buildDrawerItem(
                          icon: Icons.home_outlined,
                          text: 'Home',
                          onTap: () {},
                          subItems: [
                            _buildDrawerSubItem('Announcement', onTap: () {
                              Get.toNamed(ApplicationPages.announcementScreen);
                            }),
                            _buildDrawerSubItem('Hierarchy', onTap: () {
                              Get.toNamed(ApplicationPages.hierarchyScreen);
                            }),
                          ]),
                      _buildDrawerItem(icon: Icons.festival_outlined, text: 'Holiday / Event', onTap: (){
                        Get.toNamed(ApplicationPages.holidayScreen);
                      }),
                      _buildDrawerItem(
                          icon: Icons.self_improvement_outlined,
                          text: 'Self Service',
                          onTap: () {},
                          subItems: [
                            _buildDrawerSubItem('Leave Status', onTap: () {
                              Get.toNamed(ApplicationPages.leaveStatusScreen);
                            }),
                            _buildDrawerSubItem('Leave Grant', onTap: () {
                              Get.toNamed(ApplicationPages.leaveGrantScreen);
                            }),
                            // _buildDrawerSubItem('WFH Update', onTap: () {
                            //   Get.toNamed(ApplicationPages.leaveWFHScreen);
                            // }),
                            _buildDrawerSubItem('Payslip', onTap: () {
                              Get.toNamed(ApplicationPages.paySlipScreen);
                            }),
                          ]),

                      _buildDrawerItem(icon: Icons.keyboard_alt_outlined, text: 'Peripheral', onTap: (){
                        Get.toNamed(ApplicationPages.peripheralScreen);
                      }),
                      _buildDrawerItem(icon: Icons.snippet_folder_outlined, text: 'Documents', onTap: (){
                        Get.toNamed(ApplicationPages.documentsScreen);
                      }),
                      // _buildDrawerItem(icon: Icons.dangerous, text: 'For Testing', onTap: (){
                      //   Get.toNamed(ApplicationPages.testingScreen);
                      // }),
                      _buildDrawerItem(icon: Icons.auto_graph_outlined, text: 'Attendance Statistics', onTap: (){
                        Get.toNamed(ApplicationPages.statisticsScreen);

                      }),
                    ],
                  ),
                  const SizedBox(height: 70,),
                  Padding(
                    padding: const EdgeInsets.all(80.0),
                    child: RoundButton(title: 'Logout', onTap: () {
                      showLogOutConfirmation(context);
                    },),
                  )
                ],
              ),
            ],
          ),
          );
         }
       }
      ),
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: AppColors.primaryColor,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        shadowElevation: 5,
        kBottomRadius: 2.0,
        notchColor: AppColors.primaryColor,
        removeMargins: false,
        bottomBarWidth: 2,
        showShadow: false,
        durationInMilliSeconds: 300,
        itemLabelStyle: AppTextStyles.kSmall10SemiBoldTextStyle.copyWith(color: AppColors.white),
        elevation: 1,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              size: 30,
              Icons.home_filled,
              color: Colors.white70,
            ),
            activeItem: Icon(
              size: 30,
              Icons.home_filled,
              color: Colors.white,
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.calendar_month_outlined,
              size: 30,
              color: Colors.white70,
            ),
            activeItem: Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
            itemLabel: 'Status',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.settings,
              size: 30,
              color: Colors.white70,
            ),
            activeItem: Icon(
              size: 30,
              Icons.settings,
              color: Colors.white,
            ),
            itemLabel: 'Leave',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              size: 30,
              Icons.person,
              color: Colors.white70,
            ),
            activeItem: Icon(
              size: 30,
              Icons.person,
              color: Colors.white,
            ),
            itemLabel: 'Profile',
          ),
        ],
        onTap: (index) {
          debugPrint('current selected index $index');
          _pageController.jumpToPage(index);
          _onPageChanged(index); // Update the index on bottom bar tap
        },
        kIconSize: 24.0,
      )
          : null,
    );
  }
}
Widget _buildDrawerItem({
  required IconData icon,
  required String text,
  VoidCallback? onTap,
  List<Widget>? subItems,
}) {
  if (subItems != null && subItems.isNotEmpty) {
    return ExpansionTile(
      leading: Container(
          padding: EdgeInsets.all(w8),
          decoration: const BoxDecoration(
          ),
          child: Icon(
            icon, size: 28,
            // color: AppColors.white,
          )),
      title: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
      children: subItems,
    );
  } else {
    return ListTile(
        leading: Container(
            padding: EdgeInsets.all(w8),
            decoration: const BoxDecoration(
            ),
            child: Icon(
              icon,
              // color: AppColors.white,
            )),
        title: Text(text,  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        onTap: onTap);
  }
}
Widget _buildDrawerSubItem(String text,
    {VoidCallback? onTap, IconData? icons}) {
  return ListTile(
    leading: Container(
      padding: EdgeInsets.all(w8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Icon(
        icons ,
        size: w10,
        // color: AppColors.white,
      ),
    ),
    title: Text(text),
    onTap: onTap,
    trailing: Icon(
      Icons.arrow_forward_ios_rounded,
      color: AppColors.white70,
      size: w15,
    ),
  ).paddingSymmetric(vertical: h2);
}

Future<bool?> showLogOutConfirmation(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15,),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(); // Close the pop-up
                },
                child: const Icon(
                  Icons.cancel_outlined,
                  color: AppColors.primaryColor,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text("Logout", style: AppTextStyles.kCaption14SemiBoldTextStyle.copyWith(color: AppColors.error80)),
            const SizedBox(height: 10,),
            Text("Are you sure you want to Logout", style: AppTextStyles.kSmall12RegularTextStyle,),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 70, height: 38,
                  child: RoundButton(title: "Yes", onTap: (){
                    final box = GetStorage();
                    box.erase();
                    String? token = box.read('token');
                    if (token == null) {
                      print('Token has been deleted');
                    } else {
                      print('Token still exists: $token');
                    }
                    Get.toNamed(ApplicationPages.signUpScreen);
                }
                ,),),
                const SizedBox(width: 5,),
                SizedBox(width:70, height: 38,
                  child: RoundButton(title: "No", onTap: (){
                  Get.back();
                }),),
              ],
            )
          ],
        ),
      ),
    ),
  );
}