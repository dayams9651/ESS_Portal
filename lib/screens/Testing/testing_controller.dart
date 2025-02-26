//
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:ms_ess_portal/screens/Testing/testing_model.dart';
// import 'dart:convert';
//
// import '../../const/api_url.dart';
//
// class ProfileViewController extends GetxController {
//   var profile = Rxn<ProfileViewModel>();
//   var isLoading = true.obs;
//   var isError = false.obs;
//   var errorMessage = ''.obs;
//   final box = GetStorage();
//
//   Future<void> fetchProfileData() async {
//     try {
//       String? token = box.read('token');
//       if (token == null || token.isEmpty) {
//         errorMessage.value = 'Token not found. Please log in first.';
//         debugPrint("Token not found");
//         throw Exception('Token not found');
//       }
//       isLoading(true);
//       debugPrint("Making API request...");
//       final response = await http.get(
//         Uri.parse(apiProfileView),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );
//
//       debugPrint("Response Status: ${response.statusCode}");
//       debugPrint("Response Body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body)['data'][0];
//         profile.value = ProfileViewModel.fromJson(data);
//         isError(false);
//       } else {
//         isError(true);
//         errorMessage.value = 'Failed to fetch profile data.';
//       }
//     } catch (e) {
//       debugPrint("Error: $e");
//       isError(true); // Error caught
//       errorMessage.value = e.toString();
//     } finally {
//       isLoading(false);
//     }
//   }
// }
//
