import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scan_media/scan_media.dart';
import 'package:scan_media/src/scan_media_platform_interface.dart';
import 'package:scan_media/src/scan_media_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockScanMediaPlatform
    with MockPlatformInterfaceMixin
    implements ScanMediaPlatform {
  @override
  Future<void> loadMedia(String path) async {
    debugPrint('Mock loadMedia completed successfully for path: $path');
  }
}

class MockErrorScanMediaPlatform
    with MockPlatformInterfaceMixin
    implements ScanMediaPlatform {
  @override
  Future<void> loadMedia(String path) async {
    throw Exception('Mock error: Failed to scan media.');
  }
}

void main() {
  final ScanMediaPlatform initialPlatform = ScanMediaPlatform.instance;

  test('$ScanMediaMethodChannel is the default instance', () {
    expect(initialPlatform, isInstanceOf<ScanMediaMethodChannel>());
  });

  test('scanMedia completes successfully', () async {
    ScanMedia scanMediaPlugin = ScanMedia();
    MockScanMediaPlatform fakePlatform = MockScanMediaPlatform();
    ScanMediaPlatform.instance = fakePlatform;

    // Expect the method to complete without throwing an error
    expect(
        () async => await scanMediaPlugin.scan('/valid/path'), returnsNormally);
  });

  test('scanMedia throws an error for invalid path', () async {
    ScanMedia scanMediaPlugin = ScanMedia();
    MockErrorScanMediaPlatform errorPlatform = MockErrorScanMediaPlatform();
    ScanMediaPlatform.instance = errorPlatform;

    // Expect the method to throw an error
    expect(() async => await scanMediaPlugin.scan('/invalid/path'),
        throwsException);
  });
}
