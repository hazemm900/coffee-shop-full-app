import 'package:coffee_shop_app/core/service_locator.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/notification_viewmodel/notifications_state.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/notification_viewmodel/notifications_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationsViewModel>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Notifications')),
        body: BlocBuilder<NotificationsViewModel, NotificationsState>(
          builder: (context, state) {
            if (state.status == ViewStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.notifications.isEmpty) {
              return const Center(child: Text('You have no notifications.'));
            }
            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final notification = state.notifications[index];
                final formattedDate = DateFormat(
                  'dd MMM, hh:mm a',
                ).format(notification.timestamp);

                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      notification.isRead
                          ? Icons.notifications_off
                          : Icons.notifications_active,
                    ),
                  ),
                  title: Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight: notification.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(notification.body),
                  trailing: Text(formattedDate),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
