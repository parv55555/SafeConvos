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
import 'package:serverpod/serverpod.dart' as _is;

abstract class FalsePositiveReport
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          _is.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
    );
  }

  static final t = FalsePositiveReportTable();

  static const db = FalsePositiveReportRepository._();

  @override
  int? id;

  String messageContent;

  DateTime timestamp;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FalsePositiveReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FalsePositiveReport copyWith({
    int? id,
    String? messageContent,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FalsePositiveReport',
      if (id != null) 'id': id,
      'messageContent': messageContent,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FalsePositiveReport',
      if (id != null) 'id': id,
      'messageContent': messageContent,
      'timestamp': timestamp.toJson(),
    };
  }

  static FalsePositiveReportInclude include() {
    return FalsePositiveReportInclude._();
  }

  static FalsePositiveReportIncludeList includeList({
    _is.WhereExpressionBuilder<FalsePositiveReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FalsePositiveReportTable>? orderBy,
    _is.OrderByListBuilder<FalsePositiveReportTable>? orderByList,
    FalsePositiveReportInclude? include,
  }) {
    return FalsePositiveReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FalsePositiveReport.t),
      orderByList: orderByList?.call(FalsePositiveReport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class FalsePositiveReportUpdateTable
    extends _is.UpdateTable<FalsePositiveReportTable> {
  FalsePositiveReportUpdateTable(super.table);

  _is.ColumnValue<String, String> messageContent(String value) =>
      _is.ColumnValue(
        table.messageContent,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _is.ColumnValue(
        table.timestamp,
        value,
      );
}

class FalsePositiveReportTable extends _is.Table<int?> {
  FalsePositiveReportTable({super.tableRelation})
      : super(tableName: 'false_positive_report') {
    updateTable = FalsePositiveReportUpdateTable(this);
    messageContent = _is.ColumnString(
      'messageContent',
      this,
    );
    timestamp = _is.ColumnDateTime(
      'timestamp',
      this,
    );
  }

  late final FalsePositiveReportUpdateTable updateTable;

  late final _is.ColumnString messageContent;

  late final _is.ColumnDateTime timestamp;

  @override
  List<_is.Column> get columns => [
        id,
        messageContent,
        timestamp,
      ];
}

class FalsePositiveReportInclude extends _is.IncludeObject {
  FalsePositiveReportInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FalsePositiveReport.t;
}

class FalsePositiveReportIncludeList extends _is.IncludeList {
  FalsePositiveReportIncludeList._({
    _is.WhereExpressionBuilder<FalsePositiveReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FalsePositiveReport.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FalsePositiveReport.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FalsePositiveReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FalsePositiveReportTable>? orderBy,
    _is.OrderByListBuilder<FalsePositiveReportTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FalsePositiveReport>(
      where: where?.call(FalsePositiveReport.t),
      orderBy: orderBy?.call(FalsePositiveReport.t),
      orderByList: orderByList?.call(FalsePositiveReport.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FalsePositiveReportTable>? where,
    int? offset,
    _is.OrderByBuilder<FalsePositiveReportTable>? orderBy,
    _is.OrderByListBuilder<FalsePositiveReportTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FalsePositiveReport>(
      where: where?.call(FalsePositiveReport.t),
      orderBy: orderBy?.call(FalsePositiveReport.t),
      orderByList: orderByList?.call(FalsePositiveReport.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FalsePositiveReport] by its [id] or null if no such row exists.
  Future<FalsePositiveReport?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FalsePositiveReport>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FalsePositiveReport]s in the list and returns the inserted rows.
  ///
  /// The returned [FalsePositiveReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FalsePositiveReport>> insert(
    _is.DatabaseSession session,
    List<FalsePositiveReport> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FalsePositiveReport>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FalsePositiveReport] and returns the inserted row.
  ///
  /// The returned [FalsePositiveReport] will have its `id` field set.
  Future<FalsePositiveReport> insertRow(
    _is.DatabaseSession session,
    FalsePositiveReport row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FalsePositiveReport>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FalsePositiveReport]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [FalsePositiveReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FalsePositiveReport>> upsert(
    _is.DatabaseSession session,
    List<FalsePositiveReport> rows, {
    required _is.ColumnSelections<FalsePositiveReportTable> conflictColumns,
    _is.ColumnSelections<FalsePositiveReportTable>? updateColumns,
    _is.WhereExpressionBuilder<FalsePositiveReportTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FalsePositiveReport>(
      rows,
      conflictColumns: conflictColumns(FalsePositiveReport.t),
      updateColumns: updateColumns?.call(FalsePositiveReport.t),
      updateWhere: updateWhere?.call(FalsePositiveReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FalsePositiveReport] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [FalsePositiveReport] will have its `id` field set.
  Future<FalsePositiveReport?> upsertRow(
    _is.DatabaseSession session,
    FalsePositiveReport row, {
    required _is.ColumnSelections<FalsePositiveReportTable> conflictColumns,
    _is.ColumnSelections<FalsePositiveReportTable>? updateColumns,
    _is.WhereExpressionBuilder<FalsePositiveReportTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FalsePositiveReport>(
      row,
      conflictColumns: conflictColumns(FalsePositiveReport.t),
      updateColumns: updateColumns?.call(FalsePositiveReport.t),
      updateWhere: updateWhere?.call(FalsePositiveReport.t),
      transaction: transaction,
    );
  }

  /// Updates all [FalsePositiveReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FalsePositiveReport>> update(
    _is.DatabaseSession session,
    List<FalsePositiveReport> rows, {
    _is.ColumnSelections<FalsePositiveReportTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FalsePositiveReport>(
      rows,
      columns: columns?.call(FalsePositiveReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FalsePositiveReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FalsePositiveReport> updateRow(
    _is.DatabaseSession session,
    FalsePositiveReport row, {
    _is.ColumnSelections<FalsePositiveReportTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FalsePositiveReport>(
      row,
      columns: columns?.call(FalsePositiveReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FalsePositiveReport] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FalsePositiveReport?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FalsePositiveReportUpdateTable>
        columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FalsePositiveReport>(
      id,
      columnValues: columnValues(FalsePositiveReport.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FalsePositiveReport]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FalsePositiveReport>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FalsePositiveReportUpdateTable>
        columnValues,
    required _is.WhereExpressionBuilder<FalsePositiveReportTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FalsePositiveReportTable>? orderBy,
    _is.OrderByListBuilder<FalsePositiveReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FalsePositiveReport>(
      columnValues: columnValues(FalsePositiveReport.t.updateTable),
      where: where(FalsePositiveReport.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FalsePositiveReport.t),
      orderByList: orderByList?.call(FalsePositiveReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FalsePositiveReport]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FalsePositiveReport>> delete(
    _is.DatabaseSession session,
    List<FalsePositiveReport> rows, {
    _is.OrderByBuilder<FalsePositiveReportTable>? orderBy,
    _is.OrderByListBuilder<FalsePositiveReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FalsePositiveReport>(
      rows,
      orderBy: orderBy?.call(FalsePositiveReport.t),
      orderByList: orderByList?.call(FalsePositiveReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FalsePositiveReport].
  Future<FalsePositiveReport> deleteRow(
    _is.DatabaseSession session,
    FalsePositiveReport row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FalsePositiveReport>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FalsePositiveReport>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FalsePositiveReportTable> where,
    _is.OrderByBuilder<FalsePositiveReportTable>? orderBy,
    _is.OrderByListBuilder<FalsePositiveReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FalsePositiveReport>(
      where: where(FalsePositiveReport.t),
      orderBy: orderBy?.call(FalsePositiveReport.t),
      orderByList: orderByList?.call(FalsePositiveReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FalsePositiveReportTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FalsePositiveReport>(
      where: where?.call(FalsePositiveReport.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FalsePositiveReport] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FalsePositiveReportTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FalsePositiveReport>(
      where: where(FalsePositiveReport.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
