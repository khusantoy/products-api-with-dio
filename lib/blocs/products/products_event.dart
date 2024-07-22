part of 'products_bloc.dart';

sealed class ProductsEvent {}

final class GetProductsEvent extends ProductsEvent {}

final class AddProductEvent extends ProductsEvent {
  final String title;
  final int price;
  final String description;
  final int categoryId;
  final List<String> images;

  AddProductEvent(
      this.title, this.price, this.description, this.categoryId, this.images);
}

final class EditProductEvent extends ProductsEvent {
  final int id;
  final String title;
  final int price;
  final String description;
  final int categoryId;
  final List<String> images;

  EditProductEvent(
    this.id,
    this.title,
    this.price,
    this.description,
    this.categoryId,
    this.images,
  );
}

final class DeleteProductEvent extends ProductsEvent {
  final int id;

  DeleteProductEvent(this.id);
}
