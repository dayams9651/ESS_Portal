// import 'dart:typed_data';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
//
// class ReportController extends GetxController {
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//   var pdfPath = ''.obs;
//   final String apiUrl = 'https://esstest.mscorpres.net/attendance/download';
//   final Map<String, dynamic> requestBody = {'period': '2025-01'};
//   final box = GetStorage();
//   Future<void> fetchPDF() async {
//     try {
//       isLoading(true);
//       String? token = box.read('token');
//       if (token == null || token.isEmpty) {
//         throw Exception('Token not found. Please log in first.');
//       }
//
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: requestBody,
//       );
//
//
//
//       if (response.statusCode == 200) {
//         Uint8List bufferData = response.bodyBytes;
//         debugPrint(response.body);
//         final directory = await getApplicationDocumentsDirectory();
//         final filePath = '${directory.path}/attendance_report.pdf';
//         final file = File(filePath);
//         await file.writeAsBytes(bufferData);
//         pdfPath.value = filePath;
//         errorMessage.value = '';
//       } else {
//         errorMessage.value = 'Failed to load PDF. Status code: ${response.statusCode}';
//       }
//     } catch (e) {
//       errorMessage.value = 'Error: $e';
//     } finally {
//       isLoading(false);
//     }
//   }
// }


// controller/user_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'testing_model.dart';

class UserController extends GetxController {
  var user = User(
    token: '',
    userId: '',
    userName: '',
    designation: '',
    photo: '',
  ).obs;

  var isLoading = false.obs;

  // API call for login
  final box = GetStorage();
  Future<void> loginUser(String username, String password) async {
    isLoading(true); // Start loading

    // Define the URL and headers
    String? token = box.read('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token not found. Please log in first.');
    }

    final url = Uri.parse('https://esstest.mscorpres.net/auth/login');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'};

    // Prepare the body with login credentials (for example, user and password)
    final body = json.encode({
      'username': username,
      'password': password,
    });

    try {
      // Make the POST request
      final response = await http.post(url, headers: headers, body: body);

      // If the request is successful
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          var userData = User.fromJson(data);
          setUser(userData); // Update the user data
        } else {
          // Handle login failure (e.g., invalid credentials)
          Get.snackbar("Login Failed", data['message']);
        }
      } else {
        // Handle request error (e.g., 500 Internal Server Error)
        Get.snackbar("Error", "Failed to load data");
      }
    } catch (e) {
      // Handle any exceptions (e.g., no internet)
      Get.snackbar("Error", "Something went wrong. Please try again.");
    } finally {
      isLoading(false); // Stop loading
    }
  }

  void setUser(User newUser) {
    user.value = newUser;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
