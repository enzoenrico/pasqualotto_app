import 'package:shared_preferences/shared_preferences.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class ScanCodesWidget extends StatefulWidget {
  final List<dynamic> checkThose;
  final String listId; // Usado para identificar a lista

  const ScanCodesWidget({
    super.key,
    required this.checkThose,
    required this.listId, // Identificador único para cada lista
  });


  @override
  State<ScanCodesWidget> createState() => _ScanCodesWidgetState();
}

class _ScanCodesWidgetState extends State<ScanCodesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<dynamic> jsonField;
  List<bool> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    jsonField = widget.checkThose;
    _loadSelectedItems();
  }

  Future<void> _loadSelectedItems() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedItems = List<bool>.filled(jsonField.length, false);
      for (int i = 0; i < jsonField.length; i++) {
        _selectedItems[i] =
            prefs.getBool('${widget.listId}_selected_$i') ?? false;
      }
    });
  }

  Future<void> _saveSelectedItem(int index, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${widget.listId}_selected_$index', value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _buildInfoList(jsonField),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoList(List<dynamic> jsonList) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: FlutterFlowTheme.of(context).primary,
              width: 3.0,
            ),
          ),
          child: ListView.builder(
            itemCount: jsonList.length,
            itemBuilder: (context, index) {
              final item = jsonList[index];
              return ListTile(
                title: Text(
                  "Code: ${item['code']!}",
                  style: TextStyle(
                    color: _selectedItems[index]
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
                subtitle: Text("Reference: ${item['ref']!}"),
                trailing: Checkbox(
                  value: _selectedItems[index],
                  onChanged: (bool? value) {
                    setState(() {
                      _selectedItems[index] = value!;
                      _saveSelectedItem(index, value);
                    });
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
