import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/features/Home/presentation/views/widgets/smallProductCard.dart';
import '../../../data/models/Products.dart';

class PopularProductList extends StatelessWidget {
  final List<Products> products;

  const PopularProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w), // Responsive horizontal padding
      child: SizedBox(
        height: 240.h, // Responsive height
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Padding(
              padding: EdgeInsets.only(right: 8.w), // Responsive right padding
              child: SmallProductCard(product: product),
            );
          },
        ),
      ),
    );
  }
}
