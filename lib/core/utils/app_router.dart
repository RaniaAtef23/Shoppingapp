import 'package:flutter/material.dart';
import '../../features/CartFavoriteItems/presentation/views/cart_view.dart';
import '../../features/CartFavoriteItems/presentation/views/favoyrite_screen.dart';
import '../../features/Categories/views/CategoryScreen.dart';
import '../../features/Categories/data/models/Category.dart';
import '../../features/Home/data/models/Products.dart';
import '../../features/Categories/views/CategoryProductScreen.dart';
import '../../features/Home/presentation/views/HomeView.dart';
import '../../features/Home/presentation/views/MainScreen.dart';
import '../../features/Home/presentation/views/details_screen.dart';
import '../../features/Splash/presentation/views/Onboarding_view.dart';
import '../../features/Splash/presentation/views/Splash_view.dart';
import '../../features/authentication/create_account_view.dart';
import '../../features/authentication/login_view.dart';
class Routes {
  static const String splashView = '/';
  static const String onboardingView = '/onboarding';
  static const String mainScreen = '/main';
  static const String homeView = '/home';
  static const String categoryScreen = '/categories';
  static const String cartView = '/cart';
  static const String favoritesView = '/favorites';
  static const String createAccountView = '/createAccount';
  static const String loginView = '/login';
  static const String detailsScreen = '/details';
  static const String categoryProductsScreen = '/categoryProducts';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashView:
        return MaterialPageRoute(builder: (_) => const Splash_view());
      case onboardingView: // Added onboarding route case
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case categoryScreen:
        return MaterialPageRoute(builder: (_) => const CategoryScreen());
      case cartView:
        return MaterialPageRoute(builder: (_) => const Cart_view());
      case favoritesView:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      case createAccountView:
        return MaterialPageRoute(builder: (_) => const Create_account());
      case loginView:
        return MaterialPageRoute(builder: (_) => const Login_view());
      case detailsScreen:
        final product = settings.arguments as Products;
        return MaterialPageRoute(
            builder: (_) => DetailsScreen(product: product));
      case categoryProductsScreen:
        final category = settings.arguments as Category;
        return MaterialPageRoute(
            builder: (_) => CategoryProductsScreen(category: category));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Unknown Route')),
          ),
        );
    }
  }
}
