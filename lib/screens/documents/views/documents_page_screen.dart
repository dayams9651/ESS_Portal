import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/screens/documents/controller/documents_controller.dart';
import '../../../style/color.dart';
import '../../../style/text_style.dart';

class DocumentsPageScreen extends GetView<DocumentsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:  AppBar(
        title: Center(child: Text("Holiday & Event", style: AppTextStyles.kPrimaryTextStyle)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
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
                    title: Text("Work Policy", style: AppTextStyles.kPrimaryTextStyle),
                    subtitle: Text("Size: 278.89 KB"),
                    leading: Icon(Icons.picture_as_pdf_outlined, color: AppColors.primaryColor, size: 30,),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.presentColor,
                    child: Icon(Icons.file_download_outlined, color: AppColors.primaryColor, size: 30,),
                  ),
                ),
                SizedBox(width: 8,),
              ],
            ),
          );
        },
      ),
    );
  }
}
