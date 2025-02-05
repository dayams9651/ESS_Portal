import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ms_ess_portal/common/const_api.dart';
import 'package:ms_ess_portal/screens/selfService/models/payslip_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;

class PayslipController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var formattedDate = "".obs;
  var isFileSaved = false.obs;
  var payslip = Payslip(success: false, status: "", data: PayslipData(basic: [], earing: [], deduction: [], total: []))
      .obs;
  var isLoading = true.obs;
  final ApiServices payslipService = ApiServices();
  @override
  void onInit() {
    super.onInit();
  }
  // Method to update the selected date
  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void generateDate() {
    formattedDate.value = DateFormat('yyyy-MM-dd').format(selectedDate.value);
  }

  void fetchPayslip(int year, int month) async {
    try {
      isLoading(true);
      Payslip data = await payslipService.fetchPayslipData();
      payslip.value = data;
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading(false);
    }
  }
  Future<void> downloadPdf() async {
    if (await Permission.storage.request().isGranted) {
      try {
        final pdf = pw.Document();
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Text(
                  'Generated Date: ${formattedDate.value}', // Date text
                  style: const pw.TextStyle(fontSize: 24),
                ),
              );
            },
          ),
        );
        final directory = await getExternalStorageDirectory();
        if (directory != null) {
          final path = '${directory.path}/payslip.pdf';
          final file = File(path);
          await file.writeAsBytes(await pdf.save());
          isFileSaved.value = true;
          debugPrint("PDF saved at: $path");
        }
      } catch (e) {
        debugPrint("Error generating PDF: $e");
      }
    } else {
      debugPrint('Storage permission denied');
    }
  }
}

