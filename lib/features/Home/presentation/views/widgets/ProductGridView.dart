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

    double padding = MediaQuery.of(context).size.width * 0.02; // 2% of screen width
    double crossAxisSpacing = MediaQuery.of(context).size.width * 0.02; // 2% of screen width
    double mainAxisSpacing = MediaQuery.of(context).size.height * 0.01; // 1% of screen height

    return Padding(
      padding: EdgeInsets.all(padding),
      child: GridView.builder(
        shrinkWrap: true, // Allows GridView to fit within the constraints of its parent
        physics: const NeverScrollableScrollPhysics(), // Disable scrolling
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: crossAxisSpacing, // Responsive horizontal spacing
          mainAxisSpacing: mainAxisSpacing, // Responsive vertical spacing
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
