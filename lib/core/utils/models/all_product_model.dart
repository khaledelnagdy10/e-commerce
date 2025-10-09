class AllProductModel {
  final num id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final num rating;
  final String productName;
  final num discountPercentage;
  final String categoryName;

  AllProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.productName,
    required this.categoryName,

    required this.discountPercentage,
  });

  factory AllProductModel.fromJson(Map<String, dynamic> json) {
    return AllProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: (json['images'] as List).isNotEmpty ? json['images'][0] : '',
      rating: json['rating'],
      productName: (json['tags'] != null && (json['tags'] as List).length > 1)
          ? json['tags'][1]
          : '',
      discountPercentage: json['discountPercentage'] ?? 0,
      categoryName: (json['tags'] != null && (json['tags'] as List).isNotEmpty)
          ? json['tags'][0].toString()
          : 'unknown',
    );
  }
}
