import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api_with_dio/blocs/products/products_bloc.dart';
import 'package:products_api_with_dio/data/repositories/product_repository.dart';
import 'package:products_api_with_dio/data/services/dio_products_services.dart';
import 'package:products_api_with_dio/ui/screens/home_screen.dart';

void main() {
  final dioProductsServices = DioProductsServices();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) {
            return ProductRepository(dioProductsServices: dioProductsServices);
          },
        )
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(create: (context) {
          return ProductsBloc(
            productsRepository: context.read<ProductRepository>(),
          );
        })
      ], child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
