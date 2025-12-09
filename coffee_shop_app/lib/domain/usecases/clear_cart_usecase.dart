import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/cart_repository.dart';

class ClearCartUsecase {
  final CartRepository repository;

  ClearCartUsecase(this.repository);

  Future<Either<Failure, void>> execute() {
    return repository.clearCart();
  }
}
