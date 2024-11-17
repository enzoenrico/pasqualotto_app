import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'all_items_widget.dart' show AllItemsWidget;
import 'package:flutter/material.dart';

class AllItemsModel extends FlutterFlowModel<AllItemsWidget> {
  final unfocusNode = FocusNode();

  Future<List<List<Map<String, dynamic>>>> loadSavedLists() async {
    final prefs = await SharedPreferences.getInstance();

    // Fetch saved lists
    List<String>? serializedLists = prefs.getStringList('savedLists');
    if (serializedLists == null) return [];

    try {
      // Decode each JSON string into a list of maps
      return serializedLists.map((listString) {
        final decodedList = jsonDecode(listString); // Decode JSON
        return List<Map<String, dynamic>>.from(
            decodedList as List<dynamic>); // Ensure correct type
      }).toList();
    } catch (e) {
      debugPrint('Error loading saved lists: $e');
      return [];
    }
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
