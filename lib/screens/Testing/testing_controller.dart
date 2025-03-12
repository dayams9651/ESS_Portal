import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class ReportController extends GetxController {
  var selectedPeriod = '2025-01'.obs;
  final box = GetStorage();
  var isLoading = false.obs;

  Future<void> downloadReport() async {
    try {
      isLoading.value = true;

      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }

      var url = Uri.parse('https://login.mscorpres.online/attendance/download');
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      var payload = {'period': selectedPeriod.value};

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        Uint8List fileBytes = response.bodyBytes;
        String fileName = 'report_${selectedPeriod.value}.pdf';
        await saveFile(fileBytes, fileName);
        Get.snackbar('Success', 'Report downloaded and saved successfully!');
        openFile(fileName); // Open the file after saving it
      } else {
        debugPrint('Failed to download report. Status Code: ${response.statusCode}');
        Get.snackbar('Error', 'Failed to download report. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveFile(Uint8List fileBytes, String fileName) async {
    try {
      // Request storage permission if not already granted
      PermissionStatus status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception('Storage permission not granted.');
      }

      // Get the downloads directory
      final directory = await getDownloadsDirectory();
      if (directory != null) {
        final file = File('${directory.path}/$fileName');
        await file.writeAsBytes(fileBytes);
        debugPrint('File saved to ${file.path}');
      } else {
        throw Exception('Could not access downloads directory.');
      }
    } catch (e) {
      debugPrint("Error saving file: $e");
      throw Exception('Failed to save file: $e');
    }
  }

  // Function to open the file after saving
  Future<void> openFile(String fileName) async {
    try {
      final directory = await getDownloadsDirectory();
      if (directory != null) {
        final filePath = '${directory.path}/$fileName';
        final result = await OpenFile.open(filePath);
        debugPrint('File open result: $result');
      } else {
        debugPrint('Could not access downloads directory.');
      }
    } catch (e) {
      debugPrint("Error opening file: $e");
      throw Exception('Failed to open file: $e');
    }
  }
}
