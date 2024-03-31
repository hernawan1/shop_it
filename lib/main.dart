import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shop_it/common/constant.dart';
import 'package:shop_it/src/auth/cubit/auth_cubit.dart';
import 'package:shop_it/src/produk/bloc/kategori_produk_bloc.dart';
import 'package:shop_it/src/produk/bloc/produk_list_bloc.dart';
import 'package:shop_it/src/produk/bloc/search_produk_bloc.dart';

import 'package:shop_it/src/splash/splash_page.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<ProdukListBloc>(create: (context) => ProdukListBloc()),
        BlocProvider<SearchProdukBloc>(create: (context) => SearchProdukBloc()),
        BlocProvider<KategoriProdukBloc>(
            create: (context) => KategoriProdukBloc()),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: primary,
            backgroundColor: Colors.white,
            secondaryHeaderColor: primary,
            appBarTheme: const AppBarTheme(
              color: primary,
            ),
          ),
          home: const SplashScreen(),
          builder: EasyLoading.init(),
        );
      }),
    );
  }
}
