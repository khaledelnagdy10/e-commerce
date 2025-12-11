import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:store_app2/core/data/cache_data/local_cache_data.dart';
import 'package:store_app2/core/data/services/auth/auth_data_base.dart';
import 'package:store_app2/core/utils/models/address_model.dart';
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
      order.id = orderId;

      await firebaseFirestore.set(
        collectionPath: 'users/$uid/orders',
        doc: orderId,
        data: order.toJson(),
        merge: true,
      );
      newOrder.add(order);
      await getOrders();
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
      final ordersFromJson = orders.docs.map((doc) {
        final order = MyOrdersModel.fromJson(doc.data());
        order.id = doc.id;
        return order;
      }).toList();
      newOrder = ordersFromJson;
      emit(MyOrderCubitAdded(orders: List.from(newOrder)));
    } catch (e) {
      emit(MyOrderCubitFailure(errMess: ErrorModel(errMessage: e.toString())));
    }
  }

  Future updateOrderStatus(String orderId, String newStatus) async {
    final uid = await CacheData.getData(key: 'email');
    emit(MyOrderCubitLoading());
    try {
      await firebaseFirestore.update(
        collectionPath: 'users/$uid/orders',
        doc: orderId,
        data: {'status': newStatus},
      );

      final index = newOrder.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        newOrder[index].status = newStatus;
      }

      emit(MyOrderCubitAdded(orders: List.from(newOrder)));
    } catch (e) {
      emit(MyOrderCubitFailure(errMess: ErrorModel(errMessage: e.toString())));
    }
  }

  Future updateOrderAddress(String orderId, AddressModel newAddress) async {
    final uid = await CacheData.getData(key: 'email');
    emit(MyOrderCubitLoading());
    try {
      await firebaseFirestore.update(
        collectionPath: 'users/$uid/orders',
        doc: orderId,
        data: {'address': newAddress.toJson()},
      );

      final index = newOrder.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        newOrder[index].address = newAddress;
      }

      emit(MyOrderCubitAdded(orders: List.from(newOrder)));
    } catch (e) {
      emit(MyOrderCubitFailure(errMess: ErrorModel(errMessage: e.toString())));
    }
  }

  Future updateOrderName(String orderId, String newName) async {
    final uid = await CacheData.getData(key: 'email');
    emit(MyOrderCubitLoading());
    try {
      await firebaseFirestore.update(
        collectionPath: 'users/$uid/orders',
        doc: orderId,
        data: {'name': newName},
      );

      final index = newOrder.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        newOrder[index].name = newName;
      }

      emit(MyOrderCubitAdded(orders: List.from(newOrder)));
    } catch (e) {
      emit(MyOrderCubitFailure(errMess: ErrorModel(errMessage: e.toString())));
    }
  }
}
