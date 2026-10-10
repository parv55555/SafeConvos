/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:edgeguard_server/src/generated/false_positive_report.dart'
    as _ikgrqawu;
import 'package:edgeguard_server/src/generated/scam_report.dart' as _i5kk03o8;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'false_positive_report.dart' as _itau6ji4;
import 'greeting.dart' as _ig8bxnp5;
import 'scam_report.dart' as _i5wbwagu;
export 'false_positive_report.dart';
export 'greeting.dart';
export 'scam_report.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
        _isp.TableDefinition(
          name: 'false_positive_report',
          dartName: 'FalsePositiveReport',
          schema: 'public',
          module: 'edgeguard',
          columns: [
            _isp.ColumnDefinition(
              name: 'id',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int?',
              columnDefault: 'serial',
            ),
            _isp.ColumnDefinition(
              name: 'messageContent',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'timestamp',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: false,
              dartType: 'DateTime',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        ),
        _isp.TableDefinition(
          name: 'scam_report',
          dartName: 'ScamReport',
          schema: 'public',
          module: 'edgeguard',
          columns: [
            _isp.ColumnDefinition(
              name: 'id',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int?',
              columnDefault: 'serial',
            ),
            _isp.ColumnDefinition(
              name: 'phoneNumber',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'category',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'timestamp',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: false,
              dartType: 'DateTime',
            ),
            _isp.ColumnDefinition(
              name: 'city',
              columnType: _isp.ColumnType.text,
              isNullable: true,
              dartType: 'String?',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        ),
        ..._isp.Protocol.targetTableDefinitions,
      ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _itau6ji4.FalsePositiveReport) {
      return _itau6ji4.FalsePositiveReport.fromJson(data) as T;
    }
    if (t == _ig8bxnp5.Greeting) {
      return _ig8bxnp5.Greeting.fromJson(data) as T;
    }
    if (t == _i5wbwagu.ScamReport) {
      return _i5wbwagu.ScamReport.fromJson(data) as T;
    }
    if (t == _is.getType<_itau6ji4.FalsePositiveReport?>()) {
      return (data != null
          ? _itau6ji4.FalsePositiveReport.fromJson(data)
          : null) as T;
    }
    if (t == _is.getType<_ig8bxnp5.Greeting?>()) {
      return (data != null ? _ig8bxnp5.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5wbwagu.ScamReport?>()) {
      return (data != null ? _i5wbwagu.ScamReport.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i5kk03o8.ScamReport>) {
      return (data as List)
          .map((e) => deserialize<_i5kk03o8.ScamReport>(e))
          .toList() as T;
    }
    if (t == List<_ikgrqawu.FalsePositiveReport>) {
      return (data as List)
          .map((e) => deserialize<_ikgrqawu.FalsePositiveReport>(e))
          .toList() as T;
    }
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _itau6ji4.FalsePositiveReport => 'FalsePositiveReport',
      _ig8bxnp5.Greeting => 'Greeting',
      _i5wbwagu.ScamReport => 'ScamReport',
      _ => null
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('edgeguard.', '');
    }

    switch (data) {
      case _itau6ji4.FalsePositiveReport():
        return 'FalsePositiveReport';
      case _ig8bxnp5.Greeting():
        return 'Greeting';
      case _i5wbwagu.ScamReport():
        return 'ScamReport';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'FalsePositiveReport') {
      return deserialize<_itau6ji4.FalsePositiveReport>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_ig8bxnp5.Greeting>(data['data']);
    }
    if (dataClassName == 'ScamReport') {
      return deserialize<_i5wbwagu.ScamReport>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _itau6ji4.FalsePositiveReport:
        return _itau6ji4.FalsePositiveReport.t;
      case _i5wbwagu.ScamReport:
        return _i5wbwagu.ScamReport.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'edgeguard';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _isp.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
