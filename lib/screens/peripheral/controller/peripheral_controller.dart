
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_potal/const/api_url.dart';
import 'package:ms_ess_potal/screens/peripheral/model/peripheral_model.dart';

class AssetController extends GetxController {
  var assets = <AssetModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAssets();
  }
  final box = GetStorage();
  Future<void> fetchAssets() async {
    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        throw Exception('Token not found. Please log in first.');
      }
      final response = await http.get(Uri.parse(apiPeripheral),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];
        debugPrint("Peripheral Api Response Data : ${response.body}");
        assets.value = List<AssetModel>.from(data.map((item) => AssetModel.fromJson(item)));
      } else {
        throw Exception('Failed to load assets');
      }
    } finally {
      isLoading(false);
    }
  }
}
