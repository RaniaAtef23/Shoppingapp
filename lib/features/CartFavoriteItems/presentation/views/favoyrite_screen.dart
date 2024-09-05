import 'package:flutter/material.dart';
import 'package:shopping_app/features/CartFavoriteItems/presentation/views/widgets/favorite_product_notifier.dart';
import 'package:shopping_app/features/CartFavoriteItems/presentation/views/widgets/product_tile.dart';
import '../../../Home/data/models/Products.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Favorite List",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.orange,
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<List<Products>>(
        valueListenable: FavoriteProductNotifier.favoriteProductsNotifier,
        builder: (context, favoriteProducts, child) {
          if (favoriteProducts.isEmpty) {
            return const Center(child: Text('No favorites added.'));
          }
          return ListView.builder(
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = favoriteProducts[index];
              return ProductTile(product: product);
            },
          );
        },
      ),
    );
  }
}
