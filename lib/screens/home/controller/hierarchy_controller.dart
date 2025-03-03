import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/const/api_url.dart';
import 'dart:convert';

import 'package:ms_ess_portal/screens/home/model/hierarchy_model.dart';


class EmployeeController extends GetxController {
  var isLoading = true.obs;
  var employeeList = <Employee>[].obs;

  @override
  void onInit() {
    fetchEmployeeData();
    fetchEmployeeData;
    super.onInit();
  }

  final box = GetStorage();
  Future<void> fetchEmployeeData() async {
    try {
      isLoading(true);
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.get(
        Uri.parse(apiHierarchy),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        debugPrint("Hierarchy Api Response ${response.body}");
        var children = jsonResponse['children'] as List;
        employeeList.assignAll(
            children.map((item) => Employee.fromJson(item)).toList());
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}





