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
      if (response != null && response.success == true) {
        birthdayList.value = response.data ?? [];
      } else {
        debugPrint('Error: ${response?.status}');
      }
    } finally {
      isLoading(false);
    }
  }

}



