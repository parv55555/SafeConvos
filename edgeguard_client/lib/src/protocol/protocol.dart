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
import 'package:edgeguard_client/src/protocol/false_positive_report.dart'
    as _ip23wwz2;
import 'package:edgeguard_client/src/protocol/scam_report.dart' as _ibgps2n3;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'false_positive_report.dart' as _itau6ji4;
import 'greeting.dart' as _ig8bxnp5;
import 'scam_report.dart' as _i5wbwagu;
export 'false_positive_report.dart';
export 'greeting.dart';
export 'scam_report.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _isc.getType<_itau6ji4.FalsePositiveReport?>()) {
      return (data != null
          ? _itau6ji4.FalsePositiveReport.fromJson(data)
          : null) as T;
    }
    if (t == _isc.getType<_ig8bxnp5.Greeting?>()) {
      return (data != null ? _ig8bxnp5.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i5wbwagu.ScamReport?>()) {
      return (data != null ? _i5wbwagu.ScamReport.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ibgps2n3.ScamReport>) {
      return (data as List)
          .map((e) => deserialize<_ibgps2n3.ScamReport>(e))
          .toList() as T;
    }
    if (t == List<_ip23wwz2.FalsePositiveReport>) {
      return (data as List)
          .map((e) => deserialize<_ip23wwz2.FalsePositiveReport>(e))
          .toList() as T;
    }
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
    return super.deserializeByClassName(data);
  }

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
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
