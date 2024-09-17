import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For the upload icon

import 'scan_doc_model.dart'; // Import the model

class PdfSelectorButton extends StatefulWidget {
  @override
  _PdfSelectorButtonState createState() => _PdfSelectorButtonState();
}

class _PdfSelectorButtonState extends State<PdfSelectorButton> {
  String? _fileName;
  final ScanDocModel _scanDocModel = ScanDocModel(); // Instantiate the model

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Only allow PDFs
    );

    if (result != null) {
      // Get the picked file path
      File file = File(result.files.single.path!);

      setState(() {
        _fileName = result.files.first.name;
      });

      // Send the file data to the model
      try {
        await _scanDocModel.sendPdfData(file);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF uploaded successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload PDF')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton.icon(
          onPressed: _pickPdf,
          icon: const FaIcon(FontAwesomeIcons.upload),
          label: const Text('Enviar PDF'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Button color
            foregroundColor: Colors.white, // Text color
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            elevation: 3.0,
            side: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
