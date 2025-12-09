import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/cart_repository.dart';

class UpdateProductQuantityUsecase {
  final CartRepository repository;
  UpdateProductQuantityUsecase(this.repository);

  Future<Either<Failure, void>> execute(String productId, int quantity) {
    return repository.updateProductQuantity(productId, quantity);
  }
}
