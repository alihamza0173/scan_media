import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'scan_media_platform_interface.dart';

/// An implementation of [ScanMediaPlatform] that uses method channels.
class ScanMediaMethodChannel extends ScanMediaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('scan_media');

  @override
  Future<void> loadMedia(String path) async {
    try {
      if (path.isEmpty) {
        throw ArgumentError('The provided media path is empty.');
      }

      // Invoke the native method
      await methodChannel.invokeMethod<void>('refreshGallery', {'path': path});
    } on PlatformException catch (e) {
      throw Exception('Failed to refresh gallery. Reason: ${e.message}');
    } on MissingPluginException catch (_) {
      throw Exception('Media scanning is not supported on this platform.');
    } catch (e) {
      throw Exception(
          'An unexpected error occurred while refreshing the gallery.');
    }
  }
}
