

import '../../../data/models/Products.dart';

sealed class ProductCategoryState {}

final class ProductCategoryInitial extends ProductCategoryState {}
final class ProductCategoryLoading extends ProductCategoryState {}
final class ProductCategorySuccess extends ProductCategoryState {
  final List<Products> products;

  ProductCategorySuccess(this.products);
}
final class ProductCategoryFailure extends ProductCategoryState {
  final String error;
  ProductCategoryFailure(this.error);

}