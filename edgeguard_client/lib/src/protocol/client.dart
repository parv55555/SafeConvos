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
import 'dart:async' as _ida;
import 'package:edgeguard_client/src/protocol/false_positive_report.dart'
    as _ip23wwz2;
import 'package:edgeguard_client/src/protocol/greeting.dart' as _it96b0ao;
import 'package:edgeguard_client/src/protocol/scam_report.dart' as _ibgps2n3;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// {@category Endpoint}
class EndpointScam extends _isc.EndpointRef {
  EndpointScam(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'scam';

  /// Submits an anonymous report for a scam number (Silently called by the app)
  _ida.Future<void> reportScam(_ibgps2n3.ScamReport report) =>
      caller.callServerEndpoint<void>(
        'scam',
        'reportScam',
        {'report': report},
      );

  /// Submits an anonymous report for a false positive message (User clicked "Not a Scam")
  _ida.Future<void> reportFalsePositive(_ip23wwz2.FalsePositiveReport report) =>
      caller.callServerEndpoint<void>(
        'scam',
        'reportFalsePositive',
        {'report': report},
      );
}

/// A separate endpoint specifically for the Cyber Cell / Admin to pull datasets.
/// This would be protected by authentication in a real scenario.
/// {@category Endpoint}
class EndpointAdminDataset extends _isc.EndpointRef {
  EndpointAdminDataset(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminDataset';

  /// Compiles a backend dataset of numbers reported > 5 times.
  _ida.Future<List<String>> getVerifiedScamDataset() =>
      caller.callServerEndpoint<List<String>>(
        'adminDataset',
        'getVerifiedScamDataset',
        {},
      );

  /// Fetches all raw scam reports
  _ida.Future<List<_ibgps2n3.ScamReport>> getAllScamReports() =>
      caller.callServerEndpoint<List<_ibgps2n3.ScamReport>>(
        'adminDataset',
        'getAllScamReports',
        {},
      );

  /// Fetches all false positive reports
  _ida.Future<List<_ip23wwz2.FalsePositiveReport>> getAllFalsePositives() =>
      caller.callServerEndpoint<List<_ip23wwz2.FalsePositiveReport>>(
        'adminDataset',
        'getAllFalsePositives',
        {},
      );

  /// Clears all past threat intelligence entries (scam reports and false positives)
  _ida.Future<void> clearAllReports() => caller.callServerEndpoint<void>(
        'adminDataset',
        'clearAllReports',
        {},
      );

  /// Deletes a single scam report by ID
  _ida.Future<void> deleteScamReport(int id) => caller.callServerEndpoint<void>(
        'adminDataset',
        'deleteScamReport',
        {'id': id},
      );

  /// Deletes a single false positive report by ID
  _ida.Future<void> deleteFalsePositive(int id) =>
      caller.callServerEndpoint<void>(
        'adminDataset',
        'deleteFalsePositive',
        {'id': id},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_it96b0ao.Greeting> hello(String name) =>
      caller.callServerEndpoint<_it96b0ao.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
          host,
          _il2as5qe.Protocol(),
          securityContext: securityContext,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
          httpClientOverride: httpClientOverride,
        ) {
    scam = EndpointScam(this);
    adminDataset = EndpointAdminDataset(this);
    greeting = EndpointGreeting(this);
  }

  late final EndpointScam scam;

  late final EndpointAdminDataset adminDataset;

  late final EndpointGreeting greeting;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
        'scam': scam,
        'adminDataset': adminDataset,
        'greeting': greeting,
      };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {};
}
