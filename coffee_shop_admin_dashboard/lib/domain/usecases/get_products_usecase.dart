import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/product.dart';
import '../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class GetProductsUsecase {
  final ProductRepository repository;
  GetProductsUsecase(this.repository);
  Future<Either<Failure, List<Product>>> execute() => repository.getProducts();
}
