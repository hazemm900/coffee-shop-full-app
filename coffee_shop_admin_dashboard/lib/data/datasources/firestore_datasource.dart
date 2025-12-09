import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_admin_dashboard/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_data/models/product_model.dart';
import 'package:shared_data/models/order_model.dart';
import 'package:shared_data/models/promotion_model.dart';

abstract class FirestoreDataSource {
  Future<List<ProductModel>> getProducts();
  Future<void> deleteProduct(String productId);
  Future<void> updateProduct(ProductModel product);
  Future<DocumentReference> addProduct(ProductModel product);

  Future<List<UserModel>> getAllUsers();
  Future<void> updateUserRole(String uid, String newRole);
  Future<void> addUser(String name, String email, String password, String role);
  Future<void> deleteUser(String uid);

  Future<List<OrderModel>> getUserOrders(String uid);

  Stream<DocumentSnapshot> getDailyReportStream();

  Future<List<PromotionModel>> getPromotions();
  Future<void> addPromotion(PromotionModel promotion);
  Future<void> updatePromotion(PromotionModel promotion);
  Future<void> deletePromotion(String promotionId);
}

class FirestoreDataSourceImpl implements FirestoreDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  FirestoreDataSourceImpl(this._firestore, this._auth);

  @override
  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
  }

  @override
  Future<void> updateUserRole(String uid, String newRole) async {
    await _firestore.collection('users').doc(uid).update({'role': newRole});
  }

  @override
  Future<void> addUser(
    String name,
    String email,
    String password,
    String role,
  ) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'id': userCredential.user!.uid,
      'name': name,
      'email': email,
      'role': role,
      'loyaltyPoints': 0,
    });
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
  }

  // المنتجات كما هي
  @override
  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _firestore.collection('products').get();
    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }

  @override
  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await _firestore
        .collection('products')
        .doc(product.id)
        .update(product.toJson());
  }

  @override
  Future<DocumentReference> addProduct(ProductModel product) async {
    return await _firestore.collection('products').add(product.toJson());
  }

  @override
  Future<List<OrderModel>> getUserOrders(String uid) async {
    final snapshot = await _firestore
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return OrderModel(
        id: doc.id,
        userId: data['userId'] ?? '',
        totalPrice: (data['totalPrice'] ?? 0).toDouble(),
        items: [],
        timestamp: (data['timestamp'] as Timestamp?)!.toDate(),
      );
    }).toList();
  }

  @override
  Stream<DocumentSnapshot> getDailyReportStream() {
    final today = new DateTime.now().toIso8601String().substring(0, 10);
    final reportId = 'daily_summary_$today';
    // .snapshots() هي النسخة الحية (real-time) من .get()
    return _firestore.collection('reports').doc(reportId).snapshots();
  }

  @override
  Future<List<PromotionModel>> getPromotions() async {
    final snapshot = await _firestore
        .collection('promotions')
        .orderBy('startDate', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => PromotionModel.fromSnapshot(doc))
        .toList();
  }

  @override
  Future<void> addPromotion(PromotionModel promotion) async {
    await _firestore.collection('promotions').add(promotion.toJson());
  }

  @override
  Future<void> updatePromotion(PromotionModel promotion) async {
    await _firestore
        .collection('promotions')
        .doc(promotion.id)
        .update(promotion.toJson());
  }

  @override
  Future<void> deletePromotion(String promotionId) async {
    await _firestore.collection('promotions').doc(promotionId).delete();
  }
}
