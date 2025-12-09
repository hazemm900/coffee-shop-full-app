import 'package:coffee_shop_admin_dashboard/domain/usecases/logout_usecase.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/register/login_page.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/users/add_user_page.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/users/widgets/user_card.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/register_viewmodel/logout_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/users_viewmodel/UsersState.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/users_viewmodel/UsersViewModel%20.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/users_viewmodel/delete_user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service_locator.dart';

class UsersPage extends StatelessWidget {
  final String currentUserRole;
  const UsersPage({super.key, required this.currentUserRole});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<UsersViewModel>()..fetchAllUsers()),
        BlocProvider(create: (_) => sl<DeleteUserViewModel>()),
        BlocProvider(create: (_) => LogoutViewModel(sl<LogoutUsecase>())),
      ],
      child: const _UsersScaffold(),
    );
  }
}

class _UsersScaffold extends StatefulWidget {
  const _UsersScaffold();

  @override
  State<_UsersScaffold> createState() => _UsersScaffoldState();
}

class _UsersScaffoldState extends State<_UsersScaffold> {
  @override
  Widget build(BuildContext context) {
    final page = context.findAncestorWidgetOfExactType<UsersPage>()!;
    final currentUserRole = page.currentUserRole;

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (currentUserRole == 'admin' || currentUserRole == 'super_admin')
            IconButton(
              icon: const Icon(Icons.person_add_alt_1_outlined),
              tooltip: 'Add User',
              onPressed: () async {
                final added = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddUserPage()),
                );
                if (added == true) {
                  context.read<UsersViewModel>().fetchAllUsers();
                }
              },
            ),
          BlocConsumer<LogoutViewModel, LogoutState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              } else if (state is LogoutError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is LogoutLoading) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                );
              }
              return IconButton(
                icon: const Icon(Icons.logout_outlined),
                tooltip: 'Logout',
                onPressed: () => context.read<LogoutViewModel>().logout(),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<DeleteUserViewModel, DeleteUserState>(
        listener: (context, deleteState) {
          if (deleteState is DeleteUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User deleted successfully')),
            );
            context.read<UsersViewModel>().fetchAllUsers();
          }
        },
        builder: (context, _) {
          return BlocBuilder<UsersViewModel, UsersState>(
            builder: (context, state) {
              if (state.status == ViewStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == ViewStatus.error) {
                return Center(
                  child: Text(state.errorMessage ?? 'Error loading users'),
                );
              }

              final users = state.users;
              if (users.isEmpty) {
                return const Center(child: Text('No users found'));
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  // Responsive column count
                  int crossAxisCount = 4;
                  if (constraints.maxWidth < 900) {
                    crossAxisCount = 2;
                  }
                  if (constraints.maxWidth < 600) {
                    crossAxisCount = 1;
                  }

                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return UserCard(
                          user: user,
                          currentUserRole: currentUserRole,
                          onDelete: () {
                            context.read<DeleteUserViewModel>().deleteUser(
                              user.id,
                            );
                          },
                        ).animate().fadeIn(
                          duration: 400.ms,
                          curve: Curves.easeOut,
                          delay: (index * 80).ms, // nice staggered animation
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
