
import 'package:shopping_app/features/Home/data/models/Dimensions.dart';
import 'package:shopping_app/features/Home/data/models/Meta.dart';
import 'package:shopping_app/features/Home/data/models/Reviews.dart';

class Products {
  final num? id;
  final String? title;
  final String? description;
  final String? category;
  final num? price;
  final num? discountPercentage;
  final num? rating;
  final num? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final num? weight;
  final Dimensions? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<Reviews>? reviews;
  final String? returnPolicy;
  final num? minimumOrderQuantity;
  final Meta? meta;
  final List<String>? images;
  final String? thumbnail;

  Products({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'] as num?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      price: json['price'] as num?,
      discountPercentage: json['discountPercentage'] as num?,
      rating: json['rating'] as num?,
      stock: json['stock'] as num?,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      brand: json['brand'] as String?,
      sku: json['sku'] as String?,
      weight: json['weight'] as num?,
      dimensions: json['dimensions'] != null ? Dimensions.fromJson(
          json['dimensions']) : null,
      warrantyInformation: json['warrantyInformation'] as String?,
      shippingInformation: json['shippingInformation'] as String?,
      availabilityStatus: json['availabilityStatus'] as String?,
      reviews: json['reviews'] != null
          ? (json['reviews'] as List<dynamic>).map((item) =>
          Reviews.fromJson(item as Map<String, dynamic>)).toList()
          : null,
      returnPolicy: json['returnPolicy'] as String?,
      minimumOrderQuantity: json['minimumOrderQuantity'] as num?,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      thumbnail: json['thumbnail'] as String?,
    );
  }
}