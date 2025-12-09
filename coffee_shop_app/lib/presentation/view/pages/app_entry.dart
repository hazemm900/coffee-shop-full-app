import 'package:coffee_shop_app/presentation/view/pages/register/auth_wrapper.dart';
import 'package:coffee_shop_app/presentation/view/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/service_locator.dart';

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  late Future<bool> _hasSeenOnboardingFuture;

  @override
  void initState() {
    super.initState();
    _hasSeenOnboardingFuture = _checkOnboardingStatus();
  }

  Future<bool> _checkOnboardingStatus() async {
    final prefs = sl<SharedPreferences>();
    return prefs.getBool('hasSeenOnboarding') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasSeenOnboardingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          // إذا شاهد الـ onboarding، اذهب للـ AuthWrapper
          return const AuthWrapper();
        } else {
          // إذا لم يشاهده، اذهب للـ OnboardingPage
          return const OnboardingPage();
        }
      },
    );
  }
}
