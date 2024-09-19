import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SaveScanButton extends StatefulWidget {
  final VoidCallback onSave;

  const SaveScanButton({required this.onSave, Key? key}) : super(key: key);

  @override
  _SaveScanButtonState createState() => _SaveScanButtonState();
}

class _SaveScanButtonState extends State<SaveScanButton> {
  String? _fileName;

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
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
          onPressed: _fileName == null ? widget.onSave : _pickPdf,
          icon: const FaIcon(
            FontAwesomeIcons.upload,
            size: 15.0,
            color: Colors.white,
          ),
          label: const Text(
            'Salvar',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Readex Pro',
              letterSpacing: 0.0,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.grey.withOpacity(0.38),
            disabledBackgroundColor: Colors.grey.withOpacity(0.12),
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
