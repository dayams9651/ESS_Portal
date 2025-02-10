import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ReportController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var pdfPath = ''.obs;
  final String apiUrl = 'https://esstest.mscorpres.net/attendance/download';
  final Map<String, dynamic> requestBody = {'period': '2025-01'};
  final box = GetStorage();
  Future<void> fetchPDF() async {
    try {
      isLoading(true);
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );



      if (response.statusCode == 200) {
        Uint8List bufferData = response.bodyBytes;
        debugPrint(response.body);
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/attendance_report.pdf';
        final file = File(filePath);
        await file.writeAsBytes(bufferData);
        pdfPath.value = filePath;
        errorMessage.value = '';
      } else {
        errorMessage.value = 'Failed to load PDF. Status code: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}
