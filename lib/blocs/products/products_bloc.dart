import 'package:bloc/bloc.dart';
import 'package:products_api_with_dio/data/repositories/product_repository.dart';

import '../../data/models/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository _productRepository;

  ProductsBloc({required ProductRepository productsRepository})
      : _productRepository = productsRepository,
        super(InitialProductsState()) {
    on<GetProductsEvent>(_getProducts);
    on<DeleteProductEvent>(_deleteProduct);
    on<AddProductEvent>(_addProduct);
    on<EditProductEvent>(_editProduct);
  }

  void _getProducts(GetProductsEvent event, Emitter<ProductsState> emit) async {
    emit(LoadingProductsState());

    try {
      final response = await _productRepository.getProducts();
      emit(LoadedProductsState(response));
    } catch (e) {
      emit(ErrorProductsState(e.toString()));
    }
  }

  void _addProduct(AddProductEvent event, Emitter<ProductsState> emit) async {
    List<Product> existingProducts = [];

    if (state is LoadedProductsState) {
      existingProducts = (state as LoadedProductsState).products;
    }

    emit(LoadingProductsState());

    try {
      final product = await _productRepository.addProduct(
          title: event.title,
          price: event.price,
          description: event.description,
          categoryId: event.categoryId,
          images: event.images);

      existingProducts.add(product);
      emit(LoadedProductsState(existingProducts));
    } catch (e) {
      emit(ErrorProductsState(e.toString()));
    }
  }

  void _editProduct(EditProductEvent event, Emitter<ProductsState> emit) async {
    List<Product> existingProducts = [];

    if (state is LoadedProductsState) {
      existingProducts = (state as LoadedProductsState).products;
    }

    emit(LoadingProductsState());

    try {
      final product = await _productRepository.editProduct(
          id: event.id,
          title: event.title,
          price: event.price,
          description: event.description,
          categoryId: event.categoryId,
          images: event.images);

      for (var product in existingProducts) {
        if (product.id == event.id) {
          product.title = event.title;
          product.price = event.price;
          product.description = event.description;
          product.category.id = event.categoryId;
          product.images = event.images;
        }
      }
      emit(LoadedProductsState(existingProducts));
    } catch (e) {
      emit(ErrorProductsState(e.toString()));
    }
  }

  void _deleteProduct(
      DeleteProductEvent event, Emitter<ProductsState> emit) async {
    List<Product> existingProducts = [];

    if (state is LoadedProductsState) {
      existingProducts = (state as LoadedProductsState).products;
    }

    emit(LoadingProductsState());
    try {
      await _productRepository.deleteProduct(id: event.id);
      existingProducts.removeWhere((product) {
        return product.id == event.id;
      });
      emit(LoadedProductsState(existingProducts));
    } catch (e) {
      emit(ErrorProductsState(e.toString()));
    }
  }
}
