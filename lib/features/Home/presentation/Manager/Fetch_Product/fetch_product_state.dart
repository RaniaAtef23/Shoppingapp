

import 'package:shopping_app/features/Home/data/models/Products.dart';


abstract class FetchProductState {}

class FetchProductInitial extends FetchProductState {}

class FetchProductLoading extends FetchProductState {}

class FetchProductSuccess extends FetchProductState {
  final List<Products> popularProducts;
  final List<Products> flashSaleProducts;
  final List<Products> moreproducts;

  FetchProductSuccess({required this.popularProducts, required this.flashSaleProducts,required this.moreproducts});
}

class FetchProductFailure extends FetchProductState {
  final String error;

  FetchProductFailure(this.error);
}
