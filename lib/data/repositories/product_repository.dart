import 'package:products_api_with_dio/data/models/product.dart';
import 'package:products_api_with_dio/data/services/dio_products_services.dart';

class ProductRepository {
  final DioProductsServices _dioProductsServices;

  ProductRepository({required DioProductsServices dioProductsServices})
      : _dioProductsServices = dioProductsServices;

  Future<List<Product>> getProducts() async {
    return await _dioProductsServices.getProducts();
  }

  Future<Product> addProduct({
    required String title,
    required int price,
    required String description,
    required int categoryId,
    required List<String> images,
  }) async {
    final response = await _dioProductsServices.addProduct(
        title: title,
        price: price,
        description: description,
        categoryId: categoryId,
        images: images);

    return response;
  }

  Future<void> deleteProduct({required int id}) async {
    return await _dioProductsServices.deleteProduct(id: id);
  }
}
