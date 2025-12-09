import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? phoneNumber;
  final String? gender;
  final DateTime? birthDate;
  final int loyaltyPoints;
  final String role; // user, admin, super_admin
  final String? fcmToken; // <-- أضف هذا

  const User(
      {required this.id,
      required this.email,
      required this.name,
      this.phoneNumber,
      this.gender,
      this.birthDate,
      this.loyaltyPoints = 0,
      this.role = 'user',
      required this.fcmToken});

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        phoneNumber,
        gender,
        birthDate,
        loyaltyPoints,
        role,
        fcmToken
      ];
}
