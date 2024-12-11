import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splat_mobile/public/share_prefer.dart';
import 'package:splat_mobile/src/models/player_model.dart';

class BackgroundTaskManager {
  static const _channel = MethodChannel('com.splat/background');

  // Call this method to start the background task
  static Future<void> startBackgroundTask(String id, String name) async {
    PlayerModel userInfo = await SharePreferUtils.getUserInfo();

    try {
      await _channel.invokeMethod('startBackgroundTask',
        {
          "id": userInfo.id,
          "name": userInfo.name
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