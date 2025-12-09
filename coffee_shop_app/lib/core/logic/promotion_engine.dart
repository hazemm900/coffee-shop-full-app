// lib/core/logic/promotion_engine.dart
import 'package:shared_data/entities/cart_item.dart';
import 'package:shared_data/entities/promotion.dart';

class PromotionEngineResult {
  final double totalDiscount;
  final String appliedOfferTitle;

  PromotionEngineResult({
    this.totalDiscount = 0.0,
    this.appliedOfferTitle = '',
  });
}

class PromotionEngine {
  // الدالة الرئيسية التي تستقبل السلة والعروض
  PromotionEngineResult applyPromotions(
    List<CartItem> items,
    List<Promotion> promotions,
  ) {
    double bestDiscount = 0.0;
    String bestOfferTitle = '';

    // حساب إجمالي السلة بناءً على أسعار العروض (إن وجدت)
    final double cartTotal = _calculateCartTotal(items);

    // المرور على كل العروض التلقائية المتاحة
    for (final promo in promotions) {
      double currentDiscount = 0.0;

      // 1. التحقق من الشروط الأساسية
      if (_checkConditions(promo, cartTotal)) {
        // 2. حساب قيمة الخصم
        currentDiscount = _calculateDiscount(promo, items, cartTotal);
      }

      // 3. اختيار الخصم الأفضل (نطبق خصمًا واحدًا فقط وهو الأقوى)
      if (currentDiscount > bestDiscount) {
        bestDiscount = currentDiscount;
        bestOfferTitle = promo.description;
      }
    }

    return PromotionEngineResult(
      totalDiscount: bestDiscount,
      appliedOfferTitle: bestOfferTitle,
    );
  }

  // دالة مساعدة لحساب إجمالي السلة
  double _calculateCartTotal(List<CartItem> items) {
    return items.fold(0.0, (sum, item) {
      final price = item.product.isOnOffer
          ? item.product.offerPrice
          : item.product.price;
      return sum + (price * item.quantity);
    });
  }

  // دالة للتحقق من الشروط
  bool _checkConditions(Promotion promo, double cartTotal) {
    // التحقق من الحد الأدنى للشراء
    if (promo.minPurchaseAmount != null &&
        cartTotal < promo.minPurchaseAmount!) {
      return false;
    }
    // TODO: إضافة التحقق من الأيام المحددة (promo.specificDays)
    return true;
  }

  // دالة لحساب الخصم
  double _calculateDiscount(
    Promotion promo,
    List<CartItem> items,
    double cartTotal,
  ) {
    // سنبدأ بتنفيذ النوع الأبسط: الخصم على إجمالي الطلب
    if (promo.appliesTo == PromotionAppliesTo.ENTIRE_ORDER) {
      if (promo.discountType == DiscountType.PERCENTAGE) {
        return cartTotal * (promo.discountValue / 100);
      } else if (promo.discountType == DiscountType.FIXED_AMOUNT) {
        return promo.discountValue > cartTotal
            ? cartTotal
            : promo.discountValue; // لا تجعل الخصم أكبر من الإجمالي
      }
    }

    // TODO: إضافة منطق الفئات (CATEGORY) والمنتجات المحددة (SPECIFIC_PRODUCTS)
    // هذا المنطق سيكون أكثر تعقيدًا ويتطلب المرور على `items`

    return 0.0;
  }
}
