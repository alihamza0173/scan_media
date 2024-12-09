import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'scan_media_method_channel.dart';

abstract class ScanMediaPlatform extends PlatformInterface {
  /// Constructs a ScanMediaPlatform.
  ScanMediaPlatform() : super(token: _token);

  static final Object _token = Object();

  static ScanMediaPlatform _instance = MediaScanner();

  /// The default instance of [ScanMediaPlatform] to use.
  ///
  /// Defaults to [MediaScanner].
  static ScanMediaPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ScanMediaPlatform] when
  /// they register themselves.
  static set instance(ScanMediaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> loadMedia() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
