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

abstract class ScamReport
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['timestamp']),
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
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ScamReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
    _i1.WhereExpressionBuilder<ScamReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScamReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScamReportTable>? orderByList,
    ScamReportInclude? include,
  }) {
    return ScamReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScamReport.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ScamReport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
  @_i1.useResult
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

class ScamReportTable extends _i1.Table<int?> {
  ScamReportTable({super.tableRelation}) : super(tableName: 'scam_report') {
    phoneNumber = _i1.ColumnString(
      'phoneNumber',
      this,
    );
    category = _i1.ColumnString(
      'category',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
    );
    city = _i1.ColumnString(
      'city',
      this,
    );
  }

  late final _i1.ColumnString phoneNumber;

  late final _i1.ColumnString category;

  late final _i1.ColumnDateTime timestamp;

  late final _i1.ColumnString city;

  @override
  List<_i1.Column> get columns => [
        id,
        phoneNumber,
        category,
        timestamp,
        city,
      ];
}

class ScamReportInclude extends _i1.IncludeObject {
  ScamReportInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ScamReport.t;
}

class ScamReportIncludeList extends _i1.IncludeList {
  ScamReportIncludeList._({
    _i1.WhereExpressionBuilder<ScamReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ScamReport.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ScamReport.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScamReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScamReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScamReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ScamReport>(
      where: where?.call(ScamReport.t),
      orderBy: orderBy?.call(ScamReport.t),
      orderByList: orderByList?.call(ScamReport.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScamReportTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScamReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScamReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ScamReport>(
      where: where?.call(ScamReport.t),
      orderBy: orderBy?.call(ScamReport.t),
      orderByList: orderByList?.call(ScamReport.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ScamReport] by its [id] or null if no such row exists.
  Future<ScamReport?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ScamReport>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ScamReport]s in the list and returns the inserted rows.
  ///
  /// The returned [ScamReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ScamReport>> insert(
    _i1.Session session,
    List<ScamReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ScamReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ScamReport] and returns the inserted row.
  ///
  /// The returned [ScamReport] will have its `id` field set.
  Future<ScamReport> insertRow(
    _i1.Session session,
    ScamReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ScamReport>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ScamReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ScamReport>> update(
    _i1.Session session,
    List<ScamReport> rows, {
    _i1.ColumnSelections<ScamReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ScamReport>(
      rows,
      columns: columns?.call(ScamReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScamReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ScamReport> updateRow(
    _i1.Session session,
    ScamReport row, {
    _i1.ColumnSelections<ScamReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ScamReport>(
      row,
      columns: columns?.call(ScamReport.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ScamReport]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ScamReport>> delete(
    _i1.Session session,
    List<ScamReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ScamReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ScamReport].
  Future<ScamReport> deleteRow(
    _i1.Session session,
    ScamReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ScamReport>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ScamReport>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ScamReportTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ScamReport>(
      where: where(ScamReport.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScamReportTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ScamReport>(
      where: where?.call(ScamReport.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
