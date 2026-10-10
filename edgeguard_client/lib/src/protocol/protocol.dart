/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'greeting.dart' as _i2;
import 'false_positive_report.dart' as _i3;
import 'scam_report.dart' as _i4;
import 'package:edgeguard_client/src/protocol/scam_report.dart' as _i5;
import 'package:edgeguard_client/src/protocol/false_positive_report.dart'
    as _i6;
export 'greeting.dart';
export 'false_positive_report.dart';
export 'scam_report.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.Greeting) {
      return _i2.Greeting.fromJson(data) as T;
    }
    if (t == _i3.FalsePositiveReport) {
      return _i3.FalsePositiveReport.fromJson(data) as T;
    }
    if (t == _i4.ScamReport) {
      return _i4.ScamReport.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Greeting?>()) {
      return (data != null ? _i2.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.FalsePositiveReport?>()) {
      return (data != null ? _i3.FalsePositiveReport.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.ScamReport?>()) {
      return (data != null ? _i4.ScamReport.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i5.ScamReport>) {
      return (data as List).map((e) => deserialize<_i5.ScamReport>(e)).toList()
          as T;
    }
    if (t == List<_i6.FalsePositiveReport>) {
      return (data as List)
          .map((e) => deserialize<_i6.FalsePositiveReport>(e))
          .toList() as T;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Greeting) {
      return 'Greeting';
    }
    if (data is _i3.FalsePositiveReport) {
      return 'FalsePositiveReport';
    }
    if (data is _i4.ScamReport) {
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
    if (dataClassName == 'Greeting') {
      return deserialize<_i2.Greeting>(data['data']);
    }
    if (dataClassName == 'FalsePositiveReport') {
      return deserialize<_i3.FalsePositiveReport>(data['data']);
    }
    if (dataClassName == 'ScamReport') {
      return deserialize<_i4.ScamReport>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
