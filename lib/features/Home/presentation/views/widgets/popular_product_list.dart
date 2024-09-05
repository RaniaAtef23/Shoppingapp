
import 'package:flutter/material.dart';
import 'package:shopping_app/features/Home/presentation/views/widgets/smallProductCard.dart';
import '../../../data/models/Products.dart';

class PopularProductList extends StatelessWidget {
  final List<Products> products;

  const PopularProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 250.0, // Adjust the height as needed
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SmallProductCard(product: product),
            );
          },
        ),
      ),
    );
  }
}