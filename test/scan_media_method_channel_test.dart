import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scan_media/src/scan_media_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ScanMediaMethodChannel platform = ScanMediaMethodChannel();
  const MethodChannel channel = MethodChannel('scan_media');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'refreshGallery') {
          // Simulate successful method call
          return;
        }
        throw PlatformException(
          code: 'METHOD_NOT_FOUND',
          message: 'Method not implemented',
        );
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('loadMedia completes successfully', () async {
    expect(
      () async => await platform.loadMedia('/valid/path'),
      returnsNormally,
    );
  });

  test('loadMedia throws PlatformException on unknown method', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        // Simulate unknown method error
        throw PlatformException(
          code: 'METHOD_NOT_FOUND',
          message: 'Method not implemented',
        );
      },
    );

    expect(
      () async => await platform.loadMedia('/valid/path'),
      throwsA(isA<PlatformException>()),
    );
  });
}
