import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../const/api_url.dart';
import '../model/announcement_model.dart';

class AnnouncementController extends GetxController {
  var announcements = <Announcement>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAnnouncements();
    fetchAnnouncements;
  }
  final box = GetStorage();

  Future<void> fetchAnnouncements() async {
    try {
      isLoading(true);
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.post(
        Uri.parse(announcementApi),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        debugPrint('Announcement Api Response : ${response.body}');
        var fetchedAnnouncements = (data['data'] as List)
            .map((item) => Announcement.fromJson(item))
            .toList();
        announcements.assignAll(fetchedAnnouncements);
      } else {
        debugPrint('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
