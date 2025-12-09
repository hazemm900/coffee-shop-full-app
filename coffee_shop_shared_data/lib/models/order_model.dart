import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_data/entities/cart_item.dart';
import 'package:shared_data/entities/product.dart';

import '../entities/order.dart';

class OrderModel extends OrderDetails {
  const OrderModel({
    required super.id,
    required super.items,
    required super.totalPrice,
    required super.userId,
    required super.timestamp,
    super.pointsRedeemed = 0, // ✅ أضف دول
    super.discountAmount = 0.0, // ✅
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'totalPrice': totalPrice,
      'timestamp': Timestamp.fromDate(timestamp),
      'pointsRedeemed': pointsRedeemed, // <-- أضف هذا
      'discountAmount': discountAmount, // <-- أضف هذا

      'items': items
          .map(
            (item) => {
              'productId': item.product.id,
              'productName': item.product.name,
              'quantity': item.quantity,
              'price': item.product.price,
            },
          )
          .toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    // تحويل قائمة العناصر من Map إلى List<CartItem>
    final itemsList = (data['items'] as List<dynamic>).map((itemData) {
      final product = Product(
        id: itemData['productId'],
        name: itemData['productName'],
        price: (itemData['price'] as num).toDouble(),
        description: '', // الوصف وصورة المنتج غير محفوظين في الطلب
        imageUrl: '',
        category: '',
        offerPrice: 0, // يمكن جلبهم لاحقًا إذا لزم الأمر
        ingredients: [],
        isAvailable: true,
        isFeatured: false,
      );
      return CartItem(product: product, quantity: itemData['quantity']);
    }).toList();

    return OrderModel(
      id: doc.id,
      userId: data['userId'],
      totalPrice: (data['totalPrice'] as num).toDouble(),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      pointsRedeemed: data['pointsRedeemed'] ?? 0, // ✅
      discountAmount: (data['discountAmount'] ?? 0.0).toDouble(), // ✅

      items: itemsList,
    );
  }
}
