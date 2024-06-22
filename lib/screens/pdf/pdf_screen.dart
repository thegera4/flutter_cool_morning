/*import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import '../../utils/constants.dart';

class PDFScreen extends StatefulWidget {
  const PDFScreen({super.key, required this.catalog});

  final String catalog;

  @override
  PDFScreenState createState() => PDFScreenState();
}

class PDFScreenState extends State<PDFScreen> {

  late PDFViewController pdfViewController;
  late Future<File> file;

  Future<File> _loadFile() async {
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/${widget.catalog.split("/").last}').create();
    await file.writeAsBytes((await rootBundle.load(widget.catalog)).buffer.asUint8List());
    return file;
  }

  @override
  void initState() {
    super.initState();
    file = _loadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.catalog.split("/").last.split(".").first),),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: FutureBuilder<File>(
          future: file,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(child: Text(kErrorLoadingPDF));
              } else {
                return PDFView(
                  filePath: snapshot.data!.path,
                  autoSpacing: false,
                  enableSwipe: true,
                  pageSnap: false,
                  swipeHorizontal: false,
                  onError: (error) {
                    if (kDebugMode) {
                      print(error);
                    }
                    },
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
*/