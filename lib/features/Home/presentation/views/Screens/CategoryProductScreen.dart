
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/network/service_locator.dart';
import 'package:shopping_app/features/Home/data/models/Category.dart';
import 'package:shopping_app/features/Home/presentation/Manager/Fetch_Product_Category/fetch_product_category_cubit.dart';
import 'package:shopping_app/features/Home/presentation/Manager/Fetch_Product_Category/fetch_product_category_state.dart';
import 'package:shopping_app/features/Home/presentation/views/widgets/ProductGridView.dart';
import '../../../data/repo/repo_imp.dart';

class CategoryProductsScreen extends StatefulWidget {
  final Category category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState(this.category);
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final Category category;

  _CategoryProductsScreenState(this.category);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:
        (context) => ProductCategoryCubit(getIt.get<RepoHomeImpl>(), category.name as String)..FetchProductCategory(),
      child:BlocBuilder<ProductCategoryCubit, ProductCategoryState>(
        builder: (context, state) {
          if (state is ProductCategorySuccess) {
            // Ensure state.products is not null
            if (state.products == null || state.products.isEmpty) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    widget.category.name,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.orange,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: Center(child: Text('No products available')),
              );
            }

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  widget.category.name,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
                centerTitle: true,
              ),
              body: ProductGridView(
                  products: state.products), // Pass data directly
            );
          } else if (state is ProductCategoryFailure) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  widget.category.name,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
                centerTitle: true,
              ),
              body: Center(child: Text("Error: ${state.error}")),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  widget.category.name,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
                centerTitle: true,
              ),
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ) ,);

  }
}