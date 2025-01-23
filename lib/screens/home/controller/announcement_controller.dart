import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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
  }

  Future<void> fetchAnnouncements() async {
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse(announcementApi),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        debugPrint('Announcement Api Response : $data');  // Print the full response data in the terminal
        var fetchedAnnouncements = (data['data'] as List)
            .map((item) => Announcement.fromJson(item))
            .toList();
        announcements.assignAll(fetchedAnnouncements);
      } else {
        debugPrint('Failed to load data: ${response.statusCode}');  // Print error code if status code isn't 200
      }
    } catch (e) {
      debugPrint('Error: $e');  // Catch and print any error that occurs during the request
    } finally {
      isLoading(false);
    }
  }
}
