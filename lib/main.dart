import 'package:pasqualotto/all_items/all_items_widget.dart';
import 'package:pasqualotto/home_page/home_page_widget.dart';
import 'package:pasqualotto/scan_doc/scan_doc_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'flutter_flow/flutter_flow_util.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);

    Future.delayed(const Duration(milliseconds: 1000),
        () => setState(() => _appStateNotifier.stopShowingSplashImage()));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'pasqualotto',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) {
  return GoRouter(
    refreshListenable: appStateNotifier,
    initialLocation: '/home_page', 
    routes: [
      GoRoute(
        path: '/all_items',
        name: 'all_items',
        builder: (context, state) => const AllItemsWidget(),
      ),
      GoRoute(
        path: '/scan_doc',
        name: 'scan_doc',
        builder: (context, state) => const ScanDocWidget(),
      ),
      GoRoute(
        path: '/home_page',
        name: 'home_page',
        builder: (context, state) => const HomePageWidget(),
      )
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page Not found: ${state.uri.path}'),
      ),
    ),
  );
}
