import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api_with_dio/blocs/products/products_bloc.dart';
import 'package:products_api_with_dio/data/models/product.dart';
import 'package:products_api_with_dio/ui/screens/manage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<ProductsBloc>().add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products List"),
        backgroundColor: Colors.amber,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageScreen(),
                  ),
                );
              },
              child: const Text("Add"),
            ),
          )
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is LoadingProductsState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorProductsState) {
            return Center(
              child: Text(state.message),
            );
          }

          List<Product> products = [];

          if (state is LoadedProductsState) {
            products = state.products;
          }

          return products.isEmpty
              ? const Center(
                  child: Text("Mavjud emas"),
                )
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (ctx, index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.title),
                              Text(product.description),
                              Text(product.price.toString()),
                              Text(product.category.name),
                              Text(product.creationAt),
                              Text(product.updatedAt),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.amber,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ManageScreen(
                                                title: product.title,
                                                price: product.price,
                                                description:
                                                    product.description,
                                                images: product.images,
                                                productId: product.id,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: IconButton(
                                      onPressed: () {
                                        context.read<ProductsBloc>().add(
                                            DeleteProductEvent(product.id));
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
