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
import '../endpoints/scam_endpoint.dart' as _i2;
import '../greeting_endpoint.dart' as _i3;
import 'package:edgeguard_server/src/generated/scam_report.dart' as _i4;
import 'package:edgeguard_server/src/generated/false_positive_report.dart'
    as _i5;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'scam': _i2.ScamEndpoint()
        ..initialize(
          server,
          'scam',
          null,
        ),
      'adminDataset': _i2.AdminDatasetEndpoint()
        ..initialize(
          server,
          'adminDataset',
          null,
        ),
      'greeting': _i3.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['scam'] = _i1.EndpointConnector(
      name: 'scam',
      endpoint: endpoints['scam']!,
      methodConnectors: {
        'reportScam': _i1.MethodConnector(
          name: 'reportScam',
          params: {
            'report': _i1.ParameterDescription(
              name: 'report',
              type: _i1.getType<_i4.ScamReport>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['scam'] as _i2.ScamEndpoint).reportScam(
            session,
            params['report'],
          ),
        ),
        'reportFalsePositive': _i1.MethodConnector(
          name: 'reportFalsePositive',
          params: {
            'report': _i1.ParameterDescription(
              name: 'report',
              type: _i1.getType<_i5.FalsePositiveReport>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['scam'] as _i2.ScamEndpoint).reportFalsePositive(
            session,
            params['report'],
          ),
        ),
      },
    );
    connectors['adminDataset'] = _i1.EndpointConnector(
      name: 'adminDataset',
      endpoint: endpoints['adminDataset']!,
      methodConnectors: {
        'getVerifiedScamDataset': _i1.MethodConnector(
          name: 'getVerifiedScamDataset',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['adminDataset'] as _i2.AdminDatasetEndpoint)
                  .getVerifiedScamDataset(session),
        ),
        'getAllScamReports': _i1.MethodConnector(
          name: 'getAllScamReports',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['adminDataset'] as _i2.AdminDatasetEndpoint)
                  .getAllScamReports(session),
        ),
        'getAllFalsePositives': _i1.MethodConnector(
          name: 'getAllFalsePositives',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['adminDataset'] as _i2.AdminDatasetEndpoint)
                  .getAllFalsePositives(session),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['greeting'] as _i3.GreetingEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
  }
}
