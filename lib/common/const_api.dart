import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart'; // Import GetStorage
import 'package:ms_ess_potal/screens/dashboard/model/workanniversary_model.dart';
import '../const/api_url.dart';
import '../screens/dashboard/model/home_model.dart';
import '../screens/dashboard/model/new_hireList_model.dart';

class ApiServices {
  final box = GetStorage();
  Future<BirthdayBashModel?> fetchBirthdayData() async {
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.get(
        Uri.parse(birthdayBashApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      debugPrint('BirthdayResponse : ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return BirthdayBashModel.fromJson(data);
      } else {
        throw Exception('Failed to load birthday data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  Future<NewHireListModel?> fetchNewHireListData() async {
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.get(
        Uri.parse(newHireListApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      debugPrint('New Hire List Response : ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return NewHireListModel.fromJson(data);
      } else {
        throw Exception('Failed to load New Hire List data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  Future<WorkAnniversaryModel?> fetchWAData() async {
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.get(
        Uri.parse(workAnnApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      debugPrint('Work Anniversary Response : ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return WorkAnniversaryModel.fromJson(data);
      } else {
        throw Exception('Failed to load New Hire List data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
}
