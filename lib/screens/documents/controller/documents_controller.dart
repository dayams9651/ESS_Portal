
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/const/api_url.dart';
import 'package:ms_ess_portal/screens/documents/models/document_sop_model.dart';
import 'dart:convert';


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
      // final response = await http.get(Uri.parse('https://esstest.mscorpres.net/sop'),
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
}
