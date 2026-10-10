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
import 'dart:async' as _i2;
import 'package:edgeguard_client/src/protocol/scam_report.dart' as _i3;
import 'package:edgeguard_client/src/protocol/false_positive_report.dart'
    as _i4;
import 'package:edgeguard_client/src/protocol/greeting.dart' as _i5;
import 'protocol.dart' as _i6;

/// {@category Endpoint}
class EndpointScam extends _i1.EndpointRef {
  EndpointScam(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'scam';

  /// Submits an anonymous report for a scam number (Silently called by the app)
  _i2.Future<void> reportScam(_i3.ScamReport report) =>
      caller.callServerEndpoint<void>(
        'scam',
        'reportScam',
        {'report': report},
      );

  /// Submits an anonymous report for a false positive message (User clicked "Not a Scam")
  _i2.Future<void> reportFalsePositive(_i4.FalsePositiveReport report) =>
      caller.callServerEndpoint<void>(
        'scam',
        'reportFalsePositive',
        {'report': report},
      );
}

/// A separate endpoint specifically for the Cyber Cell / Admin to pull datasets.
/// This would be protected by authentication in a real scenario.
/// {@category Endpoint}
class EndpointAdminDataset extends _i1.EndpointRef {
  EndpointAdminDataset(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminDataset';

  /// Compiles a backend dataset of numbers reported > 5 times.
  _i2.Future<List<String>> getVerifiedScamDataset() =>
      caller.callServerEndpoint<List<String>>(
        'adminDataset',
        'getVerifiedScamDataset',
        {},
      );

  /// Fetches all raw scam reports
  _i2.Future<List<_i3.ScamReport>> getAllScamReports() =>
      caller.callServerEndpoint<List<_i3.ScamReport>>(
        'adminDataset',
        'getAllScamReports',
        {},
      );

  /// Fetches all false positive reports
  _i2.Future<List<_i4.FalsePositiveReport>> getAllFalsePositives() =>
      caller.callServerEndpoint<List<_i4.FalsePositiveReport>>(
        'adminDataset',
        'getAllFalsePositives',
        {},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i5.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i5.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i6.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    scam = EndpointScam(this);
    adminDataset = EndpointAdminDataset(this);
    greeting = EndpointGreeting(this);
  }

  late final EndpointScam scam;

  late final EndpointAdminDataset adminDataset;

  late final EndpointGreeting greeting;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'scam': scam,
        'adminDataset': adminDataset,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
