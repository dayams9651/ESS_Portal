import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/const/api_url.dart';

class EmployeeCopyMailController extends GetxController {
  var employeeList = <String>[].obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  final box = GetStorage();
  Future<void> fetchEmployeeSuggestions(String empCode) async {
    if (empCode.isEmpty) {
      employeeList.clear();
      return;
    }
    isLoading.value = true;
    try {
      isLoading.value = true;
      errorMessage.value = '';
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.post(
        Uri.parse(apiCopyMail),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "emp_code": empCode
        }),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        debugPrint(response.body);
        employeeList.clear();
        employeeList.addAll(data.map((e) => e['text'] as String).toList());
      } else {
        employeeList.clear();
        debugPrint("else ${response.body}");
      }
    } catch (e) {
      employeeList.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
