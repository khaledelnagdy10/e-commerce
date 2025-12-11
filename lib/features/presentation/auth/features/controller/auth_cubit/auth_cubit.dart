import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/services/auth/auth_data_base.dart';

import 'package:store_app2/core/data/services/auth/auth_service.dart';
import 'package:store_app2/core/data/cache_data/local_cache_data.dart';
import 'package:store_app2/core/utils/models/address_model.dart';
import 'package:store_app2/core/utils/widgets/error_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authService, required this.firebaseFirestore})
    : super(AuthInitial());
  final AuthService authService;
  final AuthDataBase firebaseFirestore;
  Map<String, dynamic> userData = {};

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required AddressModel address,
  }) async {
    emit(AuthLoading());

    try {
      UserCredential userCredential = await authService
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
            fullName: fullName,
          );

      FirebaseAuth.instance.currentUser!.sendEmailVerification();

      await firebaseFirestore.set(
        collectionPath: 'users',
        doc: userCredential.user!.uid,
        data: {
          'name': fullName,
          'email': email,
          'password': password,
          'address': address.toJson(),
          'googleAccount': false,
        },
      );

      emit(AuthSignUpSuccess());
    } on ErrorModel catch (e) {
      emit(AuthFailure(errorModel: e));
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      UserCredential userCredential = await authService
          .signInWithEmailAndPassword(email: email, password: password);
      if (!userCredential.user!.emailVerified) {
        emit(
          AuthFailure(
            errorModel: ErrorModel(
              errMessage: 'Please verify your email first',
            ),
          ),
        );
        return;
      }
      await firebaseFirestore.getDoc(
        collectionPath: 'users',
        doc: userCredential.user!.uid,
      );
      await CacheData.setData(key: 'email', value: userCredential.user!.uid);

      emit(AuthLoginSuccess());
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
          'email': userCredential.user!.email,
          'googleAccount': true,
          'password': '',
        },
        merge: true,
      );
      await firebaseFirestore.getDoc(
        collectionPath: 'users',
        doc: userCredential.user!.uid,
      );
      await CacheData.setData(key: 'email', value: userCredential.user!.uid);
      emit(AuthLoginSuccess());
    } on ErrorModel catch (e) {
      emit(AuthFailure(errorModel: e));
    } catch (e) {
      log('Unexpected error: $e');
      emit(AuthFailure(errorModel: ErrorModel(errMessage: 'Unexpected: $e')));
    }
  }

  Future<void> getUserData() async {
    final uid = CacheData.getData(key: 'email');

    if (uid == null) {
      userData = {};
      emit(AuthGetUserSuccess());
      return;
    }

    emit(AuthLoading());

    try {
      final userDoc = await firebaseFirestore.getDoc(
        collectionPath: 'users',
        doc: uid,
      );

      userData = userDoc.data() ?? {};
      userData['emailVerified'] =
          FirebaseAuth.instance.currentUser!.emailVerified;

      emit(AuthGetUserSuccess());
    } catch (e) {
      emit(AuthFailure(errorModel: ErrorModel(errMessage: '$e')));
    }
  }

  Future<void> signOut() async {
    await CacheData.remove();
    await authService.signOut();

    userData = {};
    emit(AuthLogoutSuccess());
  }
}
