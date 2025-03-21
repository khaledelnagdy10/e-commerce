import 'package:e_commerce_app/core/services/cache_service.dart';

class UserLocalDataSource {
  final CacheService _cacheService;

  UserLocalDataSource({required CacheService cacheService}) : _cacheService = cacheService;

  saveUser({required Map<String, dynamic> user}) async {
    _cacheService.setMap("user", user);
  }

  Future<Map<String, dynamic>?> getUser() async {
    return _cacheService.getMap("user");
  }
}
