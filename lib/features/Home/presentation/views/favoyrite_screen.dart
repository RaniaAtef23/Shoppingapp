import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import screen utilities
import 'package:shopping_app/features/Home/presentation/views/widgets/cart_widget.dart';
import '../../data/models/Products.dart';

class FavoritesScreen extends StatefulWidget {
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
        valueListenable: FavoritesScreen.favoriteProductsNotifier,
        builder: (context, favoriteProducts, child) {
          if (favoriteProducts.isEmpty) {
            return const Center(child: Text('No favorites added.'));
          }
          return ListView.builder(
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = favoriteProducts[index];
              return ListTile(
                leading: Image.network(
                  product.thumbnail ?? 'https://via.placeholder.com/150',
                  width: 50.w, // Use screen utility for width
                  height: 50.h, // Use screen utility for height
                ),
                title: Text(product.title ?? 'Product Title'),
                subtitle: Text('\$${product.price?.toStringAsFixed(2) ?? '0.00'}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart, color: Colors.orange),
                      onPressed: () {
                        CartWidget.addProduct(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product.title} added to cart')),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        FavoritesScreen.removeFavorite(product);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
