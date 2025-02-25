// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:get/get.dart';
// import 'package:ms_ess_portal/screens/Testing/testing_controller.dart';
//
// class ReportScreen extends StatelessWidget {
//   final ReportController controller = Get.put(ReportController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attendance PDF Viewer'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Obx(() {
//           // Check if loading
//           if (controller.isLoading.value) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           // Check if there's an error
//           if (controller.errorMessage.isNotEmpty) {
//             return Center(child: Text(controller.errorMessage.value));
//           }
//
//           // Check if PDF path is available
//           if (controller.pdfPath.value.isNotEmpty) {
//             return PDFViewPage(filePath: controller.pdfPath.value);
//           }
//
//           // Default UI: Show a button to fetch the PDF
//           return Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 controller.fetchPDF();
//               },
//               child: Text('Download Attendance PDF'),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
//
// class PDFViewPage extends StatelessWidget {
//   final String filePath;
//
//   PDFViewPage({required this.filePath});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('PDF Viewer')),
//       body: PDFView(
//         filePath: filePath,  // Path to the saved PDF file
//       ),
//     );
//   }
// }



// ui/user_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testing_controller.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the controller
    final UserController userController = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Center(
        child: Obx(
              () {
            // Checking if user data is available
            if (userController.user.value.userName.isNotEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userController.user.value.photo),
                  ),
                  SizedBox(height: 20),
                  Text(
                    userController.user.value.userName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
