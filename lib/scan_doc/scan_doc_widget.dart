import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pasqualotto/scan_doc/pdf_selector_button.dart';
import 'package:pasqualotto/scan_doc/save_scan.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'list_item.dart';
import 'scan_doc_model.dart';

class ScanDocWidget extends StatefulWidget {
  const ScanDocWidget({super.key});

  @override
  State<ScanDocWidget> createState() => _ScanDocWidgetState();
}

class _ScanDocWidgetState extends State<ScanDocWidget>
    with TickerProviderStateMixin {
  late ScanDocModel _model;
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = false;
  Map<String, bool> _checkedItems = {};
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScanDocModel());

    animationsMap.addAll({
      'columnOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          VisibilityEffect(duration: 150.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 100.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    // Load the persisted list and checked items
    _loadSavedData();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _onPdfUploaded(File file) async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Map<String, dynamic>> items = await _model.fetchItems(file);

      setState(() {
        _items = items;
        _checkedItems = {for (var item in items) item['code']: false};
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao carregar os dados')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onCheckboxChanged(bool? value, String code) {
    setState(() {
      _checkedItems[code] = value ?? false;
    });
  }

  Future<void> _saveList() async {
    final prefs = await SharedPreferences.getInstance();

    // Save item codes
    List<String> itemCodes =
        _items.map((item) => item['code'] as String).toList();
    await prefs.setStringList('savedItemCodes', itemCodes);

    // Save checked states
    for (var entry in _checkedItems.entries) {
      await prefs.setBool('checked_${entry.key}', entry.value);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Lista salva com sucesso!')),
    );
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();

    // Load saved item codes
    List<String>? savedItemCodes = prefs.getStringList('savedItemCodes');
    if (savedItemCodes != null) {
      // Load checked states
      Map<String, bool> savedCheckedItems = {};
      for (String code in savedItemCodes) {
        savedCheckedItems[code] = prefs.getBool('checked_$code') ?? false;
      }

      setState(() {
        _items = savedItemCodes
            .map((code) => {'code': code, 'ref': 'Ref: $code'})
            .toList();
        _checkedItems = savedCheckedItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 387.0,
                height: 46.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Text(
                  'Gerar lista de códigos',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        fontSize: 24.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            final item = _items[index];
                            final code = item['code'] as String;
                            final ref = item['ref'] as String;
                            return ListItem(
                              code: code,
                              ref: ref,
                              isChecked: _checkedItems[code] ?? false,
                              onChanged: (value) =>
                                  _onCheckboxChanged(value, code),
                            );
                          },
                        ),
                ),
              ),
              Container(
                width: 100.0,
                height: 71.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 3.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    PdfSelectorButton(onPdfSelected: _onPdfUploaded),
                    SaveScanButton(onSave: _saveList), // Chama _saveList
                  ],
                ),
              ),
            ].divide(const SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
