// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:store_app2/core/utils/models/all_product_model.dart';

class MyOrdersModel {
  String? id;
  String? address;
  final List<AllProductModel> products;
  final DateTime createdAt;
  String status;

  MyOrdersModel({
    this.id,
    required this.address,
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
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((p) => p.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'address': address,
    };
  }
}
