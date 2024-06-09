import 'package:dartz/dartz.dart';
import '../../../../core/error/failure/failures.dart';
import '../repositories/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository repository;

  LoginUserUseCase(this.repository);

  Future<Either<Failure, void>> call(String userName, String password) async {
    return await repository.login(userName, password);
  }
}
