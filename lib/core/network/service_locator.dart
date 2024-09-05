
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shopping_app/core/network/api_service.dart';
import 'package:shopping_app/features/Home/data/repo/repo_imp.dart';
final getIt = GetIt.instance;
void setup() {
  getIt.registerSingleton<api_service>(api_service(Dio()));
  getIt.registerSingleton<RepoHomeImpl>(RepoHomeImpl(apiService:getIt.get<api_service>() ));
}