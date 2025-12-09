import 'package:coffee_shop_app/core/error/failures.dart';
import 'package:coffee_shop_app/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/cart_item.dart';
import 'package:shared_data/entities/product.dart';

class CartRepositoryImpl implements CartRepository {
  // هذه هي "قاعدة البيانات" المحلية المؤقتة
  final List<CartItem> _cartItems = [];

  @override
  Future<Either<Failure, void>> addProductToCart(Product product) async {
    try {
      // تحقق إذا كان المنتج موجودًا بالفعل
      final index = _cartItems.indexWhere(
        (item) => item.product.id == product.id,
      );

      if (index != -1) {
        // إذا كان موجودًا، قم بزيادة الكمية
        final existingItem = _cartItems[index];
        _cartItems[index] = existingItem.copyWith(
          quantity: existingItem.quantity + 1,
        );
      } else {
        // إذا لم يكن موجودًا، أضفه بكمية 1
        _cartItems.add(CartItem(product: product, quantity: 1));
      }
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure("Could not add item to cart."));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems() async {
    try {
      // أرجع نسخة من القائمة لتجنب التعديل الخارجي
      return Right(List.from(_cartItems));
    } catch (e) {
      return const Left(ServerFailure("Could not retrieve cart items."));
    }
  }

  @override
  Future<Either<Failure, void>> removeProductFromCart(String productId) async {
    try {
      _cartItems.removeWhere((item) => item.product.id == productId);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure("Could not remove item from cart."));
    }
  }

  @override
  Future<Either<Failure, void>> updateProductQuantity(
    String productId,
    int quantity,
  ) async {
    try {
      final index = _cartItems.indexWhere(
        (item) => item.product.id == productId,
      );
      if (index != -1) {
        // إذا كانت الكمية 0 أو أقل، احذف العنصر
        if (quantity <= 0) {
          _cartItems.removeAt(index);
        } else {
          // غير ذلك، حدّث الكمية
          final existingItem = _cartItems[index];
          _cartItems[index] = existingItem.copyWith(quantity: quantity);
        }
      }
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure("Could not update item quantity."));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    _cartItems.clear();
    return const Right(null);
  }
}
