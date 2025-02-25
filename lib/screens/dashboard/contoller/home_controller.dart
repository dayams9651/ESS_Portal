import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/const_api.dart';
import '../model/home_model.dart';
class BirthdayBashController extends GetxController {
  var isLoading = true.obs;
  var birthdayList = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBirthdayData();
  }

  void fetchBirthdayData() async {
    isLoading(true);
    try {
      BirthdayBashModel? response = await ApiServices().fetchBirthdayData();
      birthdayList.value = response?.data ?? [];
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}


