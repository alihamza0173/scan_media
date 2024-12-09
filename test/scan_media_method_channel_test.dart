import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scan_media/scan_media_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MediaScanner platform = MediaScanner();
  const MethodChannel channel = MethodChannel('scan_media');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.loadMedia(), '42');
  });
}
