import 'dart:typed_data';
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:frametutor/consts/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../../../models/user/user_model.dart';

class EpubReaderScreen extends StatefulWidget {
  final User user;

  const EpubReaderScreen({required this.user});

  @override
  _EpubReaderScreenState createState() => _EpubReaderScreenState();
}

class _EpubReaderScreenState extends State<EpubReaderScreen> {
  EpubDocument? _epubDocument;
  late EpubBook _epubBook;

  EpubController? _epubController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEpubBook();
  }

  Future<Uint8List> downloadEpubBook() async {
    final response =
        await http.get(Uri.parse(widget.user.enrolledCourse!.ebook!.url!));
    if (response.statusCode == 200) {
      print(response.statusCode);
      return response.bodyBytes;
    } else {
      throw Exception('Failed to download EPUB book');
    }
  }

  Future<File> saveEpubLocally(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/book.epub');
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<void> _loadEpubBook() async {
    setState(() {
      _isLoading = true;
    });

    try {
      File epubFile = await _getLocalEpubFile();

      if (!epubFile.existsSync()) {
        print('notdownloaded');

        Uint8List bytes = await downloadEpubBook();

        await saveEpubLocally(bytes);
      }

      epubFile = await _getLocalEpubFile();
      print('here');
      print(epubFile);
      _epubBook = await EpubDocument.openFile(epubFile);
      setState(() {
        _epubController = EpubController(document: Future.value(_epubBook));
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle any errors
      print(e);
    }
  }

  Future<File> _getLocalEpubFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/book.epub');
  }

  @override
  Widget build(BuildContext context) {
    if (_epubController == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryClr,
          title: Text('Loading EPUB...'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryClr,
        title: EpubViewActualChapter(
          controller: _epubController!,
          builder: (chapterValue) => Text(
            'Chapter: ' +
                (chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ??
                    ''),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      drawer: Drawer(
        child: EpubViewTableOfContents(
          controller: _epubController!,
        ),
      ),
      body: EpubView(
        controller: _epubController!,
      ),
    );
  }
}
