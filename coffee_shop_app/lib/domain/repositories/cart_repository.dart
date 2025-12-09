import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/cart_item.dart';
import 'package:shared_data/entities/product.dart';
import '../../core/error/failures.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItem>>> getCartItems();
  Future<Either<Failure, void>> addProductToCart(Product product);
  Future<Either<Failure, void>> removeProductFromCart(String productId);
  Future<Either<Failure, void>> updateProductQuantity(
    String productId,
    int quantity,
  );
  Future<Either<Failure, void>> clearCart();
}
