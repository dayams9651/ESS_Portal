import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/const_api.dart';
import '../model/workanniversary_model.dart';

class WorkAnniversaryController extends GetxController {
  var isLoading = true.obs;
  var wAList = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNewHireListData();
  }

  void fetchNewHireListData() async {
    isLoading(true);
    try {
      WorkAnniversaryModel? response = await ApiServices().fetchWAData();
      if (response != null) {
        wAList.value = response.data ?? [];
      } else {
        debugPrint('Error: No response data');
      }
    } finally {
      isLoading(false);
    }
  }
}
