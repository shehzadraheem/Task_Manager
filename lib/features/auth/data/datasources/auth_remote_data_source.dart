import 'dart:convert';

import 'package:task_manager/core/network/api_client.dart';
import 'package:task_manager/features/auth/data/models/user_model.dart';
import '../../../../core/error/exceptions/exceptions.dart';
import '../../../../core/util/constants/constants.dart';


abstract class AuthRemoteDataSource {
  Future<UserModel> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserModel> login(String username, String password) async {
    try {
      final response = await apiClient.postRequest(
        LOGIN_ENDPOINT,
        {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return UserModel.fromJson(jsonResponse);
      } else if (response.statusCode == 400) {
        throw AuthenticationException();
      } else  {
        throw ServerException();
      }
    } on ServerException {
      throw ServerException();
    }
  }
}
