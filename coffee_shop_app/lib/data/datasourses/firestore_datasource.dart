import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_data/models/order_model.dart';
import 'package:shared_data/models/product_model.dart';
import 'package:shared_data/models/promotion_model.dart';
import 'package:shared_data/models/user_model.dart';

abstract class FirestoreDataSource {
  Future<List<ProductModel>> getProducts();
  Future<void> createOrder(OrderModel orderModel);
  Future<UserModel> getUserProfile(String uid);
  Future<List<OrderModel>> getMyOrders(String uid);
  Future<void> awardPoints(String uid, int pointsToAdd);
  Future<void> redeemPoints(String uid, int pointsToRedeem);
  Stream<QuerySnapshot> getNotificationsStream(String uid);
  Future<List<PromotionModel>> getActiveAutomaticPromotions();
  Future<List<PromotionModel>> getPromotionByCode(String code);
}

class FirestoreDataSourceImpl implements FirestoreDataSource {
  final FirebaseFirestore _firestore;

  FirestoreDataSourceImpl(this._firestore);

  @override
  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _firestore.collection('products').get();
    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }

  @override
  Future<void> createOrder(OrderModel orderModel) async {
    await _firestore.collection('orders').add(orderModel.toJson());
  }

  @override
  Future<UserModel> getUserProfile(String uid) async {
    final docSnapshot = await _firestore.collection('users').doc(uid).get();
    if (docSnapshot.exists) {
      return UserModel.fromSnapshot(docSnapshot);
    } else {
      throw Exception("User document not found in Firestore.");
    }
  }

  @override
  Future<List<OrderModel>> getMyOrders(String uid) async {
    final snapshot = await _firestore
        .collection('orders')
        .where('userId', isEqualTo: uid) // فلترة الطلبات للمستخدم الحالي فقط
        .orderBy('timestamp', descending: true) // ترتيبها من الأحدث للأقدم
        .get();

    // تحويل كل مستند إلى OrderModel
    return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
  }

  @override
  Future<void> awardPoints(String uid, int pointsToAdd) async {
    final userDocRef = _firestore.collection('users').doc(uid);

    return _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userDocRef);
      final currentPoints = snapshot.data()?['loyaltyPoints'] ?? 0;
      final newPoints = currentPoints + pointsToAdd;
      transaction.update(userDocRef, {'loyaltyPoints': newPoints});
    });
  }

  @override
  Future<void> redeemPoints(String uid, int pointsToRedeem) async {
    final userDocRef = _firestore.collection('users').doc(uid);

    return _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userDocRef);
      final currentPoints = snapshot.data()?['loyaltyPoints'] ?? 0;

      // تحقق إذا كان المستخدم يملك نقاطًا كافية
      if (currentPoints < pointsToRedeem) {
        throw Exception("Insufficient loyalty points.");
      }

      final newPoints = currentPoints - pointsToRedeem;
      transaction.update(userDocRef, {'loyaltyPoints': newPoints});
    });
  }

  @override
  Stream<QuerySnapshot> getNotificationsStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('notifications') // Collection فرعية داخل كل مستخدم
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Future<List<PromotionModel>> getActiveAutomaticPromotions() async {
    final snapshot = await _firestore
        .collection('promotions')
        .where('status', isEqualTo: 'ACTIVE')
        .where('type', isEqualTo: 'AUTOMATIC')
        .where('startDate', isLessThanOrEqualTo: DateTime.now())
        .get();

    // فلترة إضافية للـ endDate (Firestore لا تدعم where multiple range)
    return snapshot.docs
        .map((doc) => PromotionModel.fromSnapshot(doc))
        .where(
          (promo) =>
              promo.endDate == null || promo.endDate!.isAfter(DateTime.now()),
        )
        .toList();
  }

  @override
  Future<List<PromotionModel>> getPromotionByCode(String code) async {
    final snapshot = await _firestore
        .collection('promotions')
        .where('status', isEqualTo: 'ACTIVE')
        .where('type', isEqualTo: 'PROMO_CODE')
        .where('promoCode', isEqualTo: code)
        .get();

    return snapshot.docs
        .map((doc) => PromotionModel.fromSnapshot(doc))
        .toList();
  }
}
