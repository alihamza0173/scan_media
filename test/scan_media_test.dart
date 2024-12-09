import 'package:flutter_test/flutter_test.dart';
import 'package:scan_media/scan_media.dart';
import 'package:scan_media/scan_media_platform_interface.dart';
import 'package:scan_media/scan_media_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockScanMediaPlatform
    with MockPlatformInterfaceMixin
    implements ScanMediaPlatform {
  @override
  Future<String?> loadMedia() => Future.value('42');
}

void main() {
  final ScanMediaPlatform initialPlatform = ScanMediaPlatform.instance;

  test('$MediaScanner is the default instance', () {
    expect(initialPlatform, isInstanceOf<MediaScanner>());
  });

  test('getPlatformVersion', () async {
    ScanMedia scanMediaPlugin = ScanMedia();
    MockScanMediaPlatform fakePlatform = MockScanMediaPlatform();
    ScanMediaPlatform.instance = fakePlatform;

    expect(await scanMediaPlugin.getPlatformVersion(), '42');
  });
}
