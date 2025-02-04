import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/service/logInApi.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/widget/const_shimmer_effects.dart';
import '../../../common/widget/const_text_with_styles.dart';
import '../../../common/widget/round_button.dart';
import '../../../style/text_style.dart';
import '../widget/profile_container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserLogInService controller = Get.put(UserLogInService());
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx((){
        if(controller.isLoading.value){
          return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
        }
        else {
          final profileData = controller.logInData.value;
          return SingleChildScrollView(  // Wrap the whole body with SingleChildScrollView for scrolling
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(profileData?.data.photo??"No Img"),
                        ),
                        SizedBox(height: 5,),
                        const12TextBold("${profileData?.data.userName}"),
                        const12Text("${profileData?.data.designation}")
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  ProfileContainer(
                    icon: Icons.import_contacts,
                    text: "About me",
                    onTap: () {
                      // Show the dialog when "About me" is tapped
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return  Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0), // Square corners
                            ),
                            backgroundColor: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              // width: MediaQuery.of(context).size.width * 1.0, // Adjust the width if needed
                              child: Column(
                                mainAxisSize: MainAxisSize.min, // Make dialog height flexible to content
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop(); // Close the pop-up
                                      },
                                      child: Icon(
                                        Icons.cancel_outlined,
                                        color: AppColors.primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10), // Reduced space to minimize height
                                  Text("Mukul Taneja ( T0019 )", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                  const SizedBox(height: 3), // Reduced space to minimize height
                                  const10Text("Information Technology as UI-UX Design"),
                                  SizedBox(height: 7,),
                                  Text("On Duty For 9h & 0 min", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                                  const10Text("Request date : 16-12-2024"),
                                  SizedBox(height: 7,),
                                  const10Text("Due to punch machine not setup in B-88 branch"),
                                  const SizedBox(height: 10), // Reduced space to minimize height
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const12TextBold('Date'),
                                          Text('16-12-2024', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const12TextBold('Session'),
                                          Text('9:00 AM - 11:30 AM', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const12TextBold('Days'),
                                          Text('16', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ProfileContainer(icon: Icons.family_restroom_outlined, text: 'Family Info', onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return  Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0), // Square corners
                          ),
                          backgroundColor: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            // width: MediaQuery.of(context).size.width * 1.0, // Adjust the width if needed
                            child: Column(
                              mainAxisSize: MainAxisSize.min, // Make dialog height flexible to content
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop(); // Close the pop-up
                                    },
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: AppColors.primaryColor,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10), // Reduced space to minimize height
                                Text("Mukul Taneja ( T0019 )", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                const SizedBox(height: 3), // Reduced space to minimize height
                                const10Text("Information Technology as UI-UX Design"),
                                SizedBox(height: 7,),
                                Text("On Duty For 9h & 0 min", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                                const10Text("Request date : 16-12-2024"),
                                SizedBox(height: 7,),
                                const10Text("Due to punch machine not setup in B-88 branch"),
                                const SizedBox(height: 10), // Reduced space to minimize height
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const12TextBold('Date'),
                                        Text('16-12-2024', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const12TextBold('Session'),
                                        Text('9:00 AM - 11:30 AM', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const12TextBold('Days'),
                                        Text('16', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  ProfileContainer(icon: Icons.mail_outline, text: 'Contact Info', onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return  Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0), // Square corners
                          ),
                          backgroundColor: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            // width: MediaQuery.of(context).size.width * 1.0, // Adjust the width if needed
                            child: Column(
                              mainAxisSize: MainAxisSize.min, // Make dialog height flexible to content
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop(); // Close the pop-up
                                    },
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: AppColors.primaryColor,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10), // Reduced space to minimize height
                                Text("Mukul Taneja ( T0019 )", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                const SizedBox(height: 3), // Reduced space to minimize height
                                const10Text("Information Technology as UI-UX Design"),
                                SizedBox(height: 7,),
                                Text("On Duty For 9h & 0 min", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                                const10Text("Request date : 16-12-2024"),
                                SizedBox(height: 7,),
                                const10Text("Due to punch machine not setup in B-88 branch"),
                                const SizedBox(height: 10), // Reduced space to minimize height
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const12TextBold('Date'),
                                        Text('16-12-2024', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const12TextBold('Session'),
                                        Text('9:00 AM - 11:30 AM', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const12TextBold('Days'),
                                        Text('16', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  ProfileContainer(icon: Icons.wifi_calling_outlined, text: 'Emergency Contact', onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return  Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0), // Square corners
                          ),
                          backgroundColor: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            // width: MediaQuery.of(context).size.width * 1.0, // Adjust the width if needed
                            child: Column(
                              mainAxisSize: MainAxisSize.min, // Make dialog height flexible to content
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop(); // Close the pop-up
                                    },
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: AppColors.primaryColor,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10), // Reduced space to minimize height
                                Text("Mukul Taneja ( T0019 )", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                const SizedBox(height: 3), // Reduced space to minimize height
                                const10Text("Information Technology as UI-UX Design"),
                                SizedBox(height: 7,),
                                Text("On Duty For 9h & 0 min", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                                const10Text("Request date : 16-12-2024"),
                                SizedBox(height: 7,),
                                const10Text("Due to punch machine not setup in B-88 branch"),
                                const SizedBox(height: 10), // Reduced space to minimize height
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const12TextBold('Date'),
                                        Text('16-12-2024', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const12TextBold('Session'),
                                        Text('9:00 AM - 11:30 AM', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const12TextBold('Days'),
                                        Text('16', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  ProfileContainer(icon: Icons.folder_special_outlined, text: 'Compliance Info', onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return  Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0), // Square corners
                          ),
                          backgroundColor: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            // width: MediaQuery.of(context).size.width * 1.0, // Adjust the width if needed
                            child: Column(
                              mainAxisSize: MainAxisSize.min, // Make dialog height flexible to content
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop(); // Close the pop-up
                                    },
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: AppColors.primaryColor,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10), // Reduced space to minimize height
                                Text("Mukul Taneja ( T0019 )", style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                const SizedBox(height: 3), // Reduced space to minimize height
                                const10Text("Information Technology as UI-UX Design"),
                                SizedBox(height: 7,),
                                Text("On Duty For 9h & 0 min", style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.primaryColor)),
                                const10Text("Request date : 16-12-2024"),
                                SizedBox(height: 7,),
                                const10Text("Due to punch machine not setup in B-88 branch"),
                                const SizedBox(height: 10), // Reduced space to minimize height
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const12TextBold('Date'),
                                        Text('16-12-2024', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const12TextBold('Session'),
                                        Text('9:00 AM - 11:30 AM', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const12TextBold('Days'),
                                        Text('16', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white50),)
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
