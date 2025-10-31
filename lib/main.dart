import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app2/core/data/services/all_product.dart';
import 'package:store_app2/core/data/services/auth/auth_data_base.dart';
import 'package:store_app2/core/data/services/auth/auth_service.dart';
import 'package:store_app2/core/data/services/get_all_category.dart';
import 'package:store_app2/core/data/services/get_category_products.dart';
import 'package:store_app2/core/data/services/local_cache_data.dart';
import 'package:store_app2/core/utils/text_style.dart';
import 'package:store_app2/features/presentation/auth/features/controller/auth_cubit/auth_cubit.dart';
import 'package:store_app2/features/presentation/auth/features/view/auth_view.dart';
import 'package:store_app2/features/presentation/bag/features/controller/Bag%20cubit/bag_cubit.dart';
import 'package:store_app2/features/presentation/home/features/controller/cubit/all_product_cubit.dart';
import 'package:store_app2/features/presentation/home/features/view/home_view.dart';
import 'package:store_app2/features/presentation/shop/features/controller/categories_cubit/categories_cubit.dart';
import 'package:store_app2/features/presentation/shop/features/controller/category_product_cubit/category_product_cubit.dart';
import 'package:store_app2/firebase_options.dart';
import 'features/presentation/favorite/features/controller/Favourite cubit/favorite_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheData.cacheInitialization();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cachedEmail = CacheData.getData(key: 'email');

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            authService: AuthService(auth: FirebaseAuth.instance),
            firebaseFirestore: AuthDataBase(
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
        BlocProvider(create: (context) => FavoriteCubit()),

        BlocProvider(
          create: (context) =>
              AllProductCubit(allProductService: AllProductService())
                ..fetchAllProduct(),
        ),

        BlocProvider(
          create: (context) =>
              CategoriesCubit(getAllCategory: GetAllCategoryService())
                ..fetchCategories(),
        ),
        BlocProvider(create: (context) => BagCubit()),
        BlocProvider(
          create: (context) => CategoryProductCubit(
            getCategoryProductService: GetCategoryProductService(),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade200,
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
          cardTheme: CardThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 2,
            centerTitle: true,
            foregroundColor: Colors.black,
            titleTextStyle: Style.textStyleAppBarBlack,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              textStyle: Style.textStyleBold16White,
            ),
          ),
        ),
        home: cachedEmail != null ? HomeView() : AuthView(authType: 0),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
