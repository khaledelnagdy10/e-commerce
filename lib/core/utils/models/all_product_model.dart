class AllProductModel {
  final num id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String images;
  final num rating;
  final String productName;
  final num discountPercentage;
  final String categoryName;
  int quantity;
  String? selectedSize;
  String? selectedColor;

  AllProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.rating,
    required this.productName,
    required this.categoryName,
    required this.discountPercentage,
    required this.quantity,
    this.selectedColor,
    this.selectedSize,
  });

  factory AllProductModel.fromJson(Map<String, dynamic> json) {
    return AllProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      images: (json['images'] is List && json['images'].isNotEmpty)
          ? json['images'][0]
          : (json['images'] is String ? json['images'] : ''),
      rating: json['rating'],
      productName:
          json['productName'] ??
          (json['tags'] != null && (json['tags']).length > 1
              ? json['tags'][1]
              : json['title'] ?? ''),
      discountPercentage: json['discountPercentage'] ?? 0,
      categoryName:
          json['categoryName'] ??
          (json['tags'] != null && (json['tags']).isNotEmpty
              ? json['tags'][0].toString()
              : 'unknown'),
      quantity: json['quantity'] ?? 1,
      selectedColor: json['selectedColor'],
      selectedSize: json['selectedSize'],
    );
  }
}

extension ProductMap on AllProductModel {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'images': images,
      'rating': rating,
      'productName': productName,
      'discountPercentage': discountPercentage,
      'categoryName': categoryName,
      'quantity': quantity,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
    };
  }
}
