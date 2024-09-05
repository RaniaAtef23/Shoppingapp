
import 'package:flutter/material.dart';
import 'package:shopping_app/features/Home/presentation/views/Screens/favoyrite_screen.dart';
import '../../../data/models/Products.dart';
import '../Screens/details_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: Colors.white,
          elevation: 4, // Reduced elevation for a more subtle shadow
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                    child: Image.network(
                      widget.product.thumbnail ?? 'https://via.placeholder.com/150',
                      height: 180,
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
                    top: 8,
                    right: 8,
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
                      color: Colors.black.withOpacity(0.6),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          widget.product.title ?? 'Product Title',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
                padding: const EdgeInsets.all(12.0),
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
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
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