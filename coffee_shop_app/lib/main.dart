import 'package:coffee_shop_app/core/service_locator.dart';
import 'package:coffee_shop_app/core/theme/app_theme.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/cart_viewmodel/cart_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/cart_viewmodel/checkout_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/home_viewmodel/home_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/profile_viewmodel/profile_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/settings_viewmodel/settings_viewmodel.dart';
import 'package:coffee_shop_app/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  setupServiceLocator(prefs: prefs);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SettingsViewModel>()),
        BlocProvider(create: (_) => sl<CartViewModel>()),
        BlocProvider(create: (_) => sl<CheckoutViewModel>()),
        BlocProvider(create: (_) => sl<ProfileViewModel>()),
        BlocProvider(create: (_) => sl<HomeViewModel>()),
      ],
      child: BlocBuilder<SettingsViewModel, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Coffee Shop',
            debugShowCheckedModeBanner: false,

            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
