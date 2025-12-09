import 'package:coffee_shop_admin_dashboard/core/service_locator.dart';
import 'package:coffee_shop_admin_dashboard/core/theme/app_theme.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/dashboard_home/dashboard_home_page.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/register/widgets/login_form.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/register_viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginViewModel>(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: BlocListener<LoginViewModel, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login Successful!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardHomePage()),
              );
            } else if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const _LoginLayout(),
        ),
      ),
    );
  }
}

class _LoginLayout extends StatelessWidget {
  const _LoginLayout();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        // ---------- Left side (image or branding) ----------
        if (size.width > 800)
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3E2723), Color(0xFF6D4C41)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.coffee, size: 100, color: Colors.white),
                    SizedBox(height: 20),
                    Text(
                      'Coffee Shop Admin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Manage your café efficiently ☕',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // ---------- Right side (form) ----------
        Expanded(
          flex: 3,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: const Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                margin: EdgeInsets.all(24),
                child: Padding(padding: EdgeInsets.all(32), child: LoginForm()),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
