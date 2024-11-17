import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'all_items_model.dart';
import 'package:pasqualotto/scan_codes/scan_codes_widget.dart';

class AllItemsWidget extends StatefulWidget {
  const AllItemsWidget({super.key});

  @override
  State<AllItemsWidget> createState() => _AllItemsWidgetState();
}

class _AllItemsWidgetState extends State<AllItemsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final AllItemsModel _model = AllItemsModel();
  List<Map<String, dynamic>> savedLists = [];

  @override
  void initState() {
    super.initState();
    _loadSavedLists();
  }

  Future<void> _loadSavedLists() async {
    List<Map<String, dynamic>> lists = await _model.loadSavedLists();
    setState(() {
      savedLists = lists;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
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
                          final parent = list['items'][0]['parent'];
                          final date = DateTime.parse(list['date']);
                          return ListTile(
                            title: Text(parent),
                            subtitle: Text(
                                'Saved on: ${date.day}/${date.month}/${date.year}'),
                            trailing: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScanCodesWidget(
                                      checkThose: list['items'],
                                      listId: index.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Text('View'),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
