import 'package:store_app2/core/utils/models/address_model.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';

class MyOrdersModel {
  String? id;
  String? name;

  AddressModel address;

  final List<AllProductModel> products;

  final DateTime createdAt;
  String status;
  String paymentMethod;
  MyOrdersModel({
    this.id,
    this.name,
    required this.address,
    required this.products,
    required this.createdAt,
    this.status = 'Pending',
    this.paymentMethod = 'Cash',
  });

  factory MyOrdersModel.fromJson(json) {
    return MyOrdersModel(
      products: (json['products'] as List)
          .map((p) => AllProductModel.fromJson(p))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'] ?? 'Pending',
      id: json['id'],
      name: json['name'] ?? '',
      address: AddressModel.fromJson(json['address'] ?? {}),
      paymentMethod: json['paymentMethod'] ?? 'Cash',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((p) => p.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'id': id,
      'name': name,
      'address': address.toJson(),
      'paymentMethod': paymentMethod,
    };
  }
}
