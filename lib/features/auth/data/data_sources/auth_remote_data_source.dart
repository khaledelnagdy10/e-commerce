import 'package:e_commerce_app/core/services/api_service.dart';

class AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSource({required ApiService apiService}) : _apiService = apiService;

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await _apiService.post(
        endpoint: "/auth/login",
        data: {'username': email, 'password': password},
      );
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
