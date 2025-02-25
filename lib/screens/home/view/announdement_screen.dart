import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/noInternet/no_internet_controller.dart';
import 'package:ms_ess_portal/screens/home/controller/announcement_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../common/widget/const_shimmer_effects.dart';
import '../../../style/color.dart';
import '../../../style/text_style.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});
  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  final AnnouncementController controller = Get.put(AnnouncementController());
  final NetworkController networkController = Get.put(NetworkController());
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
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Obx(() {
          if(controller.isLoading.value) {
            return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.announcements.length,
                  itemBuilder: (context, index) {
                    var announcement = controller.announcements[index];
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
                              SizedBox(height: 10),
                              Text(
                                announcement.tmlnTitle,
                                style: AppTextStyles.kSmall12SemiBoldTextStyle,
                              ),
                              SizedBox(height: 9),
                              Text(
                                announcement.tmlnInsertDate,
                                style: AppTextStyles.kSmall12SemiBoldTextStyle.copyWith(color: AppColors.white50),
                              ),
                              Text(
                                "Posted By : ${announcement.tmlnInsertBy}",
                                style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.primaryColor),
                              ),
                              HtmlWidget(announcement.tmlnContent,),
                              SizedBox(height: 5),
                              Container(
                                height: 47,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.white100),
                                  color: AppColors.primaryColor2,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    // controller: newPasswordController,
                                    decoration: InputDecoration(
                                      hintText: '    Add a comment....',
                                      suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.telegram,
                                          size: 28,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}


