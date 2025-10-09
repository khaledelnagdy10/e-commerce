import 'package:store_app2/core/data/api/api.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';

class AddProductServices {
  Future<AllProductModel> addProduct({
    required String title,
    required String price,
    required String description,
    required String image,
    required String category,
  }) async {
    Map<String, dynamic> data = await Api().post(
      body: {
        'title': title,
        'price': price,
        'description': description,
        'image': image,
        'category': category,
      },
    );
    return AllProductModel.fromJson(data);
  }
}
