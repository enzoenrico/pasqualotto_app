import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
                      child: Builder(
                        builder: (context) {
                          final pdf2jsonResults = [

                              {
                                'code': 'BAS0098A',
                                'ref': 'GAV0191A',
                              }
                              ,
                              {
                                'code': 'BAS0098B',
                                'ref': 'GAV0191B',
                              }
                              ,
                              {
                                'code': 'BAS0098C',
                                'ref': 'GAV0191C',
                              }
                              ,
                              {
                                'code': 'BAS0098D',
                                'ref': 'GAV0191D',
                              }
                          ];
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(pdf2jsonResults.length, (pdf2jsonResultsIndex) {
                                final pdf2jsonResultsItem = pdf2jsonResults[pdf2jsonResultsIndex];

                                return Theme(
                                  data: ThemeData(
                                    checkboxTheme: const CheckboxThemeData(
                                      visualDensity: VisualDensity.compact,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                  ),
                                  child: CheckboxListTile(
                                    value: _model.checkboxListTileValueMap[pdf2jsonResultsItem] ??= true,
                                    onChanged: (newValue) async {
                                      setState(() => _model.checkboxListTileValueMap[pdf2jsonResultsItem] = newValue!);
                                    },
                                    title: Text(
                                      pdf2jsonResultsItem['code'].toString(),
                                      style: FlutterFlowTheme.of(context).titleLarge.override(
                                        fontFamily: 'Outfit',
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                    subtitle: Text(
                                        pdf2jsonResultsItem['ref'].toString(),
                                      style: FlutterFlowTheme.of(context).labelMedium.override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                    tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                                    activeColor: FlutterFlowTheme.of(context).primary,
                                    checkColor: FlutterFlowTheme.of(context).info,
                                    dense: false,
                                    controlAffinity: ListTileControlAffinity.trailing,
                                  ),
                                );
                              }),
                            ),
                          ).animateOnActionTrigger(
                            animationsMap['columnOnActionTriggerAnimation']!,
                          );
                        },
                      ),

                    ),
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
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: FlutterFlowPdfViewer(
                              fileBytes: _model.uploadedLocalFile?.bytes,
                              width: double.infinity,
                              height: 290.0,
                              horizontalScroll: true,
                            ),
                          ),
                        ],
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
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            final selectedFiles = await selectFiles(
                              allowedExtensions: ['pdf'],
                              multiFile: false,
                            );
                            if (selectedFiles != null) {
                              setState(() => _model.isDataUploading = true);
                              var selectedUploadedFiles = <FFUploadedFile>[];

                              try {
                                selectedUploadedFiles = selectedFiles
                                    .map((m) => FFUploadedFile(
                                  name: m.storagePath.split('/').last,
                                  bytes: m.bytes,
                                ))
                                    .toList();
                              } finally {
                                _model.isDataUploading = false;
                              }
                              if (selectedUploadedFiles.length ==
                                  selectedFiles.length) {
                                setState(() {
                                  _model.uploadedLocalFile =
                                      selectedUploadedFiles.first;
                                });
                              } else {
                                setState(() {});
                                return;
                              }
                            }

                            _model.apiPdf2jsonResult =
                            await PdfToJsonCall.call();

                            FFAppState().currentpdf =
                            (_model.apiPdf2jsonResult?.jsonBody ?? '');
                            FFAppState().addToAllpdfs(
                                (_model.apiPdf2jsonResult?.jsonBody ?? ''));
                            FFAppState().update(() {});
                            if (animationsMap[
                            'columnOnActionTriggerAnimation'] !=
                                null) {
                              await animationsMap[
                              'columnOnActionTriggerAnimation']!
                                  .controller
                                  .forward(from: 0.0);
                            }

                            setState(() {});
                          },
                          text: 'Upload File',
                          icon: FaIcon(
                            FontAwesomeIcons.cloudUploadAlt,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            height: double.infinity,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                              letterSpacing: 0.0,
                            ),
                            elevation: 3.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FFButtonWidget(
                          onPressed: (FFAppState().currentpdf == null)
                              ? null
                              : () async {
                            context.pushNamed(
                              'scan_codes',
                              queryParameters: {
                                'checkThose': serializeParam(
                                  FFAppState().currentpdf,
                                  ParamType.JSON,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType:
                                  PageTransitionType.bottomToTop,
                                  duration: Duration(milliseconds: 150),
                                ),
                              },
                            );
                          },
                          text: 'Save',
                          icon: const FaIcon(
                            FontAwesomeIcons.checkCircle,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            height: double.infinity,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 0.0,
                            ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                            disabledColor:
                            FlutterFlowTheme.of(context).secondary,
                            disabledTextColor:
                            FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                      ),
                    ),
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
