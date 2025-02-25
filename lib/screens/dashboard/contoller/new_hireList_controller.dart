import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/const_api.dart';
import '../model/new_hireList_model.dart';

class NewHireListController extends GetxController {
  var isLoading = true.obs;
  var newHireList = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNewHireListData();
  }

  void fetchNewHireListData() async {
    isLoading(true);
    try {
      NewHireListModel? response = await ApiServices().fetchNewHireListData();
      if (response != null) {
        newHireList.value = response.data ?? [];
      } else {
        debugPrint('Error: No response data');
      }
    } finally {
      isLoading(false);
    }
  }
}
