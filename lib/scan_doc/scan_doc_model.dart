import 'dart:ffi';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'scan_doc_widget.dart' show ScanDocWidget;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScanDocModel extends FlutterFlowModel<ScanDocWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for CheckboxListTile widget.
  Map<dynamic, bool> checkboxListTileValueMap = {};
  List<dynamic> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  Future<List<dynamic>> fetchData(String uri) async {
    final url = Uri.parse(uri); // Replace with your API URL
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse and return the JSON data
      return jsonDecode(response.body);
    } else {
      // Throw an exception if there is an error
      throw Exception('Failed to load data');
    }
  }



  // Stores action output result for [Backend Call - API (pdf to json)] action in Button widget.
  ApiCallResponse? apiPdf2jsonResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
