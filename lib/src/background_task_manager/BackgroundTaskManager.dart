import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackgroundTaskManager {
  static const _channel = MethodChannel('com.splat/background');

  // Call this method to start the background task
  static Future<void> startBackgroundTask() async {
    try {
      await _channel.invokeMethod('startBackgroundTask');
    } on PlatformException catch (e) {
      print('Failed to start background task: ${e.message}');
    }
  }

  // Listen for "showNotification" from Swift
  static void setupMethodCallHandler(Function onNotification) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'showNotification') {
        onNotification();
      }
    });
  }
}