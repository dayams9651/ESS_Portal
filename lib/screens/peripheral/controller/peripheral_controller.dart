import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:ms_ess_portal/const/api_url.dart';
import 'package:ms_ess_portal/screens/peripheral/model/peripheral_model.dart';

class AssetController extends GetxController {
  var assets = <AssetModel>[].obs;
  var isLoading = true.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchAssets();
  }

  Future<void> fetchAssets() async {
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }

      final response = await http.post(
        Uri.parse(apiPeripheral),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];
        debugPrint("Peripheral API Response Data: ${response.body}");
        assets.value = List<AssetModel>.from(
          data.map((item) {
            return AssetModel.fromJson({
              ...item,
              'category': item['category'] ?? item['catergory']
            });
          }),
        );
      } else {
        throw Exception('Failed to load assets');
      }
    } catch (e) {
      debugPrint('Error fetching assets: $e');
    } finally {
      isLoading(false);
    }
  }
}
