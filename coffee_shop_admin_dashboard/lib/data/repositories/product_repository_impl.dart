import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/product.dart';
import 'package:shared_data/models/product_model.dart';
import '../../core/error/failures.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/firestore_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirestoreDataSource dataSource;
  ProductRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final products = await dataSource.getProducts();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure("Failed to fetch products."));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) async {
    try {
      await dataSource.deleteProduct(productId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("Failed to delete product."));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    try {
      final productModel = ProductModel.fromProduct(
        product,
      ); // سنضيف هذا الكونستركتور
      await dataSource.updateProduct(productModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("Failed to update product."));
    }
  }

  @override
  Future<Either<Failure, void>> addProduct(Product product) async {
    try {
      final productModel = ProductModel.fromProduct(product);
      await dataSource.addProduct(productModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("Failed to add product."));
    }
  }
}
