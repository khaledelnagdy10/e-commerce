import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/services/auth/auth_data_base.dart';

import 'package:store_app2/core/data/services/auth/auth_service.dart';
import 'package:store_app2/core/data/cache_data/local_cache_data.dart';
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
  }) async {
    emit(AuthLoading());

    try {
      UserCredential userCredential = await authService
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
            fullName: fullName,
          );

      await firebaseFirestore.set(
        collectionPath: 'users',
        doc: userCredential.user!.uid,
        data: {
          'name': fullName,
          'email': email,
          'password': password,
          'googleAccount': false,
          'orders': [],
        },
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
          'password': '',
          'orders': [],
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
    } catch (e) {
      log('Unexpected error: $e');
      emit(AuthFailure(errorModel: ErrorModel(errMessage: 'Unexpected: $e')));
    }
  }

  Future<void> getUserData() async {
    emit(AuthLoading());
    try {
      final uid = await CacheData.getData(key: 'email');
      log('UID from cache: $uid');
      if (uid == null) return;

      final userDoc = await firebaseFirestore.getDoc(
        collectionPath: 'users',
        doc: uid,
      );
      log('User doc data: ${userDoc.data()}'); // ✅
      userData = userDoc.data() ?? {};
      emit(AuthSuccess());
    } on ErrorModel catch (e) {
      emit(AuthFailure(errorModel: e));
    } catch (e) {
      emit(AuthFailure(errorModel: ErrorModel(errMessage: 'Unexpected: $e')));
    }
  }

  Future<void> addOrder(List<dynamic> newOrder) async {
    final uid = await CacheData.getData(key: 'uid');
    if (uid == null) return;

    try {
      await firebaseFirestore.update(
        collectionPath: 'users',
        doc: uid,
        data: {
          'orders': FieldValue.arrayUnion([newOrder]),
        },
      );
      print('✅ Order added successfully!');
    } catch (e) {
      print('❌ Error adding order: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    final uid = await CacheData.getData(key: 'uid');
    if (uid == null) return [];

    try {
      final userDoc = await firebaseFirestore.getDoc(
        collectionPath: 'users',
        doc: uid,
      );

      final data = userDoc.data();
      if (data == null || data['orders'] == null) return [];

      final List<dynamic> ordersList = data['orders'];
      return ordersList.cast<Map<String, dynamic>>();
    } catch (e) {
      print('❌ Error getting orders: $e');
      return [];
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
