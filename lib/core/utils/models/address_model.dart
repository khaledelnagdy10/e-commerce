class AddressModel {
  String city;
  String region;
  String street;

  AddressModel({
    required this.city,
    required this.region,
    required this.street,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      city: json['city'] ?? '',
      region: json['region'] ?? '',
      street: json['street'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'city': city, 'region': region, 'street': street};
  }
}
