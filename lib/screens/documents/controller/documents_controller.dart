
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/const/api_url.dart';
import 'package:ms_ess_portal/screens/documents/models/document_sop_model.dart';
import 'dart:convert';

import 'package:ms_ess_portal/style/color.dart';


class SOPController extends GetxController {
  RxList<SOPModel> sopList = <SOPModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSOPData();
  }
  final box = GetStorage();

  Future<void> fetchSOPData() async {
    String? token = box.read('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token not found. Please log in first.');
    }
    try {
      isLoading(true);
      final response = await http.post(Uri.parse(apiSop),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint('Document Api response : ${response.body}');
        final List<SOPModel> sopData = (data['data'] as List)
            .map((sop) => SOPModel.fromJson(sop))
            .toList();
        sopList.assignAll(sopData);
        hasError(false);
      } else {
        hasError(true);
      }
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }

  Icon getFileTypeIcon(String filePath) {
    String fileExtension = filePath.split('.').last.toLowerCase();
    switch (fileExtension) {
      case 'pdf':
        return Icon(Icons.picture_as_pdf, color: AppColors.error80, size: 30,);
      case 'doc':
      case 'docx':
        return Icon(Icons.description);
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icon(Icons.image_outlined, size: 30, color: AppColors.warning40,);
      case 'xls':
      case 'xlsx':
        return Icon(Icons.table_chart, size: 30,);
      case 'txt':
        return Icon(Icons.text_fields, size: 30,);
      default:
        return Icon(Icons.insert_drive_file, size: 30,);
    }
  }
}
