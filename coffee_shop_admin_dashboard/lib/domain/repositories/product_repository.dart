import 'package:coffee_shop_admin_dashboard/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, void>> deleteProduct(String productId);
  Future<Either<Failure, void>> updateProduct(Product product);
  Future<Either<Failure, void>> addProduct(Product product);
}
