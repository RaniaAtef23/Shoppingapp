import 'package:flutter/material.dart';

import 'package:shopping_app/features/Home/data/models/Products.dart';
import 'package:shopping_app/features/Home/presentation/views/widgets/ProductCard.dart';

class ProductGridView extends StatelessWidget {
  final List<Products> products;

  const ProductGridView({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Center(child: Text('No products available'));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true, // Allows GridView to fit within the constraints of its parent
        physics: const NeverScrollableScrollPhysics(), // Disable scrolling
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 8.0, // Horizontal spacing between items
          mainAxisSpacing: 8.0, // Vertical spacing between items
          childAspectRatio: 0.6, // Aspect ratio of each item
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}