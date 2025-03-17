import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';


void main() {
  runApp(CertificateApp());
}

class CertificateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Certificate Generator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CertificateEditor(),
    );
  }
}

class CertificateEditor extends StatefulWidget {
  @override
  _CertificateEditorState createState() => _CertificateEditorState();
}

class _CertificateEditorState extends State<CertificateEditor> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  Color textColor = Colors.black;
  File? logo;
  File? signature;

  Uint8List? logoBytes;
  Uint8List? signatureBytes;

  Future<void> pickImage(bool isLogo) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List bytes = await pickedFile.readAsBytes(); // ✅ Web-Compatible

      setState(() {
        if (isLogo) {
          logoBytes = bytes;
        } else {
          signatureBytes = bytes;
        }
      });
    }
  }


  void changeTextColor(Color color) {
    setState(() {
      textColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customize Certificate')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Recipient Name'),
            ),
            TextField(
              controller: courseController,
              decoration: InputDecoration(labelText: 'Course Name'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => pickImage(true),
              child: Text('Upload Logo'),
            ),
            ElevatedButton(
              onPressed: () => pickImage(false),
              child: Text('Upload Signature'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Pick Text Color'),
                    content: BlockPicker(
                      pickerColor: textColor,
                      onColorChanged: changeTextColor,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Done'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Choose Text Color'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => generatePDF(),
              child: Text('Generate Certificate'),
            ),
          ],
        ),
      ),
    );
  }

  void generatePDF() async {
    final pdf = pw.Document();
    final pwColor = PdfColor(
      textColor.red / 255,
      textColor.green / 255,
      textColor.blue / 255,
    );


    Uint8List? logoBytes = logo != null ? await logo!.readAsBytes() : null;

    Uint8List? signatureBytes = signature != null ? await signature!.readAsBytes() : null;

    final pwImage = logoBytes != null ? pw.MemoryImage(logoBytes) : null;
    final pwSignature = signatureBytes != null ? pw.MemoryImage(signatureBytes) : null;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [

                // Letterhead section
                if (pwImage != null)
                  pw.Image(pwImage, width: 100, height: 100),
                pw.Text(
                  'Your Company Name',
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  'Company Address, City, Country',
                  style: pw.TextStyle(fontSize: 12),
                ),
                pw.SizedBox(height: 20),

                if (pwImage != null) pw.Image(pwImage, width: 100, height: 100),
                pw.Text(
                  'Certificate of Completion',
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: pwColor),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'This certifies that',
                  style: pw.TextStyle(fontSize: 18, color: pwColor),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  nameController.text,
                  style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, color: pwColor),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'has successfully completed the course',
                  style: pw.TextStyle(fontSize: 18, color: pwColor),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  courseController.text,
                  style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, color: pwColor),
                ),
                pw.SizedBox(height: 30),
                pw.Text('Date: ${DateTime.now().toLocal()}'),
                if (pwSignature != null) pw.SizedBox(height: 20),
                if (pwSignature != null) pw.Image(pwSignature, width: 100, height: 50),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());

  }
}
