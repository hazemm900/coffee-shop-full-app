import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/cart_item.dart';
import '../../core/error/failures.dart';
import '../repositories/cart_repository.dart';

class GetCartItemsUsecase {
  final CartRepository repository;
  GetCartItemsUsecase(this.repository);

  Future<Either<Failure, List<CartItem>>> execute() {
    return repository.getCartItems();
  }
}
