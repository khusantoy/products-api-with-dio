import 'package:dio/dio.dart';
import 'package:products_api_with_dio/data/models/product.dart';

class DioClient {
  final _dio = Dio();

  DioClient._privite() {
    _dio.options
      ..connectTimeout = const Duration(seconds: 3)
      ..receiveTimeout = const Duration(seconds: 3)
      ..responseType = ResponseType.json
      ..baseUrl = "https://api.escuelajs.co/api/v1";
  }

  static final _singletonConstructor = DioClient._privite();

  factory DioClient() {
    return _singletonConstructor;
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addProduct({
    required String title,
    required int price,
    required String description,
    required int categoryId,
    required List<String> images,
  }) async {
    final data = {
      "title": title,
      "price": price,
      "description": description,
      "category_id": categoryId,
      "images": images,
    };

    try {
      final response = await _dio.post("/products/", data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct({required int id}) async {
    try {
      await _dio.delete("/products/$id");
      print("Product deleted!");
    } catch (e) {
      rethrow;
    }
  }
}
