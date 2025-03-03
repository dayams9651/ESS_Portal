// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart'; // For PDF Preview
// import 'package:document_viewer/document_viewer.dart'; // For document file (doc, docx, etc.)
// import 'dart:io'; // For File handling
//
// class FilePreviewScreen extends StatelessWidget {
//   final String filePath;
//   final String fileName;
//
//   FilePreviewScreen({required this.filePath, required this.fileName});
//
//   @override
//   Widget build(BuildContext context) {
//     String fileExtension = filePath.split('.').last.toLowerCase();
//     if (fileExtension == 'pdf') {
//       return Scaffold(
//         appBar: AppBar(title: Text(fileName)),
//         body: PDFView(
//           filePath: filePath,
//         ),
//       );
//     } else if (['jpg', 'jpeg', 'png'].contains(fileExtension)) {
//       return Scaffold(
//         appBar: AppBar(title: Text(fileName)),
//         body: Image.file(File(filePath)), // Display the image
//       );
//     } else if (['doc', 'docx', 'ppt', 'pptx', 'xls', 'xlsx'].contains(fileExtension)) {
//       return Scaffold(
//         appBar: AppBar(title: Text(fileName)),
//         body: DocumentViewer(
//           filePath: filePath, // Use document_viewer to show doc/ppt/xls files
//         ),
//       );
//     } else {
//       return Scaffold(
//         appBar: AppBar(title: Text(fileName)),
//         body: Center(child: Text('Cannot preview this file type')),
//       );
//     }
//   }
// }
