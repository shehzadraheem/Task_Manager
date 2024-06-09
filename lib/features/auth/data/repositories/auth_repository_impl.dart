import 'package:dartz/dartz.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';
import '../../../../core/error/exceptions/exceptions.dart';
import '../../../../core/error/failure/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      final userModel = await remoteDataSource.login(username, password);
      return Right(userModel);
    } on ServerException {
      return Left(ServerFailure('Server error occurred'));
    } on AuthenticationException {
      return Left(AuthenticationFailure('Authentication error occurred'));
    }
  }
}
