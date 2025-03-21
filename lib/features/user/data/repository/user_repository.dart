import 'package:e_commerce_app/features/user/data/data_sources/user_local_data_source.dart';
import 'package:e_commerce_app/features/user/data/models/user_model.dart';

class UserRepository {
  final UserLocalDataSource _userLocalDataSource;

  UserRepository({
    required UserLocalDataSource userLocalDataSource,
  }) : _userLocalDataSource = userLocalDataSource;

  Future<UserModel?> getUser() async {
    final userMap = await _userLocalDataSource.getUser();
    return UserModel.fromJson(userMap!);
  }
}
