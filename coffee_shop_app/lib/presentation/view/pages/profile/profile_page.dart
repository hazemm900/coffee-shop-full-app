import 'package:coffee_shop_app/core/service_locator.dart';
import 'package:coffee_shop_app/core/theme/app_theme.dart';
import 'package:coffee_shop_app/presentation/view/pages/my_orders/my_orders_page.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/profile_viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/loyalty_points_card.dart';
import 'widgets/profile_action_buttons.dart';
// 🧩 Widgets
import 'widgets/profile_header.dart';
import 'widgets/user_info_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileViewModel>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'My Profile',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ProfileViewModel, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is ProfileLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    /// 🧑‍💼 Header (Photo + Name + Email)
                    ProfileHeader(user: user),

                    const SizedBox(height: 20),

                    /// 🪪 Personal Info Section
                    UserInfoSection(user: user),

                    const SizedBox(height: 20),

                    /// ⭐ Loyalty Points
                    LoyaltyPointsCard(points: user.loyaltyPoints),

                    const SizedBox(height: 30),

                    /// ⚙️ Action Buttons (Orders, Edit, Logout, etc.)
                    ProfileActionButtons(
                      onOrdersPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyOrdersPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink(); // الحالة الأولية
          },
        ),
      ),
    );
  }
}
