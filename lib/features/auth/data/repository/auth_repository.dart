import 'package:e_commerce_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:e_commerce_app/features/user/data/data_sources/user_local_data_source.dart';
import 'package:e_commerce_app/features/user/data/models/user_model.dart';

class AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  AuthRepository({
    required AuthRemoteDataSource authRemoteDataSource,
    required UserLocalDataSource userLocalDataSource,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _userLocalDataSource = userLocalDataSource;

  login({
    required String email,
    required String password,
  }) async {
    final userJson = await _authRemoteDataSource.login(email: email, password: password);
    final user = UserModel.fromJson(userJson);
    _userLocalDataSource.saveUser(user: user.toJson());
  }
}
