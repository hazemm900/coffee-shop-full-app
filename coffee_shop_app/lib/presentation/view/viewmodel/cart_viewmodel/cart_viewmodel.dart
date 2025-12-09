import 'package:coffee_shop_app/core/logic/promotion_engine.dart';
import 'package:coffee_shop_app/domain/usecases/add_product_to_cart_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/get_active_promotions_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/get_cart_items_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/remove_product_from_cart_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/update_product_quantity_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/validate_promo_code_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/cart_item.dart';
import 'package:shared_data/entities/product.dart';
import 'package:shared_data/entities/promotion.dart';

part 'cart_state.dart';

class CartViewModel extends Cubit<CartState> {
  final AddProductToCartUsecase addProductToCartUsecase;
  final GetCartItemsUsecase getCartItemsUsecase;
  final RemoveProductFromCartUsecase removeProductFromCartUsecase;
  final UpdateProductQuantityUsecase updateProductQuantityUsecase;
  final GetActivePromotionsUsecase getActivePromotionsUsecase;
  final PromotionEngine promotionEngine;

  // ✅ الإضافة الجديدة
  final ValidatePromoCodeUsecase validatePromoCodeUsecase;

  CartViewModel(
    this.addProductToCartUsecase,
    this.getCartItemsUsecase,
    this.removeProductFromCartUsecase,
    this.updateProductQuantityUsecase,
    this.getActivePromotionsUsecase,
    this.promotionEngine,
    this.validatePromoCodeUsecase, // ✅
  ) : super(CartInitial());

  // 🛒 تحميل السلة + العروض التلقائية
  Future<void> loadCartItems() async {
    emit(CartLoading());

    final cartResult = await getCartItemsUsecase.execute();
    final promoResult = await getActivePromotionsUsecase.execute();

    cartResult.fold((failure) => emit(CartError(failure.message)), (items) {
      promoResult.fold((failure) => emit(CartError(failure.message)), (
        promotions,
      ) {
        final baseState = CartLoaded(items);

        final promoEngineResult = promotionEngine.applyPromotions(
          items,
          promotions,
        );

        emit(
          CartLoaded.withPromotions(
            items: items,
            totalItems: baseState.totalItems,
            subtotal: baseState.subtotal,
            automaticDiscount: promoEngineResult.totalDiscount,
            appliedOfferTitle: promoEngineResult.appliedOfferTitle,
          ),
        );
      });
    });
  }

  // ➕ إضافة منتج للسلة
  Future<void> addToCart(Product product) async {
    await addProductToCartUsecase.execute(product);
    await loadCartItems();
  }

  // ❌ إزالة منتج من السلة
  Future<void> removeFromCart(String productId) async {
    await removeProductFromCartUsecase.execute(productId);
    await loadCartItems();
  }

  // 🔁 تحديث كمية منتج
  Future<void> updateQuantity(String productId, int newQuantity) async {
    await updateProductQuantityUsecase.execute(productId, newQuantity);
    await loadCartItems();
  }

  // 🎟️ تطبيق كود خصم يدوي
  Future<void> applyPromoCode(String code) async {
    if (state is! CartLoaded) return;
    final currentState = state as CartLoaded;

    // 1️⃣ إظهار حالة التحميل وإزالة الأخطاء القديمة
    emit(
      CartLoaded.withPromotions(
        items: currentState.items,
        totalItems: currentState.totalItems,
        subtotal: currentState.subtotal,
        automaticDiscount: currentState.automaticDiscount,
        appliedOfferTitle: currentState.appliedOfferTitle,
        isPromoCodeLoading: true,
        promoCodeError: null,
      ),
    );

    // 2️⃣ التحقق من الكود
    final result = await validatePromoCodeUsecase.execute(code);

    result.fold(
      (failure) {
        // ❌ فشل التحقق
        emit(
          CartLoaded.withPromotions(
            items: currentState.items,
            totalItems: currentState.totalItems,
            subtotal: currentState.subtotal,
            automaticDiscount: currentState.automaticDiscount,
            appliedOfferTitle: currentState.appliedOfferTitle,
            isPromoCodeLoading: false,
            promoCodeError: failure.message,
          ),
        );
      },
      (promotion) {
        // ✅ كود صالح — طبق العرض
        final promoResult = promotionEngine.applyPromotions(
          currentState.items,
          [promotion],
        );

        emit(
          CartLoaded.withPromotions(
            items: currentState.items,
            totalItems: currentState.totalItems,
            subtotal: currentState.subtotal,
            automaticDiscount: currentState.automaticDiscount,
            appliedOfferTitle: currentState.appliedOfferTitle,
            isPromoCodeLoading: false,
            appliedPromoCode: promotion,
            promoCodeDiscount: promoResult.totalDiscount,
          ),
        );
      },
    );
  }
}
