import 'package:coffee_shop_app/core/error/failures.dart';
import 'package:coffee_shop_app/data/datasourses/firestore_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirestoreDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final products = await dataSource.getProducts();
      return Right(products.cast<Product>());
    } catch (e) {
      return const Left(ServerFailure("Failed to fetch products."));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      // أولاً، احصل على كل المنتجات
      final productsResult = await getProducts();
      // استخدم .fold للتعامل مع نتيجة Either
      return productsResult.fold(
        (failure) => Left(failure), // إذا فشل جلب المنتجات، افشل هنا أيضًا
        (products) {
          // استخرج الفئات، استخدم Set لإزالة التكرار، ثم حولها لـ List
          final categories = products.map((p) => p.category).toSet().toList();
          categories.insert(0, 'All'); // أضف "All" كأول فئة دائمًا
          return Right(categories);
        },
      );
    } catch (e) {
      return const Left(ServerFailure("Failed to fetch categories."));
    }
  }
}
