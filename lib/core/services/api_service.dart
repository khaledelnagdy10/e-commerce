import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  Future<dynamic> post({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final res = await dio.post(
      endpoint,
      data: data,
    );
    return res.data;
  }
}
