import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For the upload icon

class SaveScanButton extends StatefulWidget {
  @override
  _SaveScanButtonState createState() => _SaveScanButtonState();
}

class _SaveScanButtonState extends State<SaveScanButton> {
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
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton.icon(
          onPressed: _fileName == null ? null : _pickPdf,
          icon: FaIcon(
            FontAwesomeIcons.upload,
            size: 15.0,
            color: Colors.white,
          ),
          label: Text(
            'Salvar',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Readex Pro', // Adjust the font if needed
              letterSpacing: 0.0,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Button color
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.grey.withOpacity(0.38),
            disabledBackgroundColor:
                Colors.grey.withOpacity(0.12), // Text color
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            elevation: 3.0,
            side: BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ), // Disabled color
          ),
        ),
      ),
    );
  }
}
