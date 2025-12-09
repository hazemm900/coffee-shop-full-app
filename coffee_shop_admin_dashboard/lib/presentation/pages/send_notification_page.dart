import 'package:coffee_shop_admin_dashboard/core/service_locator.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/send_notification_state.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/send_notification_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendNotificationPage extends StatefulWidget {
  const SendNotificationPage({super.key});

  @override
  State<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _onSend(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SendNotificationViewModel>().send(
        title: _titleController.text,
        body: _bodyController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SendNotificationViewModel>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Send Notification')),
        body: BlocConsumer<SendNotificationViewModel, SendNotificationState>(
          listener: (context, state) {
            if (state.status == FormStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notification sent successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              _formKey.currentState?.reset();
              _titleController.clear();
              _bodyController.clear();
            }
            if (state.status == FormStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'An error occurred'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Notification Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Title is required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _bodyController,
                    decoration: const InputDecoration(
                      labelText: 'Notification Body',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    validator: (value) =>
                        value!.isEmpty ? 'Body is required' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: state.status == FormStatus.loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send),
                    label: const Text('Send to All Users'),
                    onPressed: state.status == FormStatus.loading
                        ? null
                        : () => _onSend(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
