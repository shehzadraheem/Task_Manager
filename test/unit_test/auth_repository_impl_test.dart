import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/core/error/exceptions/exceptions.dart';
import 'package:task_manager/core/error/failure/failures.dart';
import 'package:task_manager/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:task_manager/features/auth/data/models/user_model.dart';
import 'package:task_manager/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  final tUsername = 'testuser';
  final tPassword = 'password';

  final tUserModel = UserModel(
    id: 1,
    username: 'testuser',
    email: 'testuser@example.com',
    firstName: 'Test',
    lastName: 'User',
    gender: 'male',
    image: 'https://dummyjson.com/image.jpg',
    token: 'token123',
    refreshToken: 'refreshToken123',
  );
  final User tUser = tUserModel;


  group('login', () {
    test('should return User when the call to remote data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.login(any, any))
          .thenAnswer((_) async => tUserModel);
      // act
      final result = await repository.login(tUsername, tPassword);
      // assert
      verify(mockRemoteDataSource.login(tUsername, tPassword));
      expect(result, equals(Right(tUser)));
    });

    test('should return authentication failure when the call to remote data source throws AuthenticationException', () async {
      // arrange
      when(mockRemoteDataSource.login(any, any)).thenThrow(AuthenticationException());
      // act
      final result = await repository.login(tUsername, tPassword);
      // assert
      verify(mockRemoteDataSource.login(tUsername, tPassword));
      expect(result, equals(Left(AuthenticationFailure('Authentication error occurred'))));
    });

    test('should return server failure when the call to remote data source throws ServerException', () async {
      // arrange
      when(mockRemoteDataSource.login(any, any)).thenThrow(ServerException());
      // act
      final result = await repository.login(tUsername, tPassword);
      // assert
      verify(mockRemoteDataSource.login(tUsername, tPassword));
      expect(result, equals(Left(ServerFailure('Server error occurred'))));
    });

    test('should return invalid input failure when username is empty', () async {
      // arrange
      final emptyUsername = '';
      when(mockRemoteDataSource.login(any, any)).thenThrow(AuthenticationException());
      // act
      final result = await repository.login(emptyUsername, tPassword);
      // assert
      expect(result, equals(Left<Failure, User>(AuthenticationFailure('Invalid credentials'))));
    });

    test('should return invalid input failure when password is empty', () async {
      // arrange
      final emptyPassword = '';
      when(mockRemoteDataSource.login(any, any)).thenThrow(AuthenticationException());
      // act
      final result = await repository.login(tUsername, emptyPassword);
      // assert
      expect(result, equals(Left<Failure, User>(AuthenticationFailure('Invalid credentials'))));
    });

    test('should return invalid input failure when both username and password are empty', () async {
      // arrange
      final emptyUsername = '';
      final emptyPassword = '';
      when(mockRemoteDataSource.login(any, any)).thenThrow(AuthenticationException());
      // act
      final result = await repository.login(emptyUsername, emptyPassword);
      // assert
      expect(result, equals(Left<Failure, User>(AuthenticationFailure('Invalid credentials'))));
    });

  });
}