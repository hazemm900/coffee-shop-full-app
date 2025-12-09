import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class DeleteProductUsecase {
  final ProductRepository repository;
  DeleteProductUsecase(this.repository);
  Future<Either<Failure, void>> execute(String productId) =>
      repository.deleteProduct(productId);
}
