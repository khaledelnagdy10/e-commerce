import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Api {
  final String baseUrl = 'https://dummyjson.com';

  Future<dynamic> get({required String endPoint}) async {
    Response response = await http
        .get(Uri.parse('$baseUrl/$endPoint'))
        .timeout(const Duration(seconds: 20));
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } on Exception catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  Future<dynamic> post({required dynamic body}) async {
    http.Response response = await http.post(
      Uri.parse('https://fakestoreapi.com/products'),
      body: body,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception(
          'error${response.statusCode},with body${jsonDecode(response.body)}',
        );
      }
    } catch (e) {
      throw Exception('Error while posting data $e');
    }
  }

  Future<dynamic> put({required dynamic body}) async {
    http.Response response = await http.put(
      Uri.parse('https://fakestoreapi.com/products'),
      body: body,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
    );
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception(
          'error${response.statusCode},with body${jsonDecode(response.body)}',
        );
      }
    } catch (e) {
      throw Exception('Error while posting data $e');
    }
  }
}
