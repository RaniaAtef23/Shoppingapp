import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_router.dart';
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
        Navigator.pushNamed(
          context,
          Routes.detailsScreen,
          arguments: widget.product,
        );
      },

        child: Container(
          width: 160.w,
          height: 260.h, // Adjusted height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.orange[100],
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [

                     Padding(
                       padding:  EdgeInsets.only(top: 10.h),
                       child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.product.thumbnail ?? 'https://via.placeholder.com/100',
                          height: 200.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Icon(Icons.error, color: Colors.red, size: 20),
                          ),
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
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Text(
                        widget.product.title ?? 'Product',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    SizedBox(height: 4.h),
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
                      child: Text(
                        '\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
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
