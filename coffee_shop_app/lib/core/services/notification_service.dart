import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // طلب الإذن من المستخدم
    await _fcm.requestPermission();

    // إعداد القنوات المحلية
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_stat_name');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // لما المستخدم يضغط على الإشعار المحلي
        debugPrint('Notification clicked with payload: ${response.payload}');
      },
    );

    // احصل على الـ Token (وشيله في Firestore)
    final token = await _fcm.getToken();
    debugPrint('🔥 FCM Token: $token');

    // استمع للأحداث
    _setupListeners();
  }

  void _setupListeners() {
    // عند استقبال إشعار والتطبيق مفتوح (foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('📩 Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint('Notification: ${message.notification!.title}');

        // عرض الإشعار محليًا
        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
              'coffee_shop_channel', // ID فريد للقناة
              'Coffee Shop Notifications', // اسم القناة
              importance: Importance.max,
              priority: Priority.high,
              showWhen: true,
            );

        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        await _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          platformChannelSpecifics,
          payload: message.data['route'], // لو عايز تمرر بيانات التنقل
        );
      }
    });

    // عند الضغط على الإشعار (والتطبيق في الخلفية أو مفتوح مسبقًا)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('🚀 Notification opened: ${message.notification?.title}');
      final route = message.data['route'];
      if (route != null) {
        // هنا ممكن توجه المستخدم لصفحة معينة
        debugPrint('Navigate to route: $route');
      }
    });
  }
}
