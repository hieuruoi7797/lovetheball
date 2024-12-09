import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackgroundTaskManager {
  static const _channel = MethodChannel('com.splat/background');

  // Call this method to start the background task
  static Future<void> startBackgroundTask(String id, String name) async {
    print("hieutt_checkstart");
    try {
      await _channel.invokeMethod('startBackgroundTask',
        {
          "id": "086f07e7-48bd-4c9b-b602-87049d6cf054",
          "name": "Pham Trung Hieu 1"
        }
      );
    } on PlatformException catch (e) {
      print('Failed to start background task: ${e.message}');
    }
  }

  // Listen for "showNotification" from Swift
  static void setupMethodCallHandler(Function(MethodCall call) onNotification) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'showNotification') {
        onNotification(call);
      }
    });
  }
}