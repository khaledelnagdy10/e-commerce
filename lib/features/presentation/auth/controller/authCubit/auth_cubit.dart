import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/services/api_service.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._apiService) : super(AuthInitial());
  final ApiService _apiService;
  Future<void> post({required String email, required String password}) async {
    try {
      await _apiService.post(email, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure());
    }
  }
}
