import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../CartFavoriteItems/presentation/views/widgets/favorite_product_notifier.dart';
import '../../../data/models/Products.dart';
import '../details_screen.dart';

class SmallProductCard extends StatefulWidget {
  final Products product;

  const SmallProductCard({super.key, required this.product});

  @override
  _SmallProductCardState createState() => _SmallProductCardState();
}

class _SmallProductCardState extends State<SmallProductCard> {
  void toggleFavorite() {
    setState(() {
      if (FavoriteProductNotifier.favoriteProductsNotifier.value.contains(widget.product)) {
        FavoriteProductNotifier.removeFavorite(widget.product);
      } else {
        FavoriteProductNotifier.addFavorite(widget.product);
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
        width: 160.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.orange[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1.r,
              blurRadius: 2.r,
              offset: Offset(0, 1.h),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                  child: Image.network(
                    widget.product.thumbnail ?? 'https://via.placeholder.com/100',
                    height: 110.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(Icons.error, color: Colors.red, size: 20.sp),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: ValueListenableBuilder<List<Products>>(
                    valueListenable: FavoriteProductNotifier.favoriteProductsNotifier,
                    builder: (context, favoriteProducts, child) {
                      final isFavorite = favoriteProducts.contains(widget.product);
                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: 24.sp,
                        ),
                        onPressed: toggleFavorite,
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.product.title ?? 'Product',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
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
                  SizedBox(height: 4.h),
                  Text(
                    '\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
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