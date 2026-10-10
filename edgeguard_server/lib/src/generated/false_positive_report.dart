/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class FalsePositiveReport
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = FalsePositiveReportTable();

  static const db = FalsePositiveReportRepository._();

  @override
  int? id;

  String messageContent;

  DateTime timestamp;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'messageContent': messageContent,
      'timestamp': timestamp.toJson(),
    };
  }

  static FalsePositiveReportInclude include() {
    return FalsePositiveReportInclude._();
  }

  static FalsePositiveReportIncludeList includeList({
    _i1.WhereExpressionBuilder<FalsePositiveReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FalsePositiveReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FalsePositiveReportTable>? orderByList,
    FalsePositiveReportInclude? include,
  }) {
    return FalsePositiveReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FalsePositiveReport.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FalsePositiveReport.t),
      include: include,
    );
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

class FalsePositiveReportTable extends _i1.Table<int?> {
  FalsePositiveReportTable({super.tableRelation})
      : super(tableName: 'false_positive_report') {
    messageContent = _i1.ColumnString(
      'messageContent',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
    );
  }

  late final _i1.ColumnString messageContent;

  late final _i1.ColumnDateTime timestamp;

  @override
  List<_i1.Column> get columns => [
        id,
        messageContent,
        timestamp,
      ];
}

class FalsePositiveReportInclude extends _i1.IncludeObject {
  FalsePositiveReportInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FalsePositiveReport.t;
}

class FalsePositiveReportIncludeList extends _i1.IncludeList {
  FalsePositiveReportIncludeList._({
    _i1.WhereExpressionBuilder<FalsePositiveReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FalsePositiveReport.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FalsePositiveReport.t;
}

class FalsePositiveReportRepository {
  const FalsePositiveReportRepository._();

  /// Returns a list of [FalsePositiveReport]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<FalsePositiveReport>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FalsePositiveReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FalsePositiveReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FalsePositiveReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FalsePositiveReport>(
      where: where?.call(FalsePositiveReport.t),
      orderBy: orderBy?.call(FalsePositiveReport.t),
      orderByList: orderByList?.call(FalsePositiveReport.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [FalsePositiveReport] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<FalsePositiveReport?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FalsePositiveReportTable>? where,
    int? offset,
    _i1.OrderByBuilder<FalsePositiveReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FalsePositiveReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<FalsePositiveReport>(
      where: where?.call(FalsePositiveReport.t),
      orderBy: orderBy?.call(FalsePositiveReport.t),
      orderByList: orderByList?.call(FalsePositiveReport.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [FalsePositiveReport] by its [id] or null if no such row exists.
  Future<FalsePositiveReport?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<FalsePositiveReport>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [FalsePositiveReport]s in the list and returns the inserted rows.
  ///
  /// The returned [FalsePositiveReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FalsePositiveReport>> insert(
    _i1.Session session,
    List<FalsePositiveReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FalsePositiveReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FalsePositiveReport] and returns the inserted row.
  ///
  /// The returned [FalsePositiveReport] will have its `id` field set.
  Future<FalsePositiveReport> insertRow(
    _i1.Session session,
    FalsePositiveReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FalsePositiveReport>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FalsePositiveReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FalsePositiveReport>> update(
    _i1.Session session,
    List<FalsePositiveReport> rows, {
    _i1.ColumnSelections<FalsePositiveReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FalsePositiveReport>(
      rows,
      columns: columns?.call(FalsePositiveReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FalsePositiveReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FalsePositiveReport> updateRow(
    _i1.Session session,
    FalsePositiveReport row, {
    _i1.ColumnSelections<FalsePositiveReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FalsePositiveReport>(
      row,
      columns: columns?.call(FalsePositiveReport.t),
      transaction: transaction,
    );
  }

  /// Deletes all [FalsePositiveReport]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FalsePositiveReport>> delete(
    _i1.Session session,
    List<FalsePositiveReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FalsePositiveReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FalsePositiveReport].
  Future<FalsePositiveReport> deleteRow(
    _i1.Session session,
    FalsePositiveReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FalsePositiveReport>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FalsePositiveReport>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FalsePositiveReportTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FalsePositiveReport>(
      where: where(FalsePositiveReport.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FalsePositiveReportTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FalsePositiveReport>(
      where: where?.call(FalsePositiveReport.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
