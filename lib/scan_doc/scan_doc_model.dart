import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;

import '../flutter_flow/flutter_flow_model.dart';
import 'scan_doc_widget.dart' show ScanDocWidget;

class ScanDocModel extends FlutterFlowModel<ScanDocWidget> {
  final String apiUrl =
      'https://render-pasq-api.onrender.com/ponga'; // Replace with your API URL

  Future<List<dynamic>> sendPdfData(File pdfFile) async {
    final uri = Uri.parse(
        'https://render-pasq-api.onrender.com/ponga'); // Replace with your endpoint

    // Create a MultipartRequest
    var request = http.MultipartRequest('POST', uri);

    // Attach the PDF file to the request
    request.files.add(
      await http.MultipartFile.fromPath(
        'post_file', // The key name expected by your API (same as in Postman)
        pdfFile.path,
        filename:
            p.basename(pdfFile.path), // Use p.basename to get the file name
        contentType: MediaType('application', 'pdf'),
      ),
    );

    // Log the request details (for debugging purposes)
    print('Sending request to $uri');
    print('Request fields: ${request.fields}');
    print('Request files: ${request.files}');

    // Send the request and get the response
    var response = await request.send();

    // Read the response
    if (response.statusCode == 200) {
      String jsonResponse = await response.stream.bytesToString();
      List<dynamic> jsonList = jsonDecode(jsonResponse);
      print('Response: $jsonList');
      return jsonList;
    } else {
      // Log the response body for debugging
      String responseBody = await response.stream.bytesToString();
      print('Response body: $responseBody');
      throw Exception(
          'Failed to upload PDF. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
