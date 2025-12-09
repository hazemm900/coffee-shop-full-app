import 'package:coffee_shop_app/core/service_locator.dart';
import 'package:coffee_shop_app/presentation/view/pages/register/auth_wrapper.dart';
import 'package:coffee_shop_app/presentation/view/pages/cart/cart_page.dart';
import 'package:coffee_shop_app/presentation/view/pages/home/home_page.dart';
import 'package:coffee_shop_app/presentation/view/pages/profile/profile_page.dart';
import 'package:coffee_shop_app/presentation/view/pages/settings/settings_page.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/home_viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayoutPage extends StatefulWidget {
  const MainLayoutPage({super.key});

  @override
  State<MainLayoutPage> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    CartPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => sl<HomeViewModel>(),
      child: BlocListener<HomeViewModel, HomeState>(
        listener: (context, state) {
          if (state.isLogoutSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AuthWrapper()),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: Scaffold(
          body: IndexedStack(index: _selectedIndex, children: _pages),

          // ✅ Bottom Navigation Bar
          bottomNavigationBar: Container(
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor:
                  theme.bottomNavigationBarTheme.backgroundColor ??
                  (isDark ? const Color(0xFF3E2C2C) : Color(0xFFFAF6F2)),

              selectedItemColor:
                  theme.bottomNavigationBarTheme.selectedItemColor ??
                  theme.colorScheme.primary,
              unselectedItemColor:
                  theme.bottomNavigationBarTheme.unselectedItemColor ??
                  Colors.grey,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
