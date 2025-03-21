import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/services/api_service.dart';
import 'package:e_commerce_app/core/services/cache_service.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:e_commerce_app/features/auth/data/repository/auth_repository.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/view/auth_view.dart';
import 'package:e_commerce_app/features/user/data/data_sources/user_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio(BaseOptions(baseUrl: "https://dummyjson.com"));

    dio.interceptors.add(
      LogInterceptor(
        responseHeader: false,
        responseBody: true,
        requestBody: true,
      ),
    );

    final apiService = ApiService(dio: dio);

    final cacheService = CacheService();

    return BlocProvider(
      create: (context) => AuthCubit(
        repository: AuthRepository(
          authRemoteDataSource: AuthRemoteDataSource(apiService: apiService),
          userLocalDataSource: UserLocalDataSource(cacheService: cacheService),
        ),
      ),
      child: const MaterialApp(
        home: AuthView(),
      ),
    );
  }
}
