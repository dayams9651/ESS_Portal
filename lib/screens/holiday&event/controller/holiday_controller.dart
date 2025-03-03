
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/const/api_url.dart';
import 'package:ms_ess_portal/screens/holiday&event/models/holiday_model.dart';


class EventController extends GetxController {
  var events = <EventModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchEvents;
  }

  Future<void> fetchEvents(int year, int month) async {
    String? token = box.read('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token not found. Please log in first.');
    }

    try {
      isLoading(true);
      final startDate = "$year-${month.toString().padLeft(2, '0')}-01";
      final endDate = "$year-${month.toString().padLeft(2, '0')}-28";
      final event = "$apiHolidayEvent/?start=$startDate&end=$endDate";
          // 'https://essv2.mscorpres.net/event/?start=$startDate&end=$endDate';

      final response = await http.post(Uri.parse(event),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          });
debugPrint("datatgd");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var eventsData = data['data']['events'] as List;
        events.value = eventsData.map((e) => EventModel.fromJson(e)).toList();
        debugPrint("Event Api response : ${response.body}");
      } else {
        errorMessage('Failed to load events');
      }
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}

