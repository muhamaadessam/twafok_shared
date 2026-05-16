import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../notifications/local_notification_helper.dart';
import '../local/cache_helper.dart';



@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
    ) async {
  // await Firebase.initializeApp();

  debugPrint(
    'Background Message: ${message.notification?.title}',
  );
}

class FirebaseNotificationHelper {
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static String? firebaseToken;

  static Future<void> init() async {
    /// Request permissions
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    /// FCM token
    firebaseToken = await firebaseMessaging.getToken();
    CacheHelper.put(key: 'firebaseToken', value: firebaseToken!);

    debugPrint('==> FCM Token: $firebaseToken');

    /// iOS foreground notification presentation
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    /// Background handler
    FirebaseMessaging.onBackgroundMessage(
      firebaseMessagingBackgroundHandler,
    );

    /// Foreground notifications
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    /// App opened from background notification
    FirebaseMessaging.onMessageOpenedApp.listen(
      _handleNotificationClick,
    );

    /// App opened from terminated notification
    final initialMessage = await firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      _handleNotificationClick(initialMessage);
    }
  }

  /// Foreground notification
  static Future<void> _handleForegroundMessage(
      RemoteMessage message,
      ) async {
    debugPrint(
      'Foreground Message: ${message.notification?.title}',
    );

    final notification = message.notification;

    if (notification == null) return;

    await LocalNotificationHelper.show(
      title: notification.title ?? '',
      body: notification.body ?? '',
      payload: message.data.toString(),
    );
  }

  /// Notification click handling
  static void _handleNotificationClick(
      RemoteMessage message,
      ) {
    debugPrint(
      'Notification Clicked: ${message.data}',
    );
  }
}
