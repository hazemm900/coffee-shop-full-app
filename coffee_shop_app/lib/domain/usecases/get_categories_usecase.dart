// lib/domain/usecases/get_categories_usecase.dart
import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class GetCategoriesUsecase {
  final ProductRepository repository;
  GetCategoriesUsecase(this.repository);

  Future<Either<Failure, List<String>>> execute() {
    return repository.getCategories();
  }
}
