import 'dart:convert';
import 'package:http/http.dart';
import 'package:store_app2/core/data/api/api.dart';
import 'package:store_app2/core/utils/models/categories_model.dart';

class GetAllCategoryService {
  Future<List<CategoriesModel>> getAllCategories() async {
    Response response = await Api().get(endPoint: 'products/categories');

    List<dynamic> data = jsonDecode(response.body);

    return data.map((json) => CategoriesModel.fromJson(json)).toList();
  }
}
