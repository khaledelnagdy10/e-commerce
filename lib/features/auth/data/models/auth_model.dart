class AuthRequestedModel {
  final String email;
  final String password;

  AuthRequestedModel({required this.email, required this.password});

  factory AuthRequestedModel.fromJson(Map<String, dynamic> json) {
    return AuthRequestedModel(email: json['email'], password: json['password']);
  }
}
