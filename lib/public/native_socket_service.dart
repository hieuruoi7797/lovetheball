import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NativeSocketService{
  static const _channel = MethodChannel('com.splat/background');
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Connect to the socket with ID and Name
  static Future<void> connectSocket(String id, String name) async {
    try {
      await _channel.invokeMethod('showNotification', {
        'id': id,
        'name': name,
      });
      print("Socket connection started");
    } catch (e) {
      print("Error starting socket connection: $e");
    }
  }

  // Show notification when triggered by native code
  static Future<void> setupNotificationHandler() async {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'showNotification') {
        final message = call.arguments as String;
        print("Notification received: $message");
        // You can display the notification or update your UI here
      }
    });
  }

  // Emit "invite friends" event
  static Future<void> inviteFriends(String inviterId, List<String> friendIds) async {
    try {
      await _channel.invokeMethod('inviteFriends', {
        'inviterId': inviterId,
        'friendIds': friendIds,
      });
      print("Invite friends event emitted");
    } catch (e) {
      print("Error emitting invite friends: $e");
    }
  }

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings = InitializationSettings(android: androidSettings);

    await _flutterLocalNotificationsPlugin.initialize(settings);

    _channel.setMethodCallHandler((call) async {
      if (call.method == 'showNotification') {
        showNotification(call.arguments.toString());
      }
    });
  }

  static Future<void> showNotification(String message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(android: androidDetails);
    await _flutterLocalNotificationsPlugin.show(0, 'New Invite', message, details);
  }

  static Future<void> connectSocketNative() async {
    await _channel.invokeMethod('connectSocket');
  }
}

