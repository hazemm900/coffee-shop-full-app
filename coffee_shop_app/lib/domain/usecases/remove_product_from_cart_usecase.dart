import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/cart_repository.dart';

class RemoveProductFromCartUsecase {
  final CartRepository repository;
  RemoveProductFromCartUsecase(this.repository);

  Future<Either<Failure, void>> execute(String productId) {
    return repository.removeProductFromCart(productId);
  }
}
