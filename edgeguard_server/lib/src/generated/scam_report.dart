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

abstract class ScamReport
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          _is.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
      city: jsonSerialization['city'] as String?,
    );
  }

  static final t = ScamReportTable();

  static const db = ScamReportRepository._();

  @override
  int? id;

  String phoneNumber;

  String category;

  DateTime timestamp;

  String? city;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ScamReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static ScamReportInclude include() {
    return ScamReportInclude._();
  }

  static ScamReportIncludeList includeList({
    _is.WhereExpressionBuilder<ScamReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ScamReportTable>? orderBy,
    _is.OrderByListBuilder<ScamReportTable>? orderByList,
    ScamReportInclude? include,
  }) {
    return ScamReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScamReport.t),
      orderByList: orderByList?.call(ScamReport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class ScamReportUpdateTable extends _is.UpdateTable<ScamReportTable> {
  ScamReportUpdateTable(super.table);

  _is.ColumnValue<String, String> phoneNumber(String value) => _is.ColumnValue(
        table.phoneNumber,
        value,
      );

  _is.ColumnValue<String, String> category(String value) => _is.ColumnValue(
        table.category,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _is.ColumnValue(
        table.timestamp,
        value,
      );

  _is.ColumnValue<String, String> city(String? value) => _is.ColumnValue(
        table.city,
        value,
      );
}

class ScamReportTable extends _is.Table<int?> {
  ScamReportTable({super.tableRelation}) : super(tableName: 'scam_report') {
    updateTable = ScamReportUpdateTable(this);
    phoneNumber = _is.ColumnString(
      'phoneNumber',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    timestamp = _is.ColumnDateTime(
      'timestamp',
      this,
    );
    city = _is.ColumnString(
      'city',
      this,
    );
  }

  late final ScamReportUpdateTable updateTable;

  late final _is.ColumnString phoneNumber;

  late final _is.ColumnString category;

  late final _is.ColumnDateTime timestamp;

  late final _is.ColumnString city;

  @override
  List<_is.Column> get columns => [
        id,
        phoneNumber,
        category,
        timestamp,
        city,
      ];
}

class ScamReportInclude extends _is.IncludeObject {
  ScamReportInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ScamReport.t;
}

class ScamReportIncludeList extends _is.IncludeList {
  ScamReportIncludeList._({
    _is.WhereExpressionBuilder<ScamReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ScamReport.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ScamReport.t;
}

class ScamReportRepository {
  const ScamReportRepository._();

  /// Returns a list of [ScamReport]s matching the given query parameters.
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
  Future<List<ScamReport>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ScamReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ScamReportTable>? orderBy,
    _is.OrderByListBuilder<ScamReportTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ScamReport>(
      where: where?.call(ScamReport.t),
      orderBy: orderBy?.call(ScamReport.t),
      orderByList: orderByList?.call(ScamReport.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ScamReport] matching the given query parameters.
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
  Future<ScamReport?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ScamReportTable>? where,
    int? offset,
    _is.OrderByBuilder<ScamReportTable>? orderBy,
    _is.OrderByListBuilder<ScamReportTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ScamReport>(
      where: where?.call(ScamReport.t),
      orderBy: orderBy?.call(ScamReport.t),
      orderByList: orderByList?.call(ScamReport.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ScamReport] by its [id] or null if no such row exists.
  Future<ScamReport?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ScamReport>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ScamReport]s in the list and returns the inserted rows.
  ///
  /// The returned [ScamReport]s will have their `id` fields set.
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
  Future<List<ScamReport>> insert(
    _is.DatabaseSession session,
    List<ScamReport> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ScamReport>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ScamReport] and returns the inserted row.
  ///
  /// The returned [ScamReport] will have its `id` field set.
  Future<ScamReport> insertRow(
    _is.DatabaseSession session,
    ScamReport row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ScamReport>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ScamReport]s in the list and returns the resulting rows.
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
  /// The returned [ScamReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ScamReport>> upsert(
    _is.DatabaseSession session,
    List<ScamReport> rows, {
    required _is.ColumnSelections<ScamReportTable> conflictColumns,
    _is.ColumnSelections<ScamReportTable>? updateColumns,
    _is.WhereExpressionBuilder<ScamReportTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ScamReport>(
      rows,
      conflictColumns: conflictColumns(ScamReport.t),
      updateColumns: updateColumns?.call(ScamReport.t),
      updateWhere: updateWhere?.call(ScamReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ScamReport] and returns the resulting row.
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
  /// The returned [ScamReport] will have its `id` field set.
  Future<ScamReport?> upsertRow(
    _is.DatabaseSession session,
    ScamReport row, {
    required _is.ColumnSelections<ScamReportTable> conflictColumns,
    _is.ColumnSelections<ScamReportTable>? updateColumns,
    _is.WhereExpressionBuilder<ScamReportTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ScamReport>(
      row,
      conflictColumns: conflictColumns(ScamReport.t),
      updateColumns: updateColumns?.call(ScamReport.t),
      updateWhere: updateWhere?.call(ScamReport.t),
      transaction: transaction,
    );
  }

  /// Updates all [ScamReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ScamReport>> update(
    _is.DatabaseSession session,
    List<ScamReport> rows, {
    _is.ColumnSelections<ScamReportTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ScamReport>(
      rows,
      columns: columns?.call(ScamReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ScamReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ScamReport> updateRow(
    _is.DatabaseSession session,
    ScamReport row, {
    _is.ColumnSelections<ScamReportTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ScamReport>(
      row,
      columns: columns?.call(ScamReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScamReport] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ScamReport?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ScamReportUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ScamReport>(
      id,
      columnValues: columnValues(ScamReport.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ScamReport]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ScamReport>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ScamReportUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ScamReportTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ScamReportTable>? orderBy,
    _is.OrderByListBuilder<ScamReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ScamReport>(
      columnValues: columnValues(ScamReport.t.updateTable),
      where: where(ScamReport.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScamReport.t),
      orderByList: orderByList?.call(ScamReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ScamReport]s in the list and returns the deleted rows.
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
  Future<List<ScamReport>> delete(
    _is.DatabaseSession session,
    List<ScamReport> rows, {
    _is.OrderByBuilder<ScamReportTable>? orderBy,
    _is.OrderByListBuilder<ScamReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ScamReport>(
      rows,
      orderBy: orderBy?.call(ScamReport.t),
      orderByList: orderByList?.call(ScamReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ScamReport].
  Future<ScamReport> deleteRow(
    _is.DatabaseSession session,
    ScamReport row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ScamReport>(
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
  Future<List<ScamReport>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ScamReportTable> where,
    _is.OrderByBuilder<ScamReportTable>? orderBy,
    _is.OrderByListBuilder<ScamReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ScamReport>(
      where: where(ScamReport.t),
      orderBy: orderBy?.call(ScamReport.t),
      orderByList: orderByList?.call(ScamReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ScamReportTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ScamReport>(
      where: where?.call(ScamReport.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ScamReport] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ScamReportTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ScamReport>(
      where: where(ScamReport.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
