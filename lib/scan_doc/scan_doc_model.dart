import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;

import '../flutter_flow/flutter_flow_model.dart';
import 'scan_doc_widget.dart' show ScanDocWidget;

class ScanDocModel extends FlutterFlowModel<ScanDocWidget> {
  final String apiUrl = 'https://api';

  Future<List<dynamic>> sendPdfData(File pdfFile) async {
    final uri = Uri.parse('https://render-pasq-api.onrender.com/ponga');

    var request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath(
        'post_file',
        pdfFile.path,
        filename: p.basename(pdfFile.path),
        contentType: MediaType('application', 'pdf'),
      ),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      String jsonResponse = await response.stream.bytesToString();
      List<dynamic> jsonList = jsonDecode(jsonResponse);
      return jsonList;
    } else {
      String responseBody = await response.stream.bytesToString();
      throw Exception('Falha ao enviar PDF. Contate o suporte!');
    }
  }

  Future<List<Map<String, dynamic>>> fetchItems(File pdfFile) async {
    List<dynamic> response = await sendPdfData(pdfFile);
    return List<Map<String, dynamic>>.from(response.map((item) => {
          'code': item['code'],
          'ref': item['ref'],
        }));
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
