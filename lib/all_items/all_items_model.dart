import 'package:shared_preferences/shared_preferences.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'all_items_widget.dart' show AllItemsWidget;
import 'package:flutter/material.dart';

class AllItemsModel extends FlutterFlowModel<AllItemsWidget> {
  final unfocusNode = FocusNode();

  Future<List<Map<String, dynamic>>> loadSavedLists() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve saved lists
    List<String>? serializedLists = prefs.getStringList('savedLists');
    if (serializedLists == null) return [];

    try {
      // Parse each list into a Map with items and date
      return serializedLists.map((listString) {
        final decodedList = jsonDecode(listString);
        return {
          'date': decodedList['date'], // Extract the date
          'items': List<Map<String, dynamic>>.from(decodedList['items']),
        };
      }).toList();
    } catch (e) {
      debugPrint('Erro ao carregar listas salvas: $e');
      return [];
    }
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
