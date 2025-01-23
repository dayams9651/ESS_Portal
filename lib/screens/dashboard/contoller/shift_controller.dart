import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_potal/const/api_url.dart';
import 'dart:convert';
import '../model/shift_model.dart';

class ShiftController extends GetxController {
  var isLoading = true.obs;
  var shiftModel = Rxn<ShiftModel>();
  final box = GetStorage();

  Future<void> fetchShiftData() async {
    String? token = box.read('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token not found. Please log in first.');
    }
    try {
      final response = await http.post(
        Uri.parse(shiftApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      debugPrint("Daya ");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['code'] == 200) {
          shiftModel.value = ShiftModel.fromJson(data['result']);
        } else {
          Get.snackbar('Error', 'Failed to load shift data: ${data['message']}');
        }
      }
      // else {
      //   Get.snackbar('Error', 'Failed to load shift data, status code: ${response.statusCode}');
      // }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
