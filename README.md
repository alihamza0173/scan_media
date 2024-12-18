
# Scan Media

The `scan_media` plugin is designed for Android devices to refresh and rescan media files (like images, videos, and other media) in the gallery. This library helps you refresh the gallery after saving media like photos and videos. You need to do this to make your photo/video show in the gallery without rebooting your phone.

## Features

- **Refresh Gallery**: Trigger a scan to refresh the gallery after adding or modifying media files like photos and videos.
- **Android Only**: This plugin works only on Android devices.
- **Simple API**: Easy-to-use API for triggering the media scan operation.

## Installation

To use the `scan_media` plugin, add it to your `pubspec.yaml` file:

```yaml
  scan_media:
    git:
      url: https://github.com/alihamza0173/scan_media
      ref: master
``` 

Then, run the following command to fetch the package:

```dart
flutter pub get
```

## Usage
To use the plugin in your Dart file, import it:
```dart
import 'package:scan_media/scan_media.dart';
```

## Scan Media
After saving a photo or video, you can use the `scan` method to refresh the gallery and make your media appear:
```dart
ScanMedia scanMedia = ScanMedia();

// Trigger a scan for a given media path
await scanMedia.scan('/path/to/media');
```

## Error Handling
If an error occurs (e.g., invalid path or platform issues), an error will be thrown. Make sure to handle errors properly:

```dart
try {
  await scanMedia.scan('/path/to/media');
} catch (e) {
  print('Error scanning media: $e');
}
```
