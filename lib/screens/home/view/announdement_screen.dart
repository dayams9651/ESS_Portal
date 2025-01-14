import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/image_strings.dart';
import '../../../style/color.dart';
import '../../../style/text_style.dart';
import '../controller/announcement_controller.dart';

class AnnouncementScreen extends GetView<AnnouncementController> {
  AnnouncementScreen({
    super.key
});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Center(child: Text("Announcement", style: AppTextStyles.kPrimaryTextStyle)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(
                      color: AppColors.white,
                      elevation: 18.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              filterQuality: FilterQuality.high,
                              scale: 0.5,
                              random,
                            ),
                            SizedBox(height: 10,),
                            Text('Celebrating Independence Day with sCreativity and Knowledge',
                            style: AppTextStyles.kSmall12SemiBoldTextStyle,),
                            Text('4h ago 22 August 2024', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white60),),
                            SizedBox(height: 9,),
                            Text("We believe in honoring our nation's rich history and culture while fostering creativity among our team members. On 10 August 2024, we conducted two engaging activities to commemorate the spirit of Independence Day",
                            style: AppTextStyles.kSmall12RegularTextStyle,),
                            SizedBox(height: 5,),
                            Container(
                              height: 47,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.white100),
                                color: AppColors.primaryColor2,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  // controller: newPasswordController,
                                  decoration: InputDecoration(
                                    hintText: '    Add a comment....',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        // Add your onPressed logic here
                                      },
                                      icon: Icon(
                                        Icons.telegram,
                                        size: 30,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    border: InputBorder.none, // Remove the underline
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}