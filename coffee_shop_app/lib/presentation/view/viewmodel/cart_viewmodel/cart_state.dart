part of 'cart_viewmodel.dart';

abstract class CartState extends Equatable {
  const CartState();

  // <-- هنا عدّلنا ليقبل القيم nullable لأن بعض الحالات تحتوي حقول nullable
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  // 🛒 عناصر السلة
  final List<CartItem> items;
  final int totalItems;
  final double subtotal; // السعر قبل الخصم

  // 💥 الخصم التلقائي
  final double automaticDiscount;
  final String appliedOfferTitle;

  // 🎟️ كود الخصم اليدوي
  final bool isPromoCodeLoading;
  final String? promoCodeError;
  final Promotion? appliedPromoCode; // العرض الذي تم إدخاله يدويًا
  final double promoCodeDiscount; // قيمة الخصم من الكود اليدوي

  // 💰 السعر النهائي بعد كل الخصومات
  final double finalTotal;

  // --------------------------------------------------------------
  // 🔹 الحالة الأساسية بدون عروض
  CartLoaded(this.items)
    : totalItems = items.fold(0, (sum, item) => sum + item.quantity),
      subtotal = items.fold(0.0, (sum, item) {
        final price = item.product.isOnOffer
            ? item.product.offerPrice
            : item.product.price;
        return sum + (price * item.quantity);
      }),
      automaticDiscount = 0.0,
      appliedOfferTitle = '',
      isPromoCodeLoading = false,
      promoCodeError = null,
      appliedPromoCode = null,
      promoCodeDiscount = 0.0,
      finalTotal = items.fold(0.0, (sum, item) {
        final price = item.product.isOnOffer
            ? item.product.offerPrice
            : item.product.price;
        return sum + (price * item.quantity);
      });

  // --------------------------------------------------------------
  // 🔹 الحالة عند تطبيق عروض أو أكواد خصم
  CartLoaded.withPromotions({
    required this.items,
    required this.totalItems,
    required this.subtotal,
    // التلقائي
    required this.automaticDiscount,
    required this.appliedOfferTitle,
    // اليدوي
    this.isPromoCodeLoading = false,
    this.promoCodeError,
    this.appliedPromoCode,
    this.promoCodeDiscount = 0.0,
  }) : finalTotal = subtotal - automaticDiscount - promoCodeDiscount;

  // --------------------------------------------------------------
  // 🔹 copyWith لتحديث الحالة
  CartLoaded copyWith({
    List<CartItem>? items,
    int? totalItems,
    double? subtotal,
    double? automaticDiscount,
    String? appliedOfferTitle,
    bool? isPromoCodeLoading,
    String? promoCodeError,
    Promotion? appliedPromoCode,
    double? promoCodeDiscount,
  }) {
    return CartLoaded.withPromotions(
      items: items ?? this.items,
      totalItems: totalItems ?? this.totalItems,
      subtotal: subtotal ?? this.subtotal,
      automaticDiscount: automaticDiscount ?? this.automaticDiscount,
      appliedOfferTitle: appliedOfferTitle ?? this.appliedOfferTitle,
      isPromoCodeLoading: isPromoCodeLoading ?? this.isPromoCodeLoading,
      promoCodeError: promoCodeError ?? this.promoCodeError,
      appliedPromoCode: appliedPromoCode ?? this.appliedPromoCode,
      promoCodeDiscount: promoCodeDiscount ?? this.promoCodeDiscount,
    );
  }

  @override
  List<Object?> get props => [
    items,
    totalItems,
    subtotal,
    automaticDiscount,
    appliedOfferTitle,
    isPromoCodeLoading,
    promoCodeError,
    appliedPromoCode,
    promoCodeDiscount,
    finalTotal,
  ];
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
