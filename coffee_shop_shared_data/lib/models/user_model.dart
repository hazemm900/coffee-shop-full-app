import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
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
    super.role = 'user',
    super.fcmToken,
  });

  /// من Firebase Auth User (بعد التسجيل أو تسجيل الدخول)
  factory UserModel.fromFirebaseUser(firebase.User firebaseUser) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? '',
    );
  }

  /// من Firestore Snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'],
      gender: data['gender'],
      birthDate: (data['birthDate'] as Timestamp?)?.toDate(),
      loyaltyPoints: data['loyaltyPoints'] ?? 0,
      role: data['role'] ?? 'user',
      fcmToken: data['fcmToken'],
    );
  }

  /// لتحويل UserModel إلى Map لحفظها في Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'birthDate': birthDate != null ? Timestamp.fromDate(birthDate!) : null,
      'loyaltyPoints': loyaltyPoints,
      'role': role,
      'fcmToken': fcmToken,
    };
  }

  /// لإنشاء نسخة جديدة من المستخدم بعد تحديث الـ fcmToken
  UserModel copyWith({
    String? fcmToken,
  }) {
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
