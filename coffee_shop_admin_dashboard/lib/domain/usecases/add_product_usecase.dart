import 'package:coffee_shop_admin_dashboard/core/error/failures.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/product.dart';

class AddProductUsecase {
  final ProductRepository repository;
  AddProductUsecase(this.repository);
  Future<Either<Failure, void>> execute(Product product) =>
      repository.addProduct(product);
}
