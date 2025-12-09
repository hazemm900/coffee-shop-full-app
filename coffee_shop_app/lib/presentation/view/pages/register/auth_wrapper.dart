import 'package:coffee_shop_app/core/services/notification_service.dart';
import 'package:coffee_shop_app/presentation/view/pages/register/login_page.dart';
import 'package:coffee_shop_app/presentation/view/pages/main_layout_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final NotificationService _notificationService = NotificationService();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    // ننتظر لحين تسجيل الدخول الفعلي قبل التهيئة
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _notificationService.initialize();
    }
    setState(() {
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !_initialized) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const MainLayoutPage();
        }

        return const LoginPage();
      },
    );
  }
}
