import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ms_ess_portal/common/widget/snackbar_helper.dart';
import 'package:ms_ess_portal/const/api_url.dart';
import 'dart:convert';
import 'package:ms_ess_portal/screens/selfService/models/payslip_model.dart';
import 'package:ms_ess_portal/style/color.dart';

class PayslipController extends GetxController {
  var payslip = Rxn<Payslip>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final box = GetStorage();

  Future<void> fetchPayslipData(String period) async {
    isLoading(true);
    errorMessage.value = '';

    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found. Please log in first.';
        throw Exception('Token not found.');
      }
      final response = await http.post(
        Uri.parse(apiPayslip),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"period": period}),
      );

      if (response.statusCode == 200) {
        debugPrint("Payslip response : ${response.body}");
        final data = jsonDecode(response.body);
        if (data['code'] == 200) {
          if (data['data'] != null) {
            payslip.value = Payslip.fromJson(data['data']);
          } else {
            showCustomSnackbar("Failed", data['message']['msg']);
            errorMessage.value = 'No data available for this period.';
          }
        } else {
          errorMessage.value = 'Failed to load payslip data: ${data['message']}';
          showCustomSnackbar("Failed", data['message']['msg'], backgroundColor: AppColors.error20);
          debugPrint('Failed to load payslip data: ${data['message']}');
        }
      } else {
        final data = jsonDecode(response.body);
        String msg = data['message'];
        showCustomSnackbar("Failed", msg);
        errorMessage.value = 'Failed to load payslip data: ${response.statusCode}';
        debugPrint('Failed to load payslip data: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value = 'Error occurred while fetching payslip data: $e';
      debugPrint('Error occurred while fetching payslip data: $e');
    } finally {
      isLoading(false);
    }
  }
}


