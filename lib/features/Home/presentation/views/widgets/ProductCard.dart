import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/Products.dart';
import '../cart_view.dart';
import '../details_screen.dart';
import '../favoyrite_screen.dart';
import 'cart_widget.dart';

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
        FavoritesScreen.addFavorite(widget.product);
      } else {
        FavoritesScreen.removeFavorite(widget.product);
      }
    });
  }

  void addToCart() {
    CartWidget.addProduct(widget.product);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Cart_view()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(product: widget.product),
            ),
          );
        },
        child: Card(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0.sp), // Responsive radius
          ),
          elevation: 8, // Increased elevation for more depth
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w), // Responsive margin
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.0.sp)), // Responsive radius
                    child: Image.network(
                      widget.product.thumbnail ?? 'https://via.placeholder.com/150',
                      height: 140.h, // Responsive height
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: ValueListenableBuilder<List<Products>>(
                      valueListenable: FavoritesScreen.favoriteProductsNotifier,
                      builder: (context, favoriteProducts, child) {
                        final isFavorite = favoriteProducts.contains(widget.product);
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            toggleFavorite();
                            FavoritesScreen.favoriteProductsNotifier.notifyListeners();
                          },
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0.sp)), // Responsive radius
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.h), // Responsive padding
                      child: Center(
                        child: Text(
                          widget.product.title ?? 'Product Title',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp, // Responsive font size
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(12.0.sp), // Responsive padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                            (index) => Icon(
                          index < (widget.product.rating ?? 0).toInt()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.orange,
                          size: 20.sp, // Responsive icon size
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h), // Responsive height
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_cart, color: Colors.red, size: 25,),
                          onPressed: addToCart,
                        ),
                        Text(
                          '\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),


                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
