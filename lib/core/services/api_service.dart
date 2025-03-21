import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});
  Future<void> post(String email, String Password) async {
    try {
      Response response = await dio.post(
        'https://dummyjson.com/auth/login',
        data: {'email': email, 'password': Password},
      );
      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
      } else {
        throw Exception('there was an error');
      }
    } catch (e) {
      print(e);
      throw ('Failed to login');
    }
  }
}
