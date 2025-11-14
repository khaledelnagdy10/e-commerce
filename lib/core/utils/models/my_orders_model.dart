import 'package:store_app2/core/utils/models/all_product_model.dart';

class MyOrdersModel {
  String? id;
  final List<AllProductModel> products;
  final DateTime createdAt;
  String status;

  MyOrdersModel({
    required this.products,
    required this.createdAt,
    this.status = 'Pending',
  });

  factory MyOrdersModel.fromJson(json) {
    return MyOrdersModel(
      products: (json['products'] as List)
          .map((p) => AllProductModel.fromJson(p))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'] ?? 'Pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((p) => p.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }
}
