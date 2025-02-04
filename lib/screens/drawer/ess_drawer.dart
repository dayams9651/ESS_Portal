// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:ms_ess_potal/screens/drawer/controller/essDrawer_controller.dart';
// import '../../common/widget/const_text_with_styles.dart';
// import '../../const/const_height.dart';
// import '../../const/const_width.dart';
// import '../../style/color.dart';
//
// class EssDrawer extends GetView<EssDrawerController>{
//   const EssDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         color: AppColors.white,
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             _buildDrawerHeader(),
//             _buildDrawerItem(
//               icon: Icons.meeting_room_sharp,
//               text: 'Appointment List',
//               onTap: () {
//                 // Get.toNamed(ApplicationPages.lawyerAppointmentList);
//               },
//             ),
//             _buildDrawerItem(
//                 icon: Icons.receipt_long,
//                 text: 'Client Transactions',
//                 onTap: () {},
//                 subItems: [
//                   _buildDrawerSubItem('Direct Transactions', onTap: () {
//                     // Get.toNamed(ApplicationPages.clientTransaction);
//                   }, icons: Icons.category),
//                   _buildDrawerSubItem('Appointment Transactions',
//                       onTap: () {
//                         // Get.toNamed(
//                             // ApplicationPages.lawyerAppointmentTransPage);
//                       }, icons: Icons.category),
//                   _buildDrawerSubItem('Payment Request', onTap: () {
//                     // Get.toNamed(ApplicationPages.lawyerPaymentRequest);
//                   }, icons: Icons.category_sharp),
//                 ]),
//             _buildDrawerItem(
//               icon: Icons.paid,
//               text: 'My Transaction',
//               onTap: () {
//                 // Get.toNamed(ApplicationPages.lawyerMyTransaction);
//               },
//             ),
//             _buildDrawerItem(
//               icon: Icons.subscriptions_rounded,
//               text: 'Plans',
//               onTap: () {
//                 // Get.toNamed(ApplicationPages.plans);
//               },
//             ),
//             _buildDrawerItem(
//               icon: Icons.request_page,
//               text: 'Payment Request',
//               onTap: () {
//                 // Get.toNamed(ApplicationPages.paymentRequestPageOnly);
//               },
//             ),
//
//             // constDivider(),
//             _buildDrawerItem(
//               icon: Icons.contacts_outlined,
//               text: 'Address',
//               onTap: () {
//                 // Get.to(LawyerAddAddress());
//                 // Get.toNamed(ApplicationPages.lawyerAllAddress);
//               },
//             ),
//             _buildDrawerItem(
//               icon: Icons.logout,
//               text: 'Logout',
//               onTap: () {
//                 // askDialogForDelete(
//                 //     context: context,
//                 //     title: "Do you want to logout?",
//                 //     doneText: "Yes",
//                 //     onPressedDone: () {
//                 //       UserDataService.removeUser().then((_) {
//                 //         Get.offAllNamed(ApplicationPages.signUpPage);
//                 //       });
//                 //
//                 //       Navigator.pop(context);
//                 //     }
//                 //     );
//                 // Get.toNamed(ApplicationPages.settingPage);
//                 // Handle settings navigation
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// Widget _buildDrawerHeader() {
//   return SizedBox(
//     height: 0.35.sh,
//     child: DrawerHeader(
//       // decoration: const BoxDecoration(gradient: primaryGradientColor),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Obx(() =>  Column(
//               children: [
//                 CircleAvatar(
//                   radius: w52,
//                   child: CircleAvatar(
//                     backgroundColor: Colors.grey,
//                     radius: w30,
//                     // backgroundImage: NetworkImage(
//                     //     controller.profileData.value.data?.image ?? ""),
//                   ),
//                 ),
//                 // SizedBox(height: 10.w),
//                 // const10TextBold(
//                 //     "${controller.profileData.value.data?.name.toString().toUpperCase()}"),
//                 // const10TextBold(
//                 //     "${controller.profileData.value.data?.email}"),
//                 // Positioned(
//                 //     bottom: h10,
//                 //     right: -w1,
//                 //
//                 //     child: IconButton.filledTonal(
//                 //
//                 //
//                 //
//                 //         onPressed: (){
//                 //           Get.toNamed(ApplicationPages.myBottomBar,  arguments: {'initialIndex': 3}, );
//                 //         }, icon: const Icon(Icons.edit_outlined,color: AppColors.info80,))),
//               ],
//             )
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
//
//
// Widget _buildDrawerItem({
//   required IconData icon,
//   required String text,
//   VoidCallback? onTap,
//   List<Widget>? subItems,
// }) {
//   if (subItems != null && subItems.isNotEmpty) {
//     return ExpansionTile(
//       leading: Container(
//           padding: EdgeInsets.all(w8),
//           decoration: const BoxDecoration(
//               shape: BoxShape.circle, color: AppColors.info80
//             // gradient: primaryGradientColor
//           ),
//           child: Icon(
//             icon,
//             color: AppColors.white,
//           )),
//       title: Text(text),
//       children: subItems,
//     );
//   } else {
//     return ListTile(
//         leading: Container(
//             padding: EdgeInsets.all(w8),
//             decoration: const BoxDecoration(
//                 shape: BoxShape.circle, color: AppColors.info80
//               // gradient: primaryGradientColor
//             ),
//             child: Icon(
//               icon,
//               color: AppColors.white,
//             )),
//         title: Text(text),
//         onTap: onTap);
//   }
// }
//
// Widget _buildDrawerSubItem(String text,
//     {VoidCallback? onTap, IconData? icons}) {
//   return ListTile(
//     leading: Container(
//       padding: EdgeInsets.all(w8),
//       decoration: const BoxDecoration(
//         shape: BoxShape.circle,
//         color: AppColors.info80,
//         // gradient: primaryGradientColor
//       ),
//       // radius: isDesktop() ? w25 : w15,
//       // backgroundColor: AppColors.primary1,
//       child: Icon(
//         icons ?? Icons.list,
//         size: w10,
//         color: AppColors.white,
//       ),
//     ),
//     title: const8Text(text),
//     onTap: onTap,
//     trailing: Icon(
//       Icons.arrow_forward_ios_rounded,
//       color: AppColors.white70,
//       size: w10,
//     ),
//   ).paddingSymmetric(vertical: h2);
// }
