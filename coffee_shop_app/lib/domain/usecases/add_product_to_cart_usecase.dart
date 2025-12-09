import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/product.dart';
import '../../core/error/failures.dart';
import '../repositories/cart_repository.dart';

class AddProductToCartUsecase {
  final CartRepository repository;
  AddProductToCartUsecase(this.repository);

  Future<Either<Failure, void>> execute(Product product) {
    return repository.addProductToCart(product);
  }
}
