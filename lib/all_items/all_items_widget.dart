import 'package:pasqualotto/scan_codes/scan_codes_widget.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'all_items_model.dart';
export 'all_items_model.dart';

class AllItemsWidget extends StatefulWidget {
  const AllItemsWidget({super.key});

  @override
  State<AllItemsWidget> createState() => _AllItemsWidgetState();
}

class _AllItemsWidgetState extends State<AllItemsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final AllItemsModel _model = AllItemsModel();
  List<List<Map<String, dynamic>>> savedLists = [];

  @override
  void initState() {
    super.initState();
    _loadSavedLists();
  }

  Future<void> _loadSavedLists() async {
    List<List<Map<String, dynamic>>> lists = await _model.loadSavedLists();
    setState(() {
      savedLists = lists;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadSavedLists();
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
        backgroundColor: FlutterFlowTheme.of(context).primary,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            context.pushNamed('scan_doc');
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 8.0,
          child: Icon(
            Icons.add,
            color: FlutterFlowTheme.of(context).info,
            size: 24.0,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo_hero',
              transitionOnUserGestures: true,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/image_1.png',
                  width: 253.0,
                  height: 136.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 100.0,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: savedLists.isEmpty
                      ? Center(
                          child: Text(
                            "No saved lists available",
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        )
                      : ListView.builder(
                          itemCount: savedLists.length,
                          itemBuilder: (context, index) {
                            final list = savedLists[index];
                            return Container(
                              width: 100.0,
                              height: 100.0,
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 2.0,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      'List ${index + 1}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Pass the selected list to ScanCodesWidget
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ScanCodesWidget(
                                            checkThose:
                                                list, // Pass the list dynamically
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text('View'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
          ].divide(const SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
