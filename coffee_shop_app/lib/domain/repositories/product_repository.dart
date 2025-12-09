import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/product.dart';
import '../../core/error/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();

  Future<Either<Failure, List<String>>> getCategories();
}
