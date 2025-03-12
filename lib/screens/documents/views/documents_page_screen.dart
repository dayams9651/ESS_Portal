import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_portal/screens/documents/controller/documents_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../style/color.dart';
import '../../../style/text_style.dart';

class DocumentsPageScreen extends GetView<SOPController> {
  final SOPController sopController = Get.put(SOPController());
   DocumentsPageScreen({super.key});


  Future<void> _launchURL(String url) async {
    try {
      await FlutterWebBrowser.openWebPage(
        url: url,
        customTabsOptions:  CustomTabsOptions(
          toolbarColor: AppColors.primaryColor,
        ),
      );
    } catch (e) {
      debugPrint('Error launching URL: $url');
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:  AppBar(
        title: Center(child: Text("Documents", style: AppTextStyles.kPrimaryTextStyle)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx((){
      if (sopController.isLoading.value) {
        return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
      } else if (sopController.hasError.value) {
        return Center(child: Text('Failed to load data.'));
      } else {
        return ListView.builder(
          itemCount: sopController.sopList.length,
          itemBuilder: (context, index) {
            final sop = sopController.sopList[index];
            final sopIcons = sopController.getFileTypeIcon(sop.path);
            return Card(
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: AppColors.white50
                  )
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(sop.name.isNotEmpty?sop.name:"Null", style: AppTextStyles.kSmall10SemiBoldTextStyle),
                      subtitle: Text("${sop.fileSize} | ${sop.datetime}"),
                      leading: sopIcons,
                    ),
                  ),
                  InkWell(
                    onTap: (){},
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.presentColor,
                      child: IconButton(onPressed: (){
                        _launchURL(sop.path);
                      },
                          icon: Icon(Icons.file_download_outlined)),
                    ),
                  ),
                  SizedBox(width: 8,),
                ],
              ),
            );
          },
        );
      }}),
    );
  }
}
