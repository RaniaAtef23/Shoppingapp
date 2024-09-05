import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/features/Home/data/models/Products.dart';
import 'package:shopping_app/features/Home/data/repo/home_repo.dart';
import 'package:shopping_app/features/Home/presentation/Manager/Fetch_Product/fetch_product_state.dart';


class FetchProductCubit extends Cubit<FetchProductState> {
  final HomeRepo homeRepo;

  List<Products>? _popularProducts;
  List<Products>? _flashSaleProducts;
  List<Products>? _moreProducts;

  FetchProductCubit(this.homeRepo) : super(FetchProductInitial());

  void fetchPopularProducts() async {
    emit(FetchProductLoading());

    var result = await homeRepo.FetchProduct(limit: 10, skip: 0);
    result.fold(
          (failure) => emit(FetchProductFailure(failure.error)),
          (products) {
        _popularProducts = products;
        if (_flashSaleProducts != null) {
          emit(FetchProductSuccess(popularProducts: _popularProducts!, flashSaleProducts: _flashSaleProducts!,moreproducts:_moreProducts! ));
        }
      },
    );
  }

  void fetchFlashSaleProducts() async {
    emit(FetchProductLoading());

    var result2 = await homeRepo.FetchProduct(limit: 10, skip: 10);
    result2.fold(
          (failure) => emit(FetchProductFailure(failure.error)),
          (products) {
        _flashSaleProducts = products;
        if (_popularProducts != null) {
          emit(FetchProductSuccess(popularProducts: _popularProducts!, flashSaleProducts: _flashSaleProducts!,moreproducts: _moreProducts!));
        }
      },
    );
  }
  void fetchmoreProducts() async {
    emit(FetchProductLoading());

    var result2 = await homeRepo.FetchProduct(limit: 20, skip: 0);
    result2.fold(
          (failure) => emit(FetchProductFailure(failure.error)),
          (products) {
        _moreProducts = products;
        if (_popularProducts != null) {
          emit(FetchProductSuccess(popularProducts: _popularProducts!, flashSaleProducts: _flashSaleProducts!,moreproducts: _moreProducts!));
        }
      },
    );
  }

  void fetchProducts() {
    fetchPopularProducts();
    fetchFlashSaleProducts();
    fetchmoreProducts();
  }
}
