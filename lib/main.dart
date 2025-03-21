import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/services/api_service.dart';
import 'package:e_commerce_app/features/presentation/auth/controller/authCubit/auth_cubit.dart';
import 'package:e_commerce_app/features/presentation/auth/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(ApiService(dio: Dio())),
      child: const MaterialApp(home: AuthView()),
    );
  }
}
