import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:store_app2/core/data/cache_data/local_cache_data.dart';
import 'package:store_app2/core/data/services/auth/auth_data_base.dart';
import 'package:store_app2/core/utils/models/all_product_model.dart';
import 'package:store_app2/core/utils/models/my_orders_model.dart';
import 'package:store_app2/core/utils/widgets/error_model.dart';

part 'my_order_state.dart';

class MyOrderCubit extends Cubit<MyOrderCubitState> {
  MyOrderCubit({required this.firebaseFirestore})
    : super(MyOrderCubitInitial());
  final AuthDataBase firebaseFirestore;
  List<MyOrdersModel> newOrder = [];
  Future addOrder(MyOrdersModel order) async {
    final uid = await CacheData.getData(key: 'email');

    try {
      final orderId = FirebaseFirestore.instance
          .collection('users/$uid/orders')
          .doc()
          .id;
      await firebaseFirestore.set(
        collectionPath: 'users/$uid/orders',
        doc: orderId,
        data: order.toJson(),
        merge: true,
      );
      newOrder.add(order);
      emit(MyOrderCubitAdded(orders: List.from(newOrder)));
      log('${order.toJson()}');
    } catch (e) {
      emit(MyOrderCubitFailure(errMess: ErrorModel(errMessage: e.toString())));
    }
  }

  Future getOrders() async {
    final uid = await CacheData.getData(key: 'email');

    emit(MyOrderCubitLoading());
    try {
      final orders = await firebaseFirestore.getCollection(
        collectionPath: 'users/$uid/orders',
      );
      final ordersFromJson = orders.docs
          .map((doc) => MyOrdersModel.fromJson(doc.data()))
          .toList();
      emit(MyOrderCubitAdded(orders: ordersFromJson));
    } catch (e) {
      emit(MyOrderCubitFailure(errMess: ErrorModel(errMessage: e.toString())));
    }
  }
}

//   final List newOrder = [];

//   Future<void> addOrder(List<AllProductModel> products) async {
//     final uid = await CacheData.getData(key: 'email');
//     if (uid == null || products.isEmpty) return;

//     final order = MyOrdersModel(products: products, createdAt: DateTime.now());

//     try {
//       await firebaseFirestore.update(
//         collectionPath: 'users',
//         doc: uid,
//         data: {
//           'orders': FieldValue.arrayUnion([order.toJson()]),
//         },
//       );

//       // تحديث الـ list الداخلية
//       newOrder.add(order);

//       emit(
//         MyOrderCubitAdded(myOrders: List.from(newOrder)),
//       ); // emit كامل القائمة
//       log('✅ Order added successfully: ${order.toJson()}');
//     } catch (e) {
//       log('❌ Error adding order: $e');
//       rethrow;
//     }
//   }

//   Future<void> getOrders() async {
//     final uid = await CacheData.getData(key: 'email');
//     if (uid == null) return;

//     try {
//       final userDoc = await firebaseFirestore.getDoc(
//         collectionPath: 'users',
//         doc: uid,
//       );
//       final data = userDoc.data();

//       if (data == null || data['orders'] == null) {
//         emit(MyOrderCubitAdded(myOrders: []));
//         return;
//       }

//       final orders = (data['orders'] as List)
//           .map((p) => MyOrdersModel.fromJson(p))
//           .toList();

//       emit(MyOrderCubitAdded(myOrders: orders));
//       log('📦 Orders fetched: ${orders.length}');
//     } catch (e) {
//       log('❌ Error getting orders: $e');
//       rethrow;
//     }
//   }
// }
