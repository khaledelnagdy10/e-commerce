import 'dart:convert';

import 'package:http/http.dart';
import 'package:store_app2/core/data/api/api.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';

class GetCategoryProductService {
  Future<List<AllProductModel>> categoryProductService({
    required String category,
  }) async {
    Response response = await Api().get(
      endPoint: 'products/category/$category',
    );

    List<dynamic> data = jsonDecode(response.body)['products'];
    List<AllProductModel> listData = data
        .map((e) => AllProductModel.fromJson(e))
        .toList();
    return listData;
  }
}
