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
    this.quantity = 1,
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
      productName: json['tags'] != null && (json['tags']).length > 1
          ? json['tags'][1]
          : '',
      discountPercentage: json['discountPercentage'] ?? 0,
      categoryName: json['tags'] != null && (json['tags']).isNotEmpty
          ? json['tags'][0].toString()
          : 'unknown',
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
    };
  }
}
