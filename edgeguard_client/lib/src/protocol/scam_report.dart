/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class ScamReport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ScamReport._({
    this.id,
    required this.phoneNumber,
    required this.category,
    required this.timestamp,
    this.city,
  });

  factory ScamReport({
    int? id,
    required String phoneNumber,
    required String category,
    required DateTime timestamp,
    String? city,
  }) = _ScamReportImpl;

  factory ScamReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScamReport(
      id: jsonSerialization['id'] as int?,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      category: jsonSerialization['category'] as String,
      timestamp:
          _isc.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      city: jsonSerialization['city'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String phoneNumber;

  String category;

  DateTime timestamp;

  String? city;

  /// Returns a shallow copy of this [ScamReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ScamReport copyWith({
    int? id,
    String? phoneNumber,
    String? category,
    DateTime? timestamp,
    String? city,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScamReport',
      if (id != null) 'id': id,
      'phoneNumber': phoneNumber,
      'category': category,
      'timestamp': timestamp.toJson(),
      if (city != null) 'city': city,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScamReport',
      if (id != null) 'id': id,
      'phoneNumber': phoneNumber,
      'category': category,
      'timestamp': timestamp.toJson(),
      if (city != null) 'city': city,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScamReportImpl extends ScamReport {
  _ScamReportImpl({
    int? id,
    required String phoneNumber,
    required String category,
    required DateTime timestamp,
    String? city,
  }) : super._(
          id: id,
          phoneNumber: phoneNumber,
          category: category,
          timestamp: timestamp,
          city: city,
        );

  /// Returns a shallow copy of this [ScamReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ScamReport copyWith({
    Object? id = _Undefined,
    String? phoneNumber,
    String? category,
    DateTime? timestamp,
    Object? city = _Undefined,
  }) {
    return ScamReport(
      id: id is int? ? id : this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      category: category ?? this.category,
      timestamp: timestamp ?? this.timestamp,
      city: city is String? ? city : this.city,
    );
  }
}
