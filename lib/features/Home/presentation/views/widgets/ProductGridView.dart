import 'package:flutter/material.dart';
import 'package:shopping_app/features/Home/data/models/Products.dart';
import 'package:shopping_app/features/Home/presentation/views/widgets/ProductCard.dart';

class ProductGridView extends StatelessWidget {
  final List<Products> products;

  const ProductGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('No products available'));
    }


    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true, // Allows GridView to fit within the constraints of its parent
        physics: const NeverScrollableScrollPhysics(), // Disable scrolling
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 2, // Responsive horizontal spacing
          mainAxisSpacing: 2, // Responsive vertical spacing
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
