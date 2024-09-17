import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Add this for the upload icon

class PdfSelectorButton extends StatefulWidget {
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
      setState(() {
        _fileName = result.files.first.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.all(4.0),
            child: ElevatedButton.icon(
                onPressed: _pickPdf,
                icon: FaIcon(FontAwesomeIcons.upload),
                label: Text('Enviar PDF'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Button color
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  elevation: 3.0,
                  side: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ))));
  }
}
