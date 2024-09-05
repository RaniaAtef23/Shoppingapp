import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/features/CartFavoriteItems/presentation/views/widgets/cart_widget.dart';
import '../../../../Home/data/models/Products.dart';
import 'favorite_product_notifier.dart';

class ProductTile extends StatelessWidget {
  final Products product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
              FavoriteProductNotifier.removeFavorite(product);
            },
          ),
        ],
      ),
    );
  }
}
