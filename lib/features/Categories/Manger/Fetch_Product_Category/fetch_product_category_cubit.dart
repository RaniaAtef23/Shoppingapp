
import 'package:bloc/bloc.dart';

import 'package:shopping_app/features/Home/data/repo/home_repo.dart';

import 'fetch_product_category_state.dart';




class ProductCategoryCubit extends Cubit<ProductCategoryState> {
  final HomeRepo homeRepo;
  final String category;

  ProductCategoryCubit(this.homeRepo, this.category) : super(ProductCategoryInitial());

  Future<void> FetchProductCategory() async {
    emit(ProductCategoryLoading());
    final result = await homeRepo.FetchProductCategory(category);
    result.fold(
          (failure) => emit(ProductCategoryFailure(failure.error)),
          (products) => emit(ProductCategorySuccess(products)),
    );
  }

}