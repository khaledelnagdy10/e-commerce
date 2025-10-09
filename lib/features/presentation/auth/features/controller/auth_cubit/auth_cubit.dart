import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/services/auth/auth_data_base.dart';

import 'package:store_app2/core/data/services/auth/auth_service.dart';
import 'package:store_app2/core/data/services/local_cache_data.dart';
import 'package:store_app2/core/utils/widgets/error_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authService, required this.firebaseFirestore})
    : super(AuthInitial());
  final AuthService authService;
  final AuthDataBase firebaseFirestore;
  dynamic value = '';

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    emit(AuthLoading());

    try {
      UserCredential userCredential = await authService
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
            fullName: fullName,
          );

      firebaseFirestore.set(
        collectionPath: 'users',
        doc: userCredential.user!.uid,
        data: {'name': fullName, 'email': email, 'password': password},
      );

      emit(AuthSuccess());
    } on ErrorModel catch (e) {
      emit(AuthFailure(errorModel: e));
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      UserCredential userCredential = await authService
          .signInWithEmailAndPassword(email: email, password: password);
      firebaseFirestore.getDoc(
        collectionPath: 'users',
        doc: userCredential.user!.uid,
      );
      CacheData.setData(key: 'email', value: userCredential.user!.uid);

      emit(AuthSuccess());
    } on ErrorModel catch (e) {
      emit(AuthFailure(errorModel: e));
    } catch (e) {
      emit(AuthFailure(errorModel: ErrorModel(errMessage: 'Unexpected: $e')));
    }
  }

  Future<void> googleSignIn() async {
    emit(AuthLoading());
    UserCredential userCredential = await authService.signInWithGoogle();
    try {
      await firebaseFirestore.set(
        collectionPath: 'users',
        doc: userCredential.user!.uid,
        data: {
          'name': userCredential.user!.displayName,
          'email': userCredential.user?.email ?? '',
          'googleAccount': true,
        },
      );
      firebaseFirestore.getDoc(
        collectionPath: 'users',
        doc: userCredential.user!.uid,
      );
      CacheData.setData(key: 'email', value: userCredential.user!.uid);
      emit(AuthSuccess());
    } on ErrorModel catch (e) {
      emit(AuthFailure(errorModel: e));
    } catch (e, stacktrace) {
      log('❗ Unexpected error: $e');
      log('📌 Stacktrace: $stacktrace');
      emit(AuthFailure(errorModel: ErrorModel(errMessage: 'Unexpected: $e')));
    }
  }

  // Future<void> faceBookSignIn() async {
  //   emit(AuthLoading());

  //   try {
  //     UserCredential userCredential = await authService.signInWithFacebook();
  //     firebaseFirestore.set(
  //       collectionPath: 'users',
  //       doc: userCredential.user!.uid,
  //       data: {
  //         'name': userCredential.user!.displayName,
  //         'email': userCredential.user?.email ?? '',
  //         'faceBookAccount': true,
  //       },
  //     );
  //     firebaseFirestore.getDoc(
  //       collectionPath: 'users',
  //       doc: userCredential.user!.uid,
  //     );
  //     emit(AuthSuccess());
  //   } on ErrorModel catch (e) {
  //     log(e.toString());
  //     emit(AuthFailure(errorModel: e));
  //   } catch (e) {
  //     log(e.toString());

  //     emit(AuthFailure(errorModel: ErrorModel(errMessage: 'Unexpected: $e')));
  //   }
  // }
}
