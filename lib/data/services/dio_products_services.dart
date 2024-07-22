import 'package:dio/dio.dart';
import 'package:products_api_with_dio/core/network/dio_client.dart';
import 'package:products_api_with_dio/data/models/product.dart';

class DioProductsServices {
  final _dioClient = DioClient();

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dioClient.get(url: "/products");

      List<Product> products = [];

      for (var productData in response.data) {
        products.add(Product.fromMap(productData));
      }
      return products;
    } on DioException catch (e) {
      print(e.response?.data);
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Product> addProduct({
    required String title,
    required int price,
    required String description,
    required int categoryId,
    required List<String> images,
  }) async {
    try {
      final response = await _dioClient.addProduct(
          title: title,
          price: price,
          description: description,
          categoryId: categoryId,
          images: images);

      return Product.fromMap(response.data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Product> editProduct({
    required int id,
    required String title,
    required int price,
    required String description,
    required int categoryId,
    required List<String> images,
  }) async {
    try {
      final response = await _dioClient.editProduct(
          id: id,
          title: title,
          price: price,
          description: description,
          categoryId: categoryId,
          images: images);

      return Product.fromMap(response.data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteProduct({required int id}) async {
    try {
      await _dioClient.deleteProduct(id: id);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
