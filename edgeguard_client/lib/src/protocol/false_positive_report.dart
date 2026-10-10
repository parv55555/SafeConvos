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

abstract class FalsePositiveReport implements _i1.SerializableModel {
  FalsePositiveReport._({
    this.id,
    required this.messageContent,
    required this.timestamp,
  });

  factory FalsePositiveReport({
    int? id,
    required String messageContent,
    required DateTime timestamp,
  }) = _FalsePositiveReportImpl;

  factory FalsePositiveReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return FalsePositiveReport(
      id: jsonSerialization['id'] as int?,
      messageContent: jsonSerialization['messageContent'] as String,
      timestamp:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String messageContent;

  DateTime timestamp;

  /// Returns a shallow copy of this [FalsePositiveReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FalsePositiveReport copyWith({
    int? id,
    String? messageContent,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'messageContent': messageContent,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FalsePositiveReportImpl extends FalsePositiveReport {
  _FalsePositiveReportImpl({
    int? id,
    required String messageContent,
    required DateTime timestamp,
  }) : super._(
          id: id,
          messageContent: messageContent,
          timestamp: timestamp,
        );

  /// Returns a shallow copy of this [FalsePositiveReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FalsePositiveReport copyWith({
    Object? id = _Undefined,
    String? messageContent,
    DateTime? timestamp,
  }) {
    return FalsePositiveReport(
      id: id is int? ? id : this.id,
      messageContent: messageContent ?? this.messageContent,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
