import 'package:dartz/dartz.dart';
import 'package:shopping_app/features/Home/data/models/Products.dart';
import 'package:shopping_app/features/Home/data/repo/home_repo.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/errors/failers.dart';

class RepoHomeImpl extends HomeRepo {
  final api_service apiService;

  RepoHomeImpl({required this.apiService});

  @override
  Future<Either<failers, List<Products>>> FetchProduct({int limit = 10, int skip = 0}) async {
    try {
      final endpoint = 'products?limit=$limit&skip=$skip'; // Endpoint with pagination
      var data = await apiService.getdata(endpoint: endpoint);

      if (data["products"] == null) {
        return left(server_error(error: 'Invalid response format'));
      }

      List<Products> productData = [];
      for (var i in data["products"]) {
        if (i != null) {
          productData.add(Products.fromJson(i));
        }
      }
      return right(productData);
    } catch (e) {
      return left(server_error(error: e.toString()));
    }
  }

  @override
  Future<Either<failers, List<Products>>> FetchProductCategory(String category, {int limit = 10, int skip = 0}) async {
    try {
      final endpoint = 'products/category/$category?limit=$limit&skip=$skip';
      var data = await apiService.getdata(endpoint: endpoint);

      if (data["products"] == null) {
        return left(server_error(error: 'Invalid response format'));
      }

      List<Products> productData = [];
      for (var i in data["products"]) {
        if (i != null) {
          productData.add(Products.fromJson(i));
        }
      }
      return right(productData);
    } catch (e) {
      return left(server_error(error: e.toString()));
    }
  }
}
