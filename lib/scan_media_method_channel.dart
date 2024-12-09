import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'scan_media_platform_interface.dart';

/// An implementation of [ScanMediaPlatform] that uses method channels.
class MediaScanner extends ScanMediaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('scan_media');

  @override
  Future<String?> loadMedia() async {
    final version = await methodChannel.invokeMethod<String>('refreshGallery');
    return version;
  }
}
