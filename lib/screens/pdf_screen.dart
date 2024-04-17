import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:edmax/screens/login.dart';
import 'package:edmax/utils/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key});

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  List<Map<String, dynamic>> pdfData = [];
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage =
      FirebaseStorage.instanceFor(bucket: "gs://ed-max-f2a03.appspot.com");
  // bool isAdmin = false;
  final _auth = FirebaseAuth.instance;

  // Future<void> _getSpecificFieldData() async {
  //   try {
  //     User? user = _auth.currentUser;
  //
  //     if(user!= null) {
  //       // Reference to your Firestore document
  //       DocumentReference documentReference =
  //       _firebaseFirestore.collection('students').doc(user.uid);
  //
  //       // Get the document snapshot
  //       DocumentSnapshot documentSnapshot = await documentReference.get();
  //
  //       // Check if the document exists
  //       if (documentSnapshot.exists) {
  //         // Get the specific field data
  //         var fieldData = documentSnapshot.get('role');
  //         print('Field Data: $fieldData');
  //         if(fieldData == "admin"){
  //           isAdmin = true;
  //         } else {
  //           isAdmin = false;
  //         }
  //       } else {
  //         print('Document does not exist');
  //       }
  //     } else {
  //       print('User is not logged in');
  //     }
  //   } catch (e) {
  //     print('Error retrieving data: $e');
  //   }
  // }

  // void condFAB() {
  //   User? user = _auth.currentUser;
  //   var kk = FirebaseFirestore.instance
  //       .collection('students')
  //       .doc(user!.uid)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.get('role') == "student") {
  //       isAdmin = false;
  //     } else {
  //       isAdmin = true;
  //     }
  //   });
  //   setState(() {
  //
  //   });
  // }

  Future<String?> uploadPdf(String fileName, File file) async {
    try {
      TaskSnapshot task =
          await _firebaseStorage.ref("pdfs/$fileName.pdf").putFile(file);
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
      String fileName = pickedFile.files.first.name;
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
    final QuerySnapshot snapshot =
        await _firebaseFirestore.collection("pdfs").get();
    pdfData = snapshot.docs
        .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(isAdmin);
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: GridView.builder(
        itemCount: pdfData.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PdfViewerScreen(pdfUrl: pdfData[index]['url'])));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: backgroundColor1,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.4),
                      spreadRadius: 0,
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/pdf.png",
                      height: 140,
                      width: 100,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        pdfData[index]['name'] ?? "",
                        // maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: pickFile,
              child: Icon(Icons.add),
            )
          : Container(),
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
      body: document != null
          ? PDFViewer(
              document: document,
              showIndicator: true,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
