import 'package:cloud_firestore/cloud_firestore.dart';

class AuthDataBase {
  final FirebaseFirestore firestore;
  AuthDataBase({required this.firestore});

  Future<dynamic> set({
    required String collectionPath,
    required String doc,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(doc)
        .set(data, merge ? SetOptions(merge: true) : null);
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

  Future<void> update({
    required String collectionPath,
    required String doc,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(collectionPath).doc(doc).update(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCollection({
    required String collectionPath,
  }) async {
    return await FirebaseFirestore.instance.collection(collectionPath).get();
  }
}
