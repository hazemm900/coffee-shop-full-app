import 'package:coffee_shop_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_data/entities/user.dart';

/// 🪪 UserInfoSection
/// - Displays personal details in modern info cards.
class UserInfoSection extends StatelessWidget {
  final User user;
  const UserInfoSection({super.key, required this.user});

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$title: $value",
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInfoTile("Phone", user.phoneNumber ?? 'Not set', Icons.phone),
        _buildInfoTile(
          "Gender",
          user.gender ?? 'Not set',
          Icons.person_outline,
        ),
        _buildInfoTile(
          "Birth Date",
          user.birthDate != null
              ? "${user.birthDate!.toLocal()}".split(' ')[0]
              : 'Not set',
          Icons.calendar_today,
        ),
      ],
    );
  }
}
