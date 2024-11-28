import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // Para o scanner de código de barras
import '/flutter_flow/flutter_flow_theme.dart';

class ScanCodesWidget extends StatefulWidget {
  const ScanCodesWidget({
    super.key,
    required this.checkThose,
    required this.listId, // Adicionado para identificar a lista única
  });

  final List<dynamic> checkThose; // A lista de itens
  final String listId; // Um identificador único para esta lista

  @override
  State<ScanCodesWidget> createState() => _ScanCodesWidgetState();
}

class _ScanCodesWidgetState extends State<ScanCodesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<dynamic> jsonField;
  List<bool> _selectedItems = [];
  bool _isScanning = false; // Para indicar se o scanner está ativo

  @override
  void initState() {
    super.initState();
    jsonField = widget.checkThose; // Direct assignment since it's required
    _loadSelectedItems();
  }

  @override
  void dispose() {
    // Cleanup if needed
    super.dispose();
  }

  Future<void> _loadSelectedItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _selectedItems = List<bool>.filled(jsonField.length, false);
        for (int i = 0; i < jsonField.length; i++) {
          final key = '${widget.listId}_selected_$i';
          _selectedItems[i] = prefs.getBool(key) ?? false;
        }
      });
    } catch (e) {
      debugPrint('Error loading items: $e');
      // Handle error appropriately
    }
  }

  Future<void> _saveSelectedItem(int index, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '${widget.listId}_selected_$index';
      await prefs.setBool(key, value);
    } catch (e) {
      debugPrint('Error saving item: $e');
      // Handle error appropriately
    }
  }

  void _onBarcodeDetected(String barcode) {
    final index = jsonField.indexWhere((item) => item['code'] == barcode);
    if (index != -1) {
      setState(() {
        _selectedItems[index] = true;
        _saveSelectedItem(index, true);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Código $barcode marcado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Código $barcode não encontrado na lista.')),
      );
    }
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
                flex: 4,
                child: _buildInfoList(jsonField),
              ),
              Expanded(
                flex: 2,
                child: _isScanning
                    ? MobileScanner(
                        onDetect: (capture) {
                          final barcodes = capture.barcodes;
                          for (var barcode in barcodes) {
                            if (barcode.rawValue != null) {
                              _onBarcodeDetected(barcode.rawValue!);
                              break;
                            }
                          }
                        },
                      )
                    : Center(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isScanning = !_isScanning;
                            });
                          },
                          child:
                              const Text('Iniciar Scanner de Código de Barras'),
                        ),
                      ),
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
                    color: _selectedItems[index] ? Colors.green : Colors.black,
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
