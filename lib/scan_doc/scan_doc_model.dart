import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'scan_doc_widget.dart' show ScanDocWidget;
import 'package:flutter/material.dart';

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

  // Stores action output result for [Backend Call - API (pdf to json)] action in Button widget.
  ApiCallResponse? apiPdf2jsonResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
