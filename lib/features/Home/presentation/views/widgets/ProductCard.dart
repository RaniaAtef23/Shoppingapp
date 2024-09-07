import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/core/utils/app_router.dart';
import 'package:shopping_app/features/CartFavoriteItems/presentation/views/widgets/cart_widget.dart';
import 'package:shopping_app/features/CartFavoriteItems/presentation/views/widgets/favorite_product_notifier.dart';
import '../../../data/models/Products.dart';
import '../details_screen.dart';
import '../../../../CartFavoriteItems/presentation/views/cart_view.dart';

class ProductCard extends StatefulWidget {
  final Products product;

  const ProductCard({super.key, required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        FavoriteProductNotifier.addFavorite(widget.product);
      } else {
        FavoriteProductNotifier.removeFavorite(widget.product);
      }
    });
  }

  void addToCart() {
    CartWidget.addProduct(widget.product);
    Navigator.pushNamed(context, Routes.cartView);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,  // Adjusted height to a fixed value for better constraint handling
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.detailsScreen,
            arguments: widget.product,
          );
        },
        child: Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 100.h,  // Ensure image height is within bounds
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final imageHeight = constraints.maxHeight ;
                          return ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                            child: Image.network(
                              widget.product.thumbnail ?? 'https://via.placeholder.com/150',
                              height: imageHeight,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Center(
                                child: Icon(Icons.error, color: Colors.red, size: 30),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: ValueListenableBuilder<List<Products>>(
                        valueListenable: FavoriteProductNotifier.favoriteProductsNotifier,
                        builder: (context, favoriteProducts, child) {
                          final isFavorite = favoriteProducts.contains(widget.product);
                          return IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                              size: 20.sp,
                            ),
                            onPressed: toggleFavorite,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
                        ),
                        child: Center(
                          child: FittedBox(
                            child: Text(
                              widget.product.title ?? 'Product Title',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                                (index) => Icon(
                              index < (widget.product.rating ?? 0).toInt()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.orange,
                              size: 15.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.shopping_cart, color: Colors.red, size: 20.sp),
                              onPressed: addToCart,
                            ),
                            Text(
                              '\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
