import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For the upload icon

class PdfSelectorButton extends StatefulWidget {
  final Function(File) onPdfSelected; // Callback function

  PdfSelectorButton({required this.onPdfSelected});

  @override
  _PdfSelectorButtonState createState() => _PdfSelectorButtonState();
}

class _PdfSelectorButtonState extends State<PdfSelectorButton> {
  String? _fileName;

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Only allow PDFs
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      setState(() {
        _fileName = result.files.first.name;
      });

      widget.onPdfSelected(file); // Call the callback with the selected file
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
