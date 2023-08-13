// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frametutor/consts/fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';

import 'package:dio/dio.dart';

import 'models/user/user_model.dart';

class PDFViewerScreen extends StatefulWidget {
  final User user;

  const PDFViewerScreen({required this.user});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String _pdfPath = '';

  @override
  void initState() {
    super.initState();
    _downloadAndOpenPDF();
  }

  Future<String> downloadAndSavePDF(String pdfUrl) async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final pdfPath = '${appDocDir.path}/book.pdf';

      // Check if the file already exists
      if (await File(pdfPath).exists()) {
        print('PDF already downloaded: $pdfPath');
        return pdfPath;
      }

      Dio dio = Dio();
      await dio.download(pdfUrl, pdfPath);

      print('PDF downloaded: $pdfPath');

      return pdfPath;
    } catch (e) {
      print('Error downloading PDF: $e');
      return '';
    }
  }

  Future<void> _downloadAndOpenPDF() async {
    final pdfPath =
        await downloadAndSavePDF(widget.user.enrolledCourse!.ebook!.url!);
    if (pdfPath.isNotEmpty) {
      setState(() {
        _pdfPath = pdfPath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Ebook',
          style: appBartitleStyleB,
        ),
      ),
      body: Center(
        child: _pdfPath.isNotEmpty
            ? SfPdfViewer.file(File(_pdfPath))
            : CircularProgressIndicator(),
      ),
    );
  }
}
