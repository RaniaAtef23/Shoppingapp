
import 'package:shopping_app/features/Home/data/models/Products.dart';

class ProductList {
  final List<Products>? products;
  final num? total;
  final num? skip;
  final num? limit;

  ProductList({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) {
    return ProductList(
      products: (json['products'] as List<dynamic>?)
          ?.map((item) => Products.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: json['total'] as num?,
      skip: json['skip'] as num?,
      limit: json['limit'] as num?,
    );
  }
}