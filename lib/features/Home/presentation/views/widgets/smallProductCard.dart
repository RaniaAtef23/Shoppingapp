
import 'package:flutter/material.dart';
import 'package:shopping_app/features/Home/presentation/views/Screens/favoyrite_screen.dart';
import '../../../data/models/Products.dart';
import '../Screens/details_screen.dart';
class SmallProductCard extends StatefulWidget {
  final Products product;

  const SmallProductCard({super.key, required this.product});

  @override
  _SmallProductCardState createState() => _SmallProductCardState();
}

class _SmallProductCardState extends State<SmallProductCard> {
  void toggleFavorite() {
    setState(() {
      if (FavoritesScreen.favoriteProductsNotifier.value.contains(widget.product)) {
        FavoritesScreen.removeFavorite(widget.product);
      } else {
        FavoritesScreen.addFavorite(widget.product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        width: 160, // Smaller width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.orange[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // Shadow position
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                  child: Image.network(
                    widget.product.thumbnail ?? 'https://via.placeholder.com/100',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 20,
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.product.title ?? 'Product',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                          (index) => Icon(
                        index < (widget.product.rating ?? 0).toInt()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.orange,
                        size: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}