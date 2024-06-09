import 'package:dartz/dartz.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';
import '../../../../core/error/failure/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String username, String password);
}
