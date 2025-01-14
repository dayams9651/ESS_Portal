import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_potal/screens/peripheral/controller/peripheral_controller.dart';

import '../../../common/widget/const_text_with_styles.dart';
import '../../../const/image_strings.dart';
import '../../../style/color.dart';
import '../../../style/text_style.dart';

class PeripheralScreen extends GetView<PeripheralController> {
  PeripheralScreen({super.key});

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
       body: SingleChildScrollView(
         child: Column(
           children: [
             SizedBox(
               height: 550,
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
                             width: 400,
                             decoration: BoxDecoration(
                               // color: Colors.blueAccent,
                                 borderRadius: BorderRadius.circular(8),
                                 border: Border.all(color: AppColors.white70, width: 2)
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(2.0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   SizedBox(
                                     height: 200,
                                     child: ListView.builder(
                                       scrollDirection: Axis.horizontal, // Scroll horizontally
                                       itemCount: 3,
                                       // itemCount: items.length,
                                       itemBuilder: (context, index) {
                                         return Padding(
                                           padding: const EdgeInsets.symmetric(horizontal: 1.0),
                                           child: ClipRRect(
                                             child: Padding(
                                               padding: const EdgeInsets.all(2.0),
                                               child: Container(
                                                   decoration: BoxDecoration(
                                                     // color: Colors.blueAccent,
                                                       borderRadius: BorderRadius.circular(5),
                                                       // border: Border.all(color: AppColors.white60,)
                                                       border: Border.symmetric(vertical: BorderSide(color: AppColors.white100))
                                                   ),
                                                   child: Padding(
                                                     padding: const EdgeInsets.all(1.0),
                                                     child: Column(
                                                       children: [
                                                         Image.asset(testing,
                                                         height: 190,)
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
                                   Divider(color: AppColors.white100,),
                                   SizedBox(height: 5),
                                   Text('Category : Laptop  | Model : VSVE59B',
                                       style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                   SizedBox(height: 5),
                                   Text('Serial No : JR23SN2', style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.white60)),
                                   SizedBox(height: 9),
                                   Text('Description',
                                       style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                   Text("Laptop Dell 5590 Core i5/ 7th Generation/ 8 GB RAM/ 256 GB SSD with 15.6” Screen Warranty 1 years",
                                       style: AppTextStyles.kSmall12RegularTextStyle),
                                   SizedBox(height: 7),
                                   Text('Alloted On : ',
                                       style: AppTextStyles.kSmall12SemiBoldTextStyle),
                                   SizedBox(height: 3),
                                   Text("Dec 20, 2016 | total age from date of purchase: (1 years, 9 months & 18 days)",
                                       style: AppTextStyles.kSmall12RegularTextStyle),
                                   SizedBox(height: 10,),
                                   Text("Total Assets : ${index}/4", style: AppTextStyles.kSmall12RegularTextStyle.copyWith(color: AppColors.primaryColor),)
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
           ],
         ),
       ),
     );
  }
}