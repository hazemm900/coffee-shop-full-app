import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/users_viewmodel/add_user_state.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/users_viewmodel/add_user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/service_locator.dart';
import 'widgets/add_user_form.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AddUserViewModel>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Add New User'), centerTitle: true),
        body: BlocConsumer<AddUserViewModel, AddUserState>(
          listener: (context, state) {
            if (state.status == AddUserStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✅ User added successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context, true);
            } else if (state.status == AddUserStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message ?? 'Failed to add user'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Animate(
                  effects: [
                    FadeEffect(duration: 400.ms),
                    SlideEffect(begin: const Offset(0, 0.2), end: Offset.zero),
                  ],
                  child: const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: AddUserForm(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
