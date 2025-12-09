import 'package:coffee_shop_admin_dashboard/core/theme/app_theme.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/user_orders/user_orders_page.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/users/widgets/show_dialog_role.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_data/entities/user.dart';

class UserCard extends StatefulWidget {
  final User user;
  final String currentUserRole;
  final VoidCallback onDelete;

  const UserCard({
    super.key,
    required this.user,
    required this.currentUserRole,
    required this.onDelete,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final canEdit =
        widget.currentUserRole == 'admin' ||
        widget.currentUserRole == 'super_admin';
    final canDelete = widget.currentUserRole == 'super_admin';

    final user = widget.user;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.primary.withOpacity(0.05)
              : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _isHovered ? AppColors.primary : Colors.grey.shade300,
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppColors.primary.withOpacity(0.15)
                  : Colors.black12,
              blurRadius: _isHovered ? 10 : 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Header (Avatar + Name + Role)
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                    style: const TextStyle(
                      fontSize: 22,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      if (user.phoneNumber != null &&
                          user.phoneNumber!.isNotEmpty)
                        Text(
                          user.phoneNumber!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                    ],
                  ),
                ),
                Icon(
                  user.role == 'super_admin'
                      ? Icons.star
                      : user.role == 'admin'
                      ? Icons.shield_outlined
                      : Icons.person_outline,
                  color: user.role == 'super_admin'
                      ? Colors.orange
                      : user.role == 'admin'
                      ? Colors.blue
                      : Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // === User info section
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                if (user.gender != null) _infoChip(Icons.wc, user.gender!),
                if (user.birthDate != null)
                  _infoChip(
                    Icons.cake_outlined,
                    DateFormat('dd MMM yyyy').format(user.birthDate!),
                  ),
                _infoChip(Icons.star_outline, 'Points: ${user.loyaltyPoints}'),
                if (user.fcmToken != null && user.fcmToken!.isNotEmpty)
                  _infoChip(Icons.phone_android, 'Has FCM Token'),
              ],
            ),

            const Spacer(),

            // === Actions Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.history, color: Colors.grey),
                  tooltip: 'View Orders',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserOrdersPage(user: user),
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    if (canEdit)
                      IconButton(
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.blueAccent,
                        ),
                        tooltip: 'Edit Role',
                        onPressed: () => showChangeRoleDialog(context, user),
                      ),
                    if (canDelete)
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        tooltip: 'Delete User',
                        onPressed: widget.onDelete,
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
