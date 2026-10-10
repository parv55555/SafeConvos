import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ScamEndpoint extends Endpoint {
  
  /// Submits an anonymous report for a scam number (Silently called by the app)
  Future<void> reportScam(Session session, ScamReport report) async {
    report.timestamp = DateTime.now().toUtc();
    await ScamReport.db.insertRow(session, report);
  }
  
  /// Submits an anonymous report for a false positive message (User clicked "Not a Scam")
  Future<void> reportFalsePositive(Session session, FalsePositiveReport report) async {
    report.timestamp = DateTime.now().toUtc();
    await FalsePositiveReport.db.insertRow(session, report);
  }
}

/// A separate endpoint specifically for the Cyber Cell / Admin to pull datasets.
/// This would be protected by authentication in a real scenario.
class AdminDatasetEndpoint extends Endpoint {
  
  /// Compiles a backend dataset of numbers reported > 5 times.
  Future<List<String>> getVerifiedScamDataset(Session session) async {
    var query = '''
      SELECT "phoneNumber"
      FROM scam_report
      GROUP BY "phoneNumber"
      HAVING COUNT(*) > 5
      ORDER BY COUNT(*) DESC
    ''';

    var results = await session.db.unsafeQuery(query);
    
    List<String> verifiedNumbers = [];
    for (var row in results) {
      if (row.isNotEmpty) {
        verifiedNumbers.add(row[0].toString());
      }
    }
    return verifiedNumbers;
  }
  
  /// Fetches all raw scam reports
  Future<List<ScamReport>> getAllScamReports(Session session) async {
    return await ScamReport.db.find(
      session,
      orderBy: (t) => t.timestamp,
    );
  }

  /// Fetches all false positive reports
  Future<List<FalsePositiveReport>> getAllFalsePositives(Session session) async {
    return await FalsePositiveReport.db.find(
      session,
      orderBy: (t) => t.timestamp,
    );
  }
}

