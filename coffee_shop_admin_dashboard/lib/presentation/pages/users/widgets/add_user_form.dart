import 'package:coffee_shop_admin_dashboard/core/theme/app_theme.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/users_viewmodel/add_user_state.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/users_viewmodel/add_user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_text_field.dart';
import 'user_dropdown_field.dart';
import 'user_date_picker.dart';
import 'submit_button.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({super.key});

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final fcmTokenController = TextEditingController();

  String selectedRole = 'user';
  String? selectedGender;
  DateTime? birthDate;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AddUserViewModel>();
    final state = context.watch<AddUserViewModel>().state;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'User Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),

              UserTextField(
                controller: nameController,
                label: 'Full Name',
                icon: Icons.person_outline,
                validator: (v) => v!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),

              UserTextField(
                controller: emailController,
                label: 'Email Address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v!.isEmpty
                    ? 'Please enter an email'
                    : (!v.contains('@') ? 'Enter a valid email' : null),
              ),
              const SizedBox(height: 16),

              UserTextField(
                controller: passwordController,
                label: 'Password',
                icon: Icons.lock_outline,
                obscureText: true,
                validator: (v) => v!.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
              ),
              const SizedBox(height: 16),

              UserTextField(
                controller: phoneController,
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              UserDropdownField<String>(
                label: 'Gender',
                value: selectedGender,
                items: const [
                  DropdownMenuItem(value: 'male', child: Text('Male')),
                  DropdownMenuItem(value: 'female', child: Text('Female')),
                ],
                onChanged: (value) => setState(() => selectedGender = value),
              ),
              const SizedBox(height: 16),

              UserDatePicker(
                label: 'Birth Date',
                selectedDate: birthDate,
                onDatePicked: (date) => setState(() => birthDate = date),
              ),
              const SizedBox(height: 16),

              UserDropdownField<String>(
                label: 'Role',
                value: selectedRole,
                items: const [
                  DropdownMenuItem(value: 'user', child: Text('User')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                  DropdownMenuItem(
                    value: 'super_admin',
                    child: Text('Super Admin'),
                  ),
                ],
                onChanged: (value) =>
                    setState(() => selectedRole = value ?? 'user'),
              ),
              const SizedBox(height: 16),

              UserTextField(
                controller: fcmTokenController,
                label: 'FCM Token (optional)',
                icon: Icons.token_outlined,
              ),
              const SizedBox(height: 30),

              SubmitButton(
                isLoading: state.status == AddUserStatus.loading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    viewModel.addUser(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      role: selectedRole,
                      phoneNumber: phoneController.text.trim(),
                      gender: selectedGender,
                      birthDate: birthDate,
                      fcmToken: fcmTokenController.text.trim(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
