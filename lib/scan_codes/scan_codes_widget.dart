import 'package:mobile_scanner/mobile_scanner.dart';
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
                  onDetect: (code) => print(code),
                ),
              ),
              Expanded(
                child: _buildInfoList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoList() {
    final jsonField = [

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


    return ListView.builder(
      itemCount: jsonField.length,
      itemBuilder: (context, index) {
        final item = jsonField[index];
        final itemCode = item["code"]?.toString() ?? 'Unknown Code';
        final itemRef = item["ref"]?.toString() ?? 'Unknown Ref';

        return ListTile(
          title: Text(
            itemCode,
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
          subtitle: Text(
            itemRef,
            style: FlutterFlowTheme.of(context).labelMedium,
          ),
          tileColor: FlutterFlowTheme.of(context).secondaryBackground,
          contentPadding: const EdgeInsets.all(8.0),
        );
      },
    );
  }
}
