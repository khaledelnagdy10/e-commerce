import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_app2/core/data/services/auth/auth_service.dart';

class AuthDataBase {
  final FirebaseFirestore firestore;
  AuthDataBase({required this.firestore});

  Future<dynamic> set({
    required String collectionPath,
    required String doc,
    required Map<String, dynamic> data,
  }) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(doc)
        .set(data);
  }

  Future<dynamic> add({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .add(data);
  }

  Future<dynamic> getDoc({
    required String collectionPath,
    required String doc,
  }) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(doc)
        .get();
  }

  Future<dynamic> getCollection({required String collectionPath}) async {
    return await FirebaseFirestore.instance.collection(collectionPath).get();
  }
}
