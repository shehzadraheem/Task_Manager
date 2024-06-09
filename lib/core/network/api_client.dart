import 'dart:convert';
import 'package:http/http.dart' as http;
import '../error/exceptions/exceptions.dart';
import '../util/constants/constants.dart';


class ApiClient {
  final http.Client client;

  ApiClient({required this.client});

  Future<http.Response> getRequest(String path) async {
    final response = await client.get(Uri.parse(BASE_URL + path));
    _handleResponse(response);
    return response;
  }

  Future<http.Response> postRequest(String path, dynamic data) async {
    final response = await client.post(
      Uri.parse(BASE_URL + path),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    _handleResponse(response);
    return response;
  }

  void _handleResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ServerException();
    }
  }
}
