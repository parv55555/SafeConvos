import 'package:edgeguard_client/edgeguard_client.dart';

void main() async {
  print('=============================================');
  print('   SafeConvos Threat Intelligence Cleaner    ');
  print('=============================================');
  print('Connecting to Serverpod Cloud backend...');
  final client = Client('https://safeconvos.api.serverpod.space/');
  try {
    print('Wiping all scam reports and false positives...');
    await client.adminDataset.clearAllReports();
    print('');
    print('[SUCCESS] All past threat entries have been wiped!');
    print('The live threat intelligence dashboard is now clean.');
    print('');
  } catch (e) {
    print('');
    print('[ERROR] Could not wipe database: ' + e.toString());
    print('');
  } finally {
    client.close();
  }
}
