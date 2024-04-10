import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PdfScreen extends StatefulWidget {
  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  List<Map<String, dynamic>> pdfData = [];
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadPdf(String fileName, File file) async {
    try {
      TaskSnapshot task = await _firebaseStorage.ref("pdfs/$fileName.pdf").putFile(file);
      String downloadLink = await task.ref.getDownloadURL();
      return downloadLink;
    } catch (e) {
      print("Error uploading PDF: $e");
      return null;
    }
  }

  void pickFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pickedFile != null) {
      String fileName = pickedFile.files.first.name!;
      File file = File(pickedFile.files.first.path!);

      String? downloadLink = await uploadPdf(fileName, file);
      if (downloadLink != null) {
        _firebaseFirestore.collection("pdfs").add({
          "name": fileName,
          "url": downloadLink,
        });
        print('Uploaded');
        getAllPdf();
      } else {
        print("Failed to upload PDF.");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getAllPdf();
  }

  void getAllPdf() async {
    final QuerySnapshot snapshot = await _firebaseFirestore.collection("pdfs").get();
    pdfData = snapshot.docs.map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: GridView.builder(
        itemCount: pdfData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PdfViewerScreen(pdfUrl: pdfData[index]['url'])));
              },
              child: Container(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/button.png",
                      height: 120,
                      width: 100,
                    ),
                    Text(pdfData[index]['name'] ?? ""),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickFile,
        child: Icon(Icons.add),
      ),
    );
  }
}

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;

  const PdfViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    initializePdf();
  }

  void initializePdf() async {
    document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: document != null ? PDFViewer(document: document) : Center(child: CircularProgressIndicator()),
    );
  }
}
