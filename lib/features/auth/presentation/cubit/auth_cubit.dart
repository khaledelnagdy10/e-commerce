import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/auth/data/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit({
    required AuthRepository repository,
  })  : _repository = repository,
        super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final data = await _repository.login(
        email: email,
        password: password,
      );

      log("AuthCubit - login - user: $data");
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure());
    }
  }
}
