// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PartStruct extends BaseStruct {
  PartStruct({
    String? parentName,
    String? code,
    String? quantity,
    String? ref,
    String? size,
  })  : _parentName = parentName,
        _code = code,
        _quantity = quantity,
        _ref = ref,
        _size = size;

  // "parent_name" field.
  String? _parentName;
  String get parentName => _parentName ?? '';
  set parentName(String? val) => _parentName = val;

  bool hasParentName() => _parentName != null;

  // "code" field.
  String? _code;
  String get code => _code ?? '';
  set code(String? val) => _code = val;

  bool hasCode() => _code != null;

  // "quantity" field.
  String? _quantity;
  String get quantity => _quantity ?? '';
  set quantity(String? val) => _quantity = val;

  bool hasQuantity() => _quantity != null;

  // "ref" field.
  String? _ref;
  String get ref => _ref ?? '';
  set ref(String? val) => _ref = val;

  bool hasRef() => _ref != null;

  // "size" field.
  String? _size;
  String get size => _size ?? '';
  set size(String? val) => _size = val;

  bool hasSize() => _size != null;

  static PartStruct fromMap(Map<String, dynamic> data) => PartStruct(
        parentName: data['parent_name'] as String?,
        code: data['code'] as String?,
        quantity: data['quantity'] as String?,
        ref: data['ref'] as String?,
        size: data['size'] as String?,
      );

  static PartStruct? maybeFromMap(dynamic data) =>
      data is Map ? PartStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'parent_name': _parentName,
        'code': _code,
        'quantity': _quantity,
        'ref': _ref,
        'size': _size,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'parent_name': serializeParam(
          _parentName,
          ParamType.String,
        ),
        'code': serializeParam(
          _code,
          ParamType.String,
        ),
        'quantity': serializeParam(
          _quantity,
          ParamType.String,
        ),
        'ref': serializeParam(
          _ref,
          ParamType.String,
        ),
        'size': serializeParam(
          _size,
          ParamType.String,
        ),
      }.withoutNulls;

  static PartStruct fromSerializableMap(Map<String, dynamic> data) =>
      PartStruct(
        parentName: deserializeParam(
          data['parent_name'],
          ParamType.String,
          false,
        ),
        code: deserializeParam(
          data['code'],
          ParamType.String,
          false,
        ),
        quantity: deserializeParam(
          data['quantity'],
          ParamType.String,
          false,
        ),
        ref: deserializeParam(
          data['ref'],
          ParamType.String,
          false,
        ),
        size: deserializeParam(
          data['size'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PartStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PartStruct &&
        parentName == other.parentName &&
        code == other.code &&
        quantity == other.quantity &&
        ref == other.ref &&
        size == other.size;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([parentName, code, quantity, ref, size]);
}

PartStruct createPartStruct({
  String? parentName,
  String? code,
  String? quantity,
  String? ref,
  String? size,
}) =>
    PartStruct(
      parentName: parentName,
      code: code,
      quantity: quantity,
      ref: ref,
      size: size,
    );
