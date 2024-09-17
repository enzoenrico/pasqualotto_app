import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pasqualotto/scan_doc/pdf_selector_button.dart';
import 'package:pasqualotto/scan_doc/save_scan.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
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
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
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
                  'Upload the pdf document',
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 3.0,
                        ),
                      ),
                      child: FutureBuilder<List<dynamic>>(
                        future: _model.fetchData(
                            "https://render-pasq-api.onrender.com/process"), // Chamada assíncrona
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Mostra um indicador de progresso enquanto os dados estão sendo carregados
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            // Caso ocorra um erro, exibe a mensagem de erro
                            return Text(
                                'Erro ao carregar os dados: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            // Se não houver dados, exibe uma mensagem apropriada
                            return Text('Nenhum dado disponível');
                          } else {
                            // Quando os dados são carregados com sucesso
                            final pdf2jsonResults = snapshot.data?[
                                0]; // Garante que os dados estão disponíveis

                            return SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(pdf2jsonResults.length,
                                    (pdf2jsonResultsIndex) {
                                  final pdf2jsonResultsItem =
                                      pdf2jsonResults[pdf2jsonResultsIndex];
                                  return Theme(
                                    data: ThemeData(
                                      checkboxTheme: const CheckboxThemeData(
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      unselectedWidgetColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                    ),
                                    child: CheckboxListTile(
                                      value: _model.checkboxListTileValueMap[
                                          pdf2jsonResultsItem] ??= true,
                                      onChanged: (newValue) async {
                                        setState(() => _model
                                                .checkboxListTileValueMap[
                                            pdf2jsonResultsItem] = newValue!);
                                      },
                                      title: Text(
                                        pdf2jsonResultsItem['0'].toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              fontFamily: 'Outfit',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      subtitle: Text(
                                        pdf2jsonResultsItem['1'].toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      tileColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      checkColor:
                                          FlutterFlowTheme.of(context).info,
                                      dense: false,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  );
                                }),
                              ),
                            ).animateOnActionTrigger(
                              animationsMap['columnOnActionTriggerAnimation']!,
                            );
                          }
                        },
                      ),
                    ),
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
