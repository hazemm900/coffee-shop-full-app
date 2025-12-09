import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/users_viewmodel/UsersViewModel%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/user.dart';

void showChangeRoleDialog(BuildContext context, User user) {
  String selectedRole = user.role;
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text('Change Role for ${user.name}'),
      content: DropdownButton<String>(
        value: selectedRole,
        items: const [
          DropdownMenuItem(value: 'user', child: Text('User')),
          DropdownMenuItem(value: 'admin', child: Text('Admin')),
          DropdownMenuItem(value: 'super_admin', child: Text('Super Admin')),
        ],
        onChanged: (value) {
          if (value != null) selectedRole = value;
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.read<UsersViewModel>().changeUserRole(
              user.id,
              selectedRole,
            );
            Navigator.pop(dialogContext);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Role updated to $selectedRole')),
            );
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
