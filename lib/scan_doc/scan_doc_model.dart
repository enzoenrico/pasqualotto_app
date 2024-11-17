import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

    // Ensure all required fields are included
    return response.map((item) {
      return {
        'parent': item['parent'] ?? 'Sem identificação', // Default to prevent null
        'code': item['code'] ?? 'Sem identificação',
        'ref': item['ref'] ?? 'Sem identificação',
        'size': item['size'] ?? 'Sem identificação',
        'quantity': item['quantity'] ?? 'Sem identificação',
      };
    }).toList();
  }

  // Método para salvar checkboxes no SharedPreferences
  Future<void> saveToShared(List<Map<String, dynamic>> items) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedItems = items.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('savedCheckboxes', encodedItems);
  }

  // Método para carregar checkboxes do SharedPreferences
  Future<List<Map<String, dynamic>>> loadFromShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedItems = prefs.getStringList('savedCheckboxes');
    if (encodedItems == null) return [];
    return encodedItems
        .map((item) => Map<String, dynamic>.from(jsonDecode(item)))
        .toList();
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
