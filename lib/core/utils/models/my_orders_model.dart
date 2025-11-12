import 'package:store_app2/core/utils/models/all_product_model.dart';

class MyOrdersModel {
  final List<AllProductModel> products;

  final DateTime createdAt;

  MyOrdersModel({required this.products, required this.createdAt});

  factory MyOrdersModel.fromJson(json) {
    return MyOrdersModel(
      products: (json['products'] as List)
          .map((p) => AllProductModel.fromJson(p))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'products': products.map((p) => p.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
