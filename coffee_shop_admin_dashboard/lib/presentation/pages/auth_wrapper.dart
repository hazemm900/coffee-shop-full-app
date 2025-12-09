import 'package:coffee_shop_admin_dashboard/presentation/pages/dashboard_home/dashboard_home_page.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/register/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // نستخدم StreamBuilder للاستماع لحالة تسجيل الدخول
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // الحالة 1: جاري التحقق من حالة المستخدم
        if (snapshot.connectionState == ConnectionState.waiting) {
          // أظهر شاشة تحميل بينما يتم التحقق
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // الحالة 2: تم التحقق والمستخدم مسجل دخوله
        if (snapshot.hasData) {
          // إذا كان هناك بيانات (user object)، اذهب إلى HomePage
          return const DashboardHomePage();
        }

        // الحالة 3: تم التحقق والمستخدم غير مسجل دخوله
        // إذا لم يكن هناك بيانات (user is null)، اذهب إلى LoginPage
        return const LoginPage();
      },
    );
  }
}
