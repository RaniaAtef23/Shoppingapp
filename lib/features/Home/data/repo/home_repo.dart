

import 'package:dartz/dartz.dart';
import 'package:shopping_app/features/Home/data/models/Products.dart';

import '../../../../core/errors/failers.dart';

abstract class HomeRepo {
  Future<Either<failers, List<Products>>> FetchProduct({int limit, int skip});
  Future<Either<failers, List<Products>>> FetchProductCategory(String category, {int limit, int skip});
}
