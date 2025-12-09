import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:cloud_firestore/cloud_firestore.dart'; // <-- أضف هذا

abstract class FirebaseAuthDataSource {
  Future<firebase.User> login(String email, String password);

  Future<firebase.User> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber, // <-- أضف هذا
    required String gender, // <-- أضف هذا
    required DateTime birthDate, // <-- أضف هذا
  });

  Future<void> logout();
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final firebase.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore; // <-- أضف هذا

  FirebaseAuthDataSourceImpl(this._firebaseAuth, this._firestore);

  @override
  Future<firebase.User> login(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user == null) {
      throw Exception("Login failed: User is null."); // Or a custom exception
    }
    return userCredential.user!;
  }

  @override
  Future<firebase.User> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String gender,
    required DateTime birthDate,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user == null) {
      throw Exception("Registration failed: User is null.");
    }
    // تحديث اسم العرض في Authentication
    await user.updateDisplayName(name);

    // **الخطوة الجديدة: حفظ بيانات المستخدم في Firestore**
    await _firestore.collection('users').doc(user.uid).set({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber, // <-- أضف هذا
      'gender': gender, // <-- أضف هذا
      'birthDate': Timestamp.fromDate(birthDate), // <-- أضف هذا
      'createdAt': FieldValue.serverTimestamp(),
      'isAdmin': false, // حقل مهم للتمييز بين المستخدم العادي والأدمن
    });

    return user;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
