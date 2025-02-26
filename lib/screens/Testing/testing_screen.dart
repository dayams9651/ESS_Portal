// // profile_view.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ms_ess_portal/screens/Testing/testing_controller.dart';
// import 'package:ms_ess_portal/screens/dashboard/contoller/profile_view_controller.dart';
//
// class ProfileView extends StatefulWidget {
//   @override
//   _ProfileViewState createState() => _ProfileViewState();
// }
//
// class _ProfileViewState extends State<ProfileView> {
//   final ProfileViewController controller = Get.put(ProfileViewController());
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch the profile data when the view is initialized
//     controller.fetchProfileData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Profile View"),
//       ),
//       body: Obx(() {
//         // Observe the loading and error states
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator()); // Show loading
//         }
//
//         if (controller.isError.value) {
//           return Center(child: Text("Error fetching profile data"));
//         }
//
//         final profile = controller.profile.value;
//
//         if (profile != null) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(profile.photo),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   profile.name?? "",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Employee Code: ${profile.code}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return Center(child: Text("No data available"));
//         }
//       }),
//     );
//   }
// }
//
