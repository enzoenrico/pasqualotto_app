import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pasqualotto/scan_doc/pdf_selector_button.dart';
import 'package:pasqualotto/scan_doc/save_scan.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'list_item.dart';
import 'scan_doc_model.dart';

export 'scan_doc_model.dart';

class ScanDocWidget extends StatefulWidget {
  const ScanDocWidget({super.key});

  @override
  State<ScanDocWidget> createState() => _ScanDocWidgetState();
}

class _ScanDocWidgetState extends State<ScanDocWidget>
    with TickerProviderStateMixin {
  late ScanDocModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  List<Map<String, dynamic>> items = [
    {'code': 'Item 1', 'ref': 'Reference 1'},
    {'code': 'Item 2', 'ref': 'Reference 2'},
    // Add more items as needed
  ];

  Map<String, bool> _checkedItems = {};

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

    // Initialize the checked items map
    for (var item in items) {
      _checkedItems[item['code']] = false;
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _onCheckboxChanged(bool? value, String code) {
    setState(() {
      _checkedItems[code] = value ?? false;
    });
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
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final code = item['code'] as String;
                      final ref = item['ref'] as String;
                      return ListItem(
                        code: code,
                        ref: ref,
                        isChecked: _checkedItems[code] ?? false,
                        onChanged: (value) => _onCheckboxChanged(value, code),
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
                  children: [PdfSelectorButton(), SaveScanButton()],
                ),
              ),
            ].divide(const SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
