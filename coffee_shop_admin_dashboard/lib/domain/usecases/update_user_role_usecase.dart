import 'package:coffee_shop_admin_dashboard/core/error/failures.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUserRoleUsecase {
  final UserRepository repository;
  UpdateUserRoleUsecase(this.repository);

  Future<Either<Failure, void>> execute(String uid, String newRole) =>
      repository.updateUserRole(uid, newRole);
}
