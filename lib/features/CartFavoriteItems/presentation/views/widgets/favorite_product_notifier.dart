import 'package:flutter/foundation.dart';
import 'package:shopping_app/features/Home/data/models/Products.dart';

class FavoriteProductNotifier {
  static ValueNotifier<List<Products>> favoriteProductsNotifier = ValueNotifier([]);

  static void addFavorite(Products product) {
    if (!favoriteProductsNotifier.value.contains(product)) {
      favoriteProductsNotifier.value = [...favoriteProductsNotifier.value, product];
    }
  }

  static void removeFavorite(Products product) {
    favoriteProductsNotifier.value =
        favoriteProductsNotifier.value.where((p) => p != product).toList();
  }
}
