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
import 'package:edgeguard_server/src/generated/false_positive_report.dart'
    as _ikgrqawu;
import 'package:edgeguard_server/src/generated/future_calls.dart' as _i7k77h34;
import 'package:edgeguard_server/src/generated/scam_report.dart' as _i5kk03o8;
import 'package:serverpod/serverpod.dart' as _is;
import '../endpoints/scam_endpoint.dart' as _iq50itqz;
import '../greeting_endpoint.dart' as _ikvw90o4;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'scam': _iq50itqz.ScamEndpoint()
        ..initialize(
          server,
          'scam',
          null,
        ),
      'adminDataset': _iq50itqz.AdminDatasetEndpoint()
        ..initialize(
          server,
          'adminDataset',
          null,
        ),
      'greeting': _ikvw90o4.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['scam'] = _is.EndpointConnector(
      name: 'scam',
      endpoint: endpoints['scam']!,
      methodConnectors: {
        'reportScam': _is.MethodConnector(
          name: 'reportScam',
          params: {
            'report': _is.ParameterDescription(
              name: 'report',
              type: _is.getType<_i5kk03o8.ScamReport>(),
              nullable: false,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['scam'] as _iq50itqz.ScamEndpoint).reportScam(
            session,
            params['report'],
          ),
        ),
        'reportFalsePositive': _is.MethodConnector(
          name: 'reportFalsePositive',
          params: {
            'report': _is.ParameterDescription(
              name: 'report',
              type: _is.getType<_ikgrqawu.FalsePositiveReport>(),
              nullable: false,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['scam'] as _iq50itqz.ScamEndpoint).reportFalsePositive(
            session,
            params['report'],
          ),
        ),
      },
    );
    connectors['adminDataset'] = _is.EndpointConnector(
      name: 'adminDataset',
      endpoint: endpoints['adminDataset']!,
      methodConnectors: {
        'getVerifiedScamDataset': _is.MethodConnector(
          name: 'getVerifiedScamDataset',
          params: {},
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['adminDataset'] as _iq50itqz.AdminDatasetEndpoint)
                  .getVerifiedScamDataset(session),
        ),
        'getAllScamReports': _is.MethodConnector(
          name: 'getAllScamReports',
          params: {},
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['adminDataset'] as _iq50itqz.AdminDatasetEndpoint)
                  .getAllScamReports(session),
        ),
        'getAllFalsePositives': _is.MethodConnector(
          name: 'getAllFalsePositives',
          params: {},
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['adminDataset'] as _iq50itqz.AdminDatasetEndpoint)
                  .getAllFalsePositives(session),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['greeting'] as _ikvw90o4.GreetingEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _i7k77h34.FutureCalls();
  }
}
