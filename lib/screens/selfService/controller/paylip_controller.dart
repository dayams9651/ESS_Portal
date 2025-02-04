import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'dart:io';
import 'package:path_provider/path_provider.dart'; // For file storage
import 'package:permission_handler/permission_handler.dart'; // For permission handling
import 'package:pdf/widgets.dart' as pw; // PDF widget package

class PayslipController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var formattedDate = "".obs;
  var isFileSaved = false.obs;

  // Method to update the selected date
  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  // Method to generate the formatted date
  void generateDate() {
    formattedDate.value = DateFormat('yyyy-MM-dd').format(selectedDate.value);
  }

  // Method to generate PDF and save to local storage
  Future<void> downloadPdf() async {
    // Check permission for storage access
    if (await Permission.storage.request().isGranted) {
      try {
        // Create a PDF document
        final pdf = pw.Document();

        // Add a page to the PDF
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Text(
                  'Generated Date: ${formattedDate.value}', // Date text
                  style: const pw.TextStyle(fontSize: 24),
                ),
              ); // Center the text on the page
            },
          ),
        );

        // Get the path to save the PDF file
        final directory = await getExternalStorageDirectory();
        if (directory != null) {
          final path = '${directory.path}/payslip.pdf';

          // Write the PDF file to the path
          final file = File(path);
          await file.writeAsBytes(await pdf.save());

          // Update the state to reflect the file is saved
          isFileSaved.value = true;

          // Optionally, show a success message
          debugPrint("PDF saved at: $path");
        }
      } catch (e) {
        debugPrint("Error generating PDF: $e");
      }
    } else {
      // Handle permission denial
      debugPrint('Storage permission denied');
    }
  }
}
