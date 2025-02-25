import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_portal/const/image_strings.dart';
import 'package:ms_ess_portal/screens/peripheral/controller/peripheral_controller.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:ms_ess_portal/style/text_style.dart';
import 'package:shimmer/shimmer.dart';
class PeripheralScreen extends GetView<AssetController> {
  PeripheralScreen({super.key});
  final AssetController assetController = Get.put(AssetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Center(child: Text("Peripheral", style: AppTextStyles.kPrimaryTextStyle)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (assetController.isLoading.value) {
          return Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highLightColor,
            child: loadSke(),
          );
        } else if (assetController.assets.isEmpty) {
          return Center(child: Image.asset(noData1)); // Display no data image
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 700,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: assetController.assets.length,
                    itemBuilder: (context, index) {
                      var asset = assetController.assets[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200], // Optional background color
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: asset.images.length,
                                        itemBuilder: (context, imgIndex) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Container(
                                                width: 150,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: AppColors.white100,
                                                  ),
                                                ),
                                                child: Image.network(
                                                  asset.images[imgIndex],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Divider(color: AppColors.white100),
                                    SizedBox(height: 5),
                                    Text(
                                      'Category : ${asset.name} | Model : ${asset.model}',
                                      style: AppTextStyles.kSmall12SemiBoldTextStyle,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Serial No : ${asset.serial}',
                                      style: AppTextStyles.kSmall12RegularTextStyle.copyWith(
                                        color: AppColors.white60,
                                      ),
                                    ),
                                    SizedBox(height: 9),
                                    Text('Description', style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                    Text(
                                      "${asset.description}",
                                      style: AppTextStyles.kSmall12RegularTextStyle,
                                    ),
                                    SizedBox(height: 7),
                                    Text('Alloted On : ', style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                    SizedBox(height: 3),
                                    Text(
                                      asset.allotedDt,
                                      style: AppTextStyles.kSmall12RegularTextStyle,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Total Assets: ${index + 1}/${assetController.assets.length}",
                                      style: AppTextStyles.kSmall12RegularTextStyle.copyWith(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
