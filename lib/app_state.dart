import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = const FlutterSecureStorage();
    await _safeInitAsync(() async {
      _allpdfs = (await secureStorage.getStringList('ff_allpdfs'))?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _allpdfs;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  dynamic _currentpdf;
  dynamic get currentpdf => _currentpdf;
  set currentpdf(dynamic value) {
    _currentpdf = value;
  }

  List<dynamic> _allpdfs = [];
  List<dynamic> get allpdfs => _allpdfs;
  set allpdfs(List<dynamic> value) {
    _allpdfs = value;
    secureStorage.setStringList(
        'ff_allpdfs', value.map((x) => jsonEncode(x)).toList());
  }

  void deleteAllpdfs() {
    secureStorage.delete(key: 'ff_allpdfs');
  }

  void addToAllpdfs(dynamic value) {
    allpdfs.add(value);
    secureStorage.setStringList(
        'ff_allpdfs', _allpdfs.map((x) => jsonEncode(x)).toList());
  }

  void removeFromAllpdfs(dynamic value) {
    allpdfs.remove(value);
    secureStorage.setStringList(
        'ff_allpdfs', _allpdfs.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromAllpdfs(int index) {
    allpdfs.removeAt(index);
    secureStorage.setStringList(
        'ff_allpdfs', _allpdfs.map((x) => jsonEncode(x)).toList());
  }

  void updateAllpdfsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    allpdfs[index] = updateFn(_allpdfs[index]);
    secureStorage.setStringList(
        'ff_allpdfs', _allpdfs.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInAllpdfs(int index, dynamic value) {
    allpdfs.insert(index, value);
    secureStorage.setStringList(
        'ff_allpdfs', _allpdfs.map((x) => jsonEncode(x)).toList());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return const CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: const ListToCsvConverter().convert([value]));
}
