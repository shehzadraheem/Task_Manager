import 'package:equatable/equatable.dart';

abstract class Failure  extends Equatable{
  final String message;
  Failure(this.message);

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure(String message) : super(message);
}

class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure(String message) : super(message);
}
