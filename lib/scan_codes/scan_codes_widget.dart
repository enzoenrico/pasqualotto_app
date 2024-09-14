import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa o shared_preferences
import '../flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class ScanCodesWidget extends StatefulWidget {
  const ScanCodesWidget({
    super.key,
    required this.checkThose,
  });

  final dynamic checkThose;

  @override
  State<ScanCodesWidget> createState() => _ScanCodesWidgetState();
}

class _ScanCodesWidgetState extends State<ScanCodesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedItems(); // Carrega os estados salvos das checkboxes
  }

  // Lista de códigos e referências
  final List<dynamic> jsonField = [
    {
      'code': '0074838270542230000000551231280824',
      'ref': 'GAV0191A',
    },
    {
      'code': 'BAS0098B',
      'ref': 'GAV0191B',
    },
    {
      'code': 'BAS0098C',
      'ref': 'GAV0191C',
    },
    {
      'code': 'BAS0098D',
      'ref': 'GAV0191D',
    },
    // Adicione mais itens conforme necessário
  ];

  // Carrega o estado salvo das checkboxes
  Future<void> _loadSelectedItems() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedItems = List<bool>.filled(jsonField.length, false);
      for (int i = 0; i < jsonField.length; i++) {
        _selectedItems[i] = prefs.getBool('selected_$i') ?? false;
      }
    });
  }

  // Salva o estado das checkboxes
  Future<void> _saveSelectedItem(int index, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('selected_$index', value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Expanded(
                child: MobileScanner(
                  onDetect: (codeCapture) {
                    final List<Barcode> barcodes = codeCapture.barcodes;
                    final Uint8List? image = codeCapture.image;

                    for (final barcode in barcodes) {
                      String? scannedCode = barcode.rawValue;
                      bool found = false;

                      if (scannedCode != null) {
                        // Verifica se o código escaneado está presente na lista de jsonField
                        for (int i = 0; i < jsonField.length; i++) {
                          if (jsonField[i]['code'] == scannedCode) {
                            setState(() {
                              _selectedItems[i] = true; // Marca a checkbox como true
                              _saveSelectedItem(i, true); // Salva o estado
                            });
                            found = true;
                            break;
                          }
                        }
                      }

                      if (!found) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Código escaneado não encontrado!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }

                      print('${DateTime.now()} - Barcode Data: $scannedCode');
                    }
                  },
                ),
              ),
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
    return Expanded(
      child: Padding(
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
              itemCount: jsonField.length,
              itemBuilder: (context, index) {
                final item = jsonField[index];
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
                        _saveSelectedItem(index, value); // Salva o estado atualizado
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
