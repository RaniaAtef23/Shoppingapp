import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import screen utilities
import 'package:shopping_app/core/network/service_locator.dart';
import 'package:shopping_app/features/Home/data/models/Category.dart';
import 'package:shopping_app/features/Home/presentation/views/widgets/ProductGridView.dart';

import '../../../Categories/Manger/Fetch_Product_Category/fetch_product_category_cubit.dart';
import '../../../Categories/Manger/Fetch_Product_Category/fetch_product_category_state.dart';
import '../../data/repo/repo_imp.dart';

class CategoryProductsScreen extends StatefulWidget {
  final Category category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCategoryCubit(getIt.get<RepoHomeImpl>(), widget.category.name)..FetchProductCategory(),
      child: BlocBuilder<ProductCategoryCubit, ProductCategoryState>(
        builder: (context, state) {
          // Common AppBar
          final appBar = AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              widget.category.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.orange,
                fontSize: 20.sp, // Responsive font size
              ),
            ),
            centerTitle: true,
          );

          if (state is ProductCategorySuccess) {
            // Ensure state.products is not null
            if (state.products.isEmpty) {
              return Scaffold(
                appBar: appBar,
                body: const Center(child: Text('No products available')),
              );
            }

            return Scaffold(
              appBar: appBar,
              body: ProductGridView(
                products: state.products,
              ), // Pass data directly
            );
          } else if (state is ProductCategoryFailure) {
            return Scaffold(
              appBar: appBar,
              body: Center(child: Text("Error: ${state.error}")),
            );
          } else {
            return Scaffold(
              appBar: appBar,
              body: const Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
