import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_data/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.phoneNumber,
    super.gender,
    super.birthDate,
    super.loyaltyPoints = 0,
    required super.role,
    required super.fcmToken,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'],
      gender: data['gender'],
      birthDate: data['birthDate'] != null
          ? (data['birthDate'] as Timestamp).toDate()
          : null,
      loyaltyPoints: data['loyaltyPoints'] ?? 0,
      role: data['role'] ?? 'user',
      fcmToken: data['fcmToken'],
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'phoneNumber': phoneNumber,
    'gender': gender,
    'birthDate': birthDate,
    'loyaltyPoints': loyaltyPoints,
    'role': role,
    'fcmToken': fcmToken,
  };

  /// لإنشاء نسخة جديدة من المستخدم بعد تحديث الـ fcmToken
  UserModel copyWith({String? fcmToken}) {
    return UserModel(
      id: id,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      gender: gender,
      birthDate: birthDate,
      loyaltyPoints: loyaltyPoints,
      role: role,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
