package com.example.scan_media

import android.content.Context
import android.content.Intent
import android.media.MediaScannerConnection
import android.net.Uri
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

/** ScanMediaPlugin */
class ScanMediaPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will be used for communication between Flutter and native Android
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "scan_media")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "refreshGallery") {
      val path: String? = call.argument("path")
      if (path != null) {
        result.success(refreshMedia(path))
      } else {
        result.error("INVALID_ARGUMENT", "Path argument is required", null)
      }
    } else {
      result.notImplemented()
    }
  }

  /// Function to refresh the media on Android Device (scan a specific file or directory)
  private fun refreshMedia(path: String): String {
    return try {
      val file = File(path)
      if (!file.exists()) {
        throw IllegalArgumentException("The file or directory does not exist")
      }
      
      // If Android version is lower than 29 (before scoped storage)
      if (android.os.Build.VERSION.SDK_INT < 29) {
        context.sendBroadcast(Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.fromFile(file)))
      } else {
        // For Android 10 and above, using MediaScannerConnection
        MediaScannerConnection.scanFile(context, arrayOf(file.toString()), null) { _, uri ->
          // Callback when the file is scanned
          Log.d("MediaScanner", "Scanned: $uri")
        }
      }
      Log.d("ScanMediaPlugin", "Success: Scanned file at $path")
      "Successfully scanned file: $path"
    } catch (e: Exception) {
      Log.e("ScanMediaPlugin", "Error: ${e.message}")
      "Error scanning file: ${e.message}"
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
